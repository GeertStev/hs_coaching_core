# Prompts voor Claude Code – per fase

Werkwijze:
- **Eén fase per sessie** (of `/clear` tussen de fases); de context zit in de md-bestanden, niet in de chat.
- Start elke fase in **plan mode** (Shift+Tab); keur het plan goed vóór er code komt.
- Commit na elke fase op een eigen branch (`feat/uwh-engine`, …).

---

## Fase 0 – Verkenning en plan (plan mode, geen code)

```
Lees CLAUDE.md en alle bestanden in docs/uwh/. De bron-PDF staat in docs/uwh/reference/ – raadpleeg die alleen als een spec onduidelijk is.

Verken daarna de drie packages (hs_coaching_core, hs_coaching_app, hs_coaching_screen):
- state management (Provider/Riverpod/…), het repository-patroon, de mapstructuur
- hoe de bestaande chronometer RTDB .info/serverTimeOffset gebruikt
- de Firebase-structuur (RTDB en/of Firestore) en de security rules
- testopzet en lint-regels
- hoe het trainingsmodel de werkelijk gelopen tijden opslaat (relevant voor 05)

Lever:
1. Een korte samenvatting van de bestaande architectuur en de conventies die ik moet volgen.
2. Waar 02-match-engine.md botst met de bestaande code (naamgeving, paden, sync), met een voorstel per botsing.
3. Een plan voor fase 1 met de bestands- en mappenlijst.
4. Vragen die ik moet beantwoorden. Herhaal de punten uit open-vragen.md niet, tenzij de code er nieuw licht op werpt.

Schrijf geen code.
```

## Fase 1 – Match engine + tests (hs_coaching_core)

```
Implementeer de match engine volgens docs/uwh/02-match-engine.md in hs_coaching_core, als pure Dart.

Volgorde:
1. Schrijf eerst alle acceptatietests uit §7 die pure engine-tests zijn: T1–T14, T16, T17 en T19–T22 (T15 en T18 horen bij fase 2) uit §7 (ze falen), plus tests voor de validaties uit 01-regels-domein.md §2 en §4. Gebruik in elke testnaam het CMAS-regelnummer.
2. Werk daarna MatchConfig, de sealed MatchEvent-klassen (met JSON-serialisatie), MatchState en de reducer uit.
3. ClockView: een pure functie (MatchState, int nowServerMs) -> resterende periodetijd, strafklokken, aftellingen voor time-out en goal-herstart, en de vlaggen periodExpired / stoppedClockMode.
4. Een validator die een kandidaat-event weigert met een getypeerde reden (bv. TimeOutNotAllowed.playRunning), zodat de UI die reden kan tonen.
5. De overtredingentabel 17.7.1 als assets/infringements_v13.json, met een functie suggestPenalty(state, team, cap, code, deliberate).

Gebruik een fake clock in de tests; nergens DateTime.now() in de engine. Hardcode geen 15, 3, 2 of 5 minuten: alles komt uit MatchConfig (controleer dat met een grep). Er zijn geen wisselevents en geen assists (OPEN-4 en OPEN-7).
Open punten: implementeer ze als een policy-enum met de default uit open-vragen.md en markeer ze met // OPEN-x.
Stop als alle tests groen zijn, en geef me een overzicht van de beslissingen die je onderweg nam.
```

> Tip: `infringements_v13.json` laat je best apart genereren en daarna zelf naast de PDF-tabel (p. 48) nalezen. Het is de foutgevoeligste stap.

## Fase 2 – Sync-laag (Firebase)

```
Implementeer een MatchRepository-interface in hs_coaching_core en een Firebase-implementatie op de plek waar de bestaande repositories leven.
- Paden volgens het voorstel uit fase 0.
- append(event): transactie op meta/lastSeq; de eventtijd = lokale tik + serverTimeOffset (hergebruik de bestaande offset-logica, schrijf ze niet opnieuw).
- watch(matchId): Stream<MatchState> (lokaal reduceren).
- Offline wachtrij met behoud van de oorspronkelijke tijd van de tik.
- Writer lease per wedstrijd (matches/{id}/lease): één tafeltoestel schrijft, overname vraagt bevestiging (02 §6a).
- Security rules: rollen uit 03-wedstrijdtafel-ui.md §3, events append-only (geen update of delete).
- Fields: max. één live wedstrijd per veld, via een transactie op fields/{fieldId}/liveMatchId.
Voeg integratietests toe met de Firebase-emulator voor T15 (lease: een tweede toestel wordt geweigerd, expliciete overname werkt) en T18 (veldconflict), plus een test met 3 gelijktijdige wedstrijden.
```

## Fase 3 – Wedstrijdtafel-UI (hs_coaching_app)

```
Bouw de wedstrijdtafel volgens docs/uwh/03-wedstrijdtafel-ui.md §1–§3, met de bestaande state management en navigatie.
- Eerst de live console, met fake data uit de engine (geen Firebase), zodat ik de flow kan testen.
- Elke knop roept de validator aan; geweigerde acties zijn grijs, en een lange druk toont de reden.
- Undo via EventVoided vanuit de eventlog.
- Liggend formaat, wakelock, haptische en audio-hints.
- Daarna de voorbereidings- en afsluitschermen, met export van het wedstrijdverslag als PDF.
Bouw ook de invoer van de afstandsbediening volgens 03 §5: globale handler die de toetsen consumeert, toetsen leren, debounce, een remote-test op het voorbereidingsscherm. Unit tests op de mapping van toets naar event (ook herhaalde toetsen en 'geen wedstrijd live'). Het testen met de echte afstandsbediening doe ik zelf; zeg me waar ik moet letten.
Widgettests voor: een goal registreren, een straf met kapnummer, een geweigerde time-out, undo.
```

## Fase 4 – Scorebord (hs_coaching_screen)

```
Bouw de read-only layouts matchScoreboard en fieldScoreboard volgens 03-wedstrijdtafel-ui.md §4 en §4.1. Ze moeten resolutie-onafhankelijk zijn; test op 624x416 en 1920x1080.
- Gebruik dezelfde reducer en ClockView uit hs_coaching_core; herteken de klok met een Ticker, maar bereken de tijd altijd uit ClockView.
- Toon een time-out-aftelling, strafklokken (max. 3 per team, daarna "+n") en de kanten volgens de huidige periode.
- Kleuren en typografie zijn voorlopig: zet ze centraal in één theme-bestand.
Pas ook de Python-kioskcontroller aan: een ICS-item met de tag [UWH-MATCH:<id>] of [UWH-FIELD:<id>] opent de juiste route (alleen voor het clubdisplay).
```

## Fase 5 – Toernooimodule

```
Lees docs/uwh/04-toernooi.md. Maak eerst in plan mode een voorstel voor het datamodel en de schemagenerator, en wacht op mijn akkoord.
Daarna: model + generator + klassement (met tests voor de tiebreakregels en voor forfaits), dan de UI.
De match engine verandert niet. Het toernooi maakt matches aan met de juiste MatchConfig (requiresWinner), tournamentId en fieldId, en leest MatchState voor het klassement.
Implementeer ook de configuratie per fase en de planner volgens 04 §1: presets, resolutie toernooi → fase → wedstrijd, de snapshot in MatchCreated, slotduur uit de config en de berekening 'past het in de beschikbare zwembadtijd?'. Schrijf tests voor de resolutie en de slotduur.
Let in de schemagenerator op parallelle velden (04 §3): geen team en geen official op twee velden in hetzelfde slot. Schrijf daar property-based of tabelgedreven tests voor.
Daarna in de console: veldbinding (03 §1), zodat de volgende wedstrijd op het veld automatisch geladen wordt.
```

## Fase 5b – Toernooischermen

```
Bouw volgens 03 §4/§4.2 en 04 §4:
1. De Display-entiteit + de koppelflow (/display toont een koppelcode; de admin koppelt in de app en kiest de layout; het scherm wisselt live).
2. De layouts multiFieldOverview, standings, schedule en rotation.
3. Een admin-overzicht van de schermen met online-status (lastSeen) en een herlaadknop.
Elk scherm reduceert zelf de event logs van de live wedstrijden; bouw nog geen server-side projectie.
Test multiFieldOverview met 3 gesimuleerde live wedstrijden (een script dat events afspeelt), zodat ik het zonder zwembad kan bekijken.
```

## Fase 6 – Spelersstatistieken

```
Lees docs/uwh/05-spelersstatistieken.md. Controleer eerst of het trainingsmodel werkelijke tijden opslaat, en rapporteer dat vóór je iets bouwt.
Statistieken zijn pure functies over de event logs (in hs_coaching_core) en hebben unit tests. Daarna volgen de schermen "Mijn toernooi" en "Statistieken".
```
