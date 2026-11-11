# Match engine – ontwerp (hs_coaching_core)

Doel: één **pure Dart** wedstrijdmotor zonder Flutter- of Firebase-imports. Wedstrijdtafel, scorebord (hs_coaching_screen), wedstrijdverslag, toernooiklassement en spelersstatistieken lezen allemaal dezelfde bron.

## 1. Principe: append-only event log

```
MatchConfig + List<MatchEvent>  --reduce-->  MatchState
MatchState + now (server-time)  --derive-->  ClockView (resterende tijd, strafklokken, aftellingen)
```

- Events zijn **onveranderlijk**. Je corrigeert met `EventVoided(targetEventId, reason)`; de reducer slaat ongeldig gemaakte events dan over. Zo blijft de audit trail volledig (die is nodig voor het verslag en voor protesten).
- Elk event krijgt: `id` (uuid), `seq` (monotoon oplopend per wedstrijd), `serverTs` (ms, server-tijd via de bestaande `.info/serverTimeOffset`), `deviceId`, `author` (rol en gebruiker) en `source ∈ {screen, remote}` (de afstandsbediening van de hoofdscheidsrechter is een invoermethode van het tafeltoestel, geen aparte gebruiker; zie 03 §5).
- **Klokken worden nooit "getickt" of opgeslagen.** De resterende tijd wordt berekend uit de events en `now`. Elke client (tafel, scorebord, spelersapp) berekent dezelfde waarde.
- De reducer is deterministisch: zelfde events geven dezelfde state. Daarmee is de engine met unit tests volledig te testen.

## 2. MatchConfig

```dart
class MatchConfig {
  final Duration periodLength;        // 15:00
  final Duration halfTimeBreak;       // 3:00
  final bool requiresWinner;          // poule=false, knock-out=true
  final Duration overtimeBreak;       // 3:00
  final Duration overtimePeriod;      // 5:00
  final Duration overtimeInterval;    // 1:00
  final Duration suddenDeathBreak;    // 1:00
  final Duration stoppedClockWindow;  // 2:00 (14.2.3.1)
  final Duration teamTimeOutLength;   // 1:00
  final Duration timeOutWarningAt;    // 0:45
  final Duration periodStartWarning;  // 0:30
  final Duration goalRestartMax;      // 0:30
  final int timeOutsPerTeamPerHalf;   // 1
  final PenaltyClockPolicy penaltyClockPolicy; // zie OPEN-2
  final String rulesVersion;          // "CMAS-13.0"
  final Set<Phase> stoppedClockPhases; // default {p2, ot2, suddenDeath} (OPEN-1)
  final int overtimePeriods;          // 2 (CMAS) of 0; enkel relevant als requiresWinner
  final bool suddenDeathEnabled;      // true; zie OPEN-10
  final String presetName;            // vrij label, enkel voor weergave
}
```

Alle waarden zijn **configureerbaar**, met als default CMAS v13. Toernooien wijken regelmatig af (kortere periodes in functie van de beschikbare zwembadtijd), zelfs binnen één toernooi tussen de poulefase en de finales (OPEN-5). **De engine bevat dus nergens een hardgecodeerde 15, 3, 2 of 5**: alles komt uit `MatchConfig`.

De effectieve config wordt door de toernooimodule bepaald (04 §1: toernooi → fase → wedstrijd) en bij `MatchCreated` als **snapshot** in het event log opgeslagen. Een latere wijziging van een preset raakt lopende of afgelopen wedstrijden dus nooit.

## 3. Events (sealed class `MatchEvent`)

**Opbouw van de wedstrijd**
- `MatchCreated(config, teamWhite, teamBlack, startingEnds)`
- `RosterDeclared(team, players[{cap, name, role: C|VC|-}], staff[])`, mag max. 10 spelers bevatten (validatie)
- `OfficialsAssigned(chief, water[], timekeepers[])`

**Klok en fase**
- `PeriodWarningGiven(phase)` – 30 s signaal
- `PlayStarted(restartType)` – startsignaal van de CR; `restartType ∈ {endLineStart, equalPuck, advantagePuck(team), afterPenaltyShot, afterTimeOut}`
- `PlayStopped(reason)` – `reason ∈ {unspecified, goal, infringement, injury, confer, outOfBounds, penaltyShot, other}`; informatief, de klok hangt er niet van af (zie §5). De afstandsbediening geeft `unspecified`, en de tafel kan de reden achteraf aanvullen met `StopReasonSpecified(targetId, reason)`
- `OfficialsTimeOutStarted(reason)` / einde via `PlayStarted`
- `TeamTimeOutRequested(team)` → engine valideert de regels uit 01 §4
- `PeriodEnded(phase)` – gegenereerd door de tafel wanneer de klok op 0 staat (zie §5)

**Spelgebeurtenissen**
- `GoalScored(team, scorerCap?, kind: field|penaltyShot|penaltyGoal)` (geen assists, OPEN-7)
- `CautionGiven(team, cap?, infringementCode, deliberate, isTeamCaution)`
- `TimePenaltyGiven(team, cap, minutes: 1|2|5, infringementCode, deliberate)`
- `PlayerDismissed(team, cap, infringementCode)` / `OfficialDismissed(team, name)`
- `PenaltyShotAwarded(againstTeam)` / `PenaltyShotResolved(outcome: goal|defended, attackers[], defender?)`
- `PenaltyPlayerReturned(team, cap)` – de CR geeft terugkeer vrij
- `ProtestLogged(team, by, text)`
- `EventVoided(targetId, reason)`

**Afsluiting**
- `MatchEndedBySignOff(chiefSignature, waterSignatures[])` → `final`
- `ResultDecidedByDelegate(winner?, text)` – beslissing van de Technical Delegate (bv. winnaar zonder volledige overtime, OPEN-10)
- `MatchForfeited(team, decisionText)` / `MatchAbandoned(decisionText, resultOverride?)`

## 4. MatchState (afgeleid)

- `phase`: `notStarted → p1 → halfTime → p2 → (otBreak → ot1 → otInterval → ot2 → sdBreak → suddenDeath) → awaitingSignOff → final`
- `running: bool`, `runningSince: serverTs?`, `elapsedInPhase: Duration` (geaccumuleerd tot de laatste stop)
- `score{white, black}` en een lijst van goals
- `penalties[]` met `status ∈ {pending, running, paused, expiredWaiting, served, dismissal}`, `remaining` (berekend)
- `timeOutsUsed{team: {half: n}}`
- `pendingPenaltyShot: Team?`
- `activeTimeOut{kind, team?, startedAt}`
- `stoppedClockMode: bool` (binnen het venster van 14.2.3.1)

## 5. Klokregels die de engine zelf afdwingt

1. **Doorlopende klok**: bij `PlayStopped` blijft `running=true`, behalve in de onderstaande gevallen.
2. Wél stilzetten: `OfficialsTimeOutStarted`, `TeamTimeOutRequested` (als die geldig is), `PenaltyShotAwarded` (ook de strafklokken), en in `stoppedClockMode` elke onderbreking **waarin geen `GoalScored` van het type `field` of `penaltyGoal` valt**. De klok kijkt dus naar de inhoud van de onderbreking, niet naar het `reason`-veld. Gevolg: stopt de hoofdscheidsrechter via de afstandsbediening en registreert de scorer daarna een goal, dan loopt de klok terug mee alsof ze niet gestopt had. **Op het scherm springt de klok dan vooruit**; toon dit niet als fout. (Een goal uit een strafworp valt hier niet onder: bij een strafworp staan alle klokken stil, 17.8.7.)
3. **`stoppedClockMode`** is actief als `phase ∈ config.stoppedClockPhases` en de resterende tijd ≤ `config.stoppedClockWindow` (default 2:00), of als `phase == suddenDeath`.
4. **Automatische stop op 2:00** (14.2.3.2): als de klok tijdens een onderbreking ( `PlayStopped` zonder `PlayStarted`) in een fase uit `stoppedClockPhases` de grens van `stoppedClockWindow` (default 2:00) bereikt, rekent de engine alsof de klok **op exact 2:00** stilgezet werd. Dit is een **afgeleide** stop: er wordt geen event voor geschreven, de reducer berekent ze.
5. **Einde periode**: als de resterende tijd 0 is, toont de engine `periodExpired`; de tafel bevestigt met `PeriodEnded`. Uitzondering: een openstaande `pendingPenaltyShot` moet eerst gespeeld worden (17.8.6).
6. **Einde reguliere tijd**: bij gelijkspel en `requiresWinner=false` is de wedstrijd gedaan, anders volgt `otBreak`. Ook na ot2 bij gelijkspel volgt `sdBreak`. Met `overtimePeriods == 0` volgt direct `sdBreak`. Zijn overtime én sudden death uitgeschakeld en is een winnaar vereist, dan blokkeert de engine de afsluiting tot `ResultDecidedByDelegate` ingevoerd is (OPEN-10).
7. **Sudden death**: de eerste `GoalScored` beëindigt de wedstrijd.
8. **Team time-out**-validatie: de team time-out wordt geweigerd (met reden) als het spel loopt, als het team zijn time-out in deze helft al opgebruikt heeft, als we in overtime of sudden death zitten, of als er een strafworp openstaat. Een team time-out aaneenschakelen met een lopende time-out is wel toegelaten (14.2.6.5).
9. **Strafklokken**: een straf is `pending` tot de volgende `PlayStarted`, en volgt daarna de `PenaltyClockPolicy`. Bij `remaining == 0` terwijl het spel stilligt, wordt de status `expiredWaiting`.

## 6. Synchronisatie (Firebase)

- Pad (voorstel, af te stemmen op de bestaande structuur): `matches/{matchId}/events/{seq}` + `matches/{matchId}/meta`.
- Schrijven met een **transaction** op `meta/lastSeq` om dubbele seq te voorkomen bij twee tafeltoestellen.
- Clients luisteren naar `events` en reduceren lokaal. Het scorebord schrijft nooit.
- Offline: events lokaal in de wachtrij zetten met lokale tijd plus offset. Bij synchronisatie behoud je de oorspronkelijke tijdstempel (de **tik** is officieel, niet het moment van uploaden).
- Gebruik `ServerValue.timestamp` **niet** voor de tijd van een event: dat geeft het uploadmoment. Gebruik `localNow + serverTimeOffset` op het moment van de tik.

## 6a. Eén tafeltoestel, twee bedieners (OPEN-6)

- Per wedstrijd is er **één schrijvend toestel**: het tafeltoestel van de vierde scheidsrechter. De hoofdscheidsrechter bedient de tijd via een HID-afstandsbediening die aan **dat toestel** gekoppeld is (03 §5). Beide invoeren komen dus lokaal in dezelfde wachtrij, zonder concurrentie tussen bedieners.
- Vanuit de afstandsbediening komen enkel `PlayStarted`, `PlayStopped(unspecified)` en optioneel `OfficialsTimeOutStarted`, steeds met `source: remote`. Goals, straffen en alle andere events komen van het scherm.
- **Writer lease**: `matches/{matchId}/lease {deviceId, since}`. Een tweede toestel mag lezen maar niet schrijven. Overname (bv. lege batterij) kan alleen na een expliciete bevestiging op het nieuwe toestel. De `seq`-transactie blijft als vangnet tegen dubbele events bij herverbinden.

## 6b. Meerdere wedstrijden tegelijk

- Alle API's zijn per `matchId`. Er is geen singleton of globale "actieve wedstrijd" in providers of services. Een `MatchSession(matchId)` bevat de stream, de state en de validator.
- De wedstrijdtafel heeft precies één sessie open. Schermen kunnen er N tegelijk open hebben (bv. `multiFieldOverview` met 3).
- `MatchCreated` bevat `tournamentId?` en `fieldId?`; een losse oefenwedstrijd zonder toernooi blijft mogelijk.
- `serverTimeOffset` wordt één keer per toestel bepaald en door alle sessies gedeeld.

## 6c. Wissels worden niet geregistreerd (OPEN-4)

- Er zijn geen wisselevents en geen bijhouden van wie in het water zit. Het wedstrijdblad bevat wel nog de roster (`RosterDeclared`, max. 10).
- Overtredingen rond wissels (16.3.4, 15.2.x) bestaan alleen als gewone `TimePenaltyGiven` met een kapnummer. De engine controleert niet of er te veel spelers in het water zitten.
- Bij een strafworp valideert de engine enkel dat de gekozen spelers niet in de strafbank zitten en niet uitgesloten zijn (17.8.2.3).

## 7. Acceptatietests (moeten groen zijn vóór enige UI)

Schrijf ze als tabelgedreven tests (`test/match_engine/…`). Tijden zijn de resterende periodetijd.

| # | Scenario | Verwacht |
|---|---|---|
| T1 | P1 start, stop wegens overtreding op 10:00, herstart 20 s later | klok toont 9:40 bij de herstart (de klok liep door) |
| T2 | P2, stop op 2:10 wegens overtreding, 30 s geen herstart | klok blijft staan op **2:00** |
| T3 | P2 op 1:30, stop wegens overtreding | klok staat stil tot `PlayStarted` |
| T4 | P2 op 1:30, goal | klok loopt **door** |
| T5 | P1, team time-out terwijl het spel loopt | geweigerd |
| T6 | P1, tweede time-out van hetzelfde team | geweigerd; in P2 opnieuw 1 toegelaten |
| T7 | OT1, time-out gevraagd | geweigerd |
| T8 | 2 min straf gegeven tijdens een stop, herstart 40 s later | strafklok start bij de herstart, niet bij het geven |
| T9 | Strafworp toegekend met 0:03 resterend, klok loopt af | klokken staan stil; strafworp moet gespeeld worden, daarna eindigt de periode |
| T10 | Straf loopt af tijdens een stop | status `expiredWaiting` |
| T11 | Gelijkspel na P2, `requiresWinner=false` | `awaitingSignOff` |
| T12 | Gelijkspel na P2 en OT2, `requiresWinner=true` | `sdBreak` → `suddenDeath`; eerste goal → einde |
| T13 | Goal geregistreerd en daarna gevoid | score terug naar de vorige stand; het event blijft zichtbaar in het log |
| T14 | Roster met 11 spelers | validatiefout |
| T15 | (fase 2) Een tweede toestel zonder lease probeert te schrijven; daarna expliciete overname | eerste poging geweigerd, na overname lukt het; unieke, opeenvolgende seq; geen verloren of dubbel event |
| T16 | Officials' time-out in P1, goal toegekend na overleg | klok herstart bij de aankondiging (event `GoalScored` + `PlayStarted` op hetzelfde tijdstip) |
| T17 | 3 wedstrijden tegelijk met events door elkaar | elke state is identiek aan die van dezelfde wedstrijd apart gereduceerd; geen kruisbesmetting |
| T18 | Tweede wedstrijd op `live` zetten op een veld dat al een live wedstrijd heeft | geweigerd (repository-niveau, integratietest) |
| T19 | Config 2×10 min, OT uit, `stoppedClockWindow` 1:00 | alle klokregels (T1–T4, T11) volgen deze config; niets is hardgecodeerd |
| T20 | P2 op 1:30: `PlayStopped(unspecified)`, 10 s later `GoalScored`, dan `PlayStarted` | de klok liep die 10 s door (het resultaat springt vooruit bij het goal-event) |
| T21 | P2 op 1:30: `PlayStopped(unspecified)`, geen goal, 10 s later `PlayStarted` | de klok stond stil; de herstart op 1:30 |
| T22 | `requiresWinner`, `overtimePeriods = 0`, gelijkspel | direct `sdBreak` → `suddenDeath`; met sudden death uit blokkeert de afsluiting tot `ResultDecidedByDelegate` |
