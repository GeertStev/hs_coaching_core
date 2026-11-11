# Wedstrijdtafel (hs_coaching_app) en scorebord (hs_coaching_screen)

## 1. Context van de gebruiker

- **Twee bedieners, één toestel per veld.** De **hoofdscheidsrechter** (aan de kant) bedient de tijd met een afstandsbediening (§5). De **vierde scheidsrechter** (rol `tableOfficial` = scorer uit 4.4) bedient het scherm: goals, straffen, time-outs, correcties.
- **Veldbinding**: bij het opstarten kiest de vierde scheidsrechter toernooi + **veld**. De console laadt dan automatisch de volgende geplande wedstrijd op dat veld (met bevestiging), zodat er niet per wedstrijd gezocht moet worden. Op een BK lopen tot 3 consoles tegelijk, elk op hun eigen veld.
- Natte handen, lawaai, de blik op het water. Elke actie moet **één tik** zijn en meteen omkeerbaar (undo = `EventVoided`).
- De klokknoppen zijn **groot** (min. 64 dp) en staan op een vaste plek; de scoreknoppen staan links/rechts volgens de **kant waarop het team speelt**. Na de rust wisselen ze van kant (14.2.2).
- Liggend formaat (tablet of telefoon op de tafel). Het scherm blijft aan (wakelock).
- Audio en trillen: 30 s-waarschuwing, de 0:45-waarschuwing bij een time-out, het einde van een straf, het einde van een periode. Het officiële geluidssignaal geeft de CR met zijn eigen toestel; de app geeft enkel **hints** aan de tafel.

## 2. Schermen

1. **Voorbereiding** – teams kiezen (wit/zwart), roster afvinken (max. 10, C/VC), officials invullen, de **effectieve configuratie** groot tonen en expliciet laten bevestigen (bv. "2 × 12 min, rust 2 min, overtime uit, 1 time-out per helft" plus `requiresWinner`), want die kan per toernooifase verschillen (04 §1). Hier staat ook de **test van de afstandsbediening** (§5).
2. **Live console**
   - Boven: fase, grote klok, indicator "stopped-clock mode", score.
   - Midden: `START` / `STOP` (back-up voor de afstandsbediening; de reden is niet nodig voor de klok en kan achteraf in de eventlog ingevuld worden), knoppen `GOAL wit` / `GOAL zwart` (daarna een optioneel kapnummer via een nummerpad 1–15).
   - Strafbalk per team: actieve strafklokken met kapnummer en resterende tijd. Een straf in de status `expiredWaiting` licht op ("vrijgeven na puckcontact"), en met een tik registreer je `PenaltyPlayerReturned`.
   - Knop `STRAF`: team → kapnummer → type (caution / 1 / 2 / 5 / uitsluiting) → overtreding (16.3.x, met de handsignaalnaam). De suggestie uit tabel 17.7.1 staat bovenaan, maar je kunt altijd iets anders kiezen.
   - Knoppen `TIME-OUT wit/zwart` (grijs als dat niet toegelaten is, met de reden bij een lange druk) en `OFFICIALS T/O`.
   - Knop `STRAFWORP` → klokken stil → uitkomst `goal` / `verdedigd`.
   - Een eventlog die je onderaan opentrekt, met een undo per regel.
3. **Afsluiting** – samenvatting, protesten en dismissals (met een verplicht verslagveld, 17.4.4), handtekeningen van CR en water referees, export als PDF-wedstrijdverslag.

## 3. Rechten

| Rol | Mag |
|---|---|
| `tableOfficial` | alle events in een toegewezen wedstrijd |
| `chiefReferee` | idem + sign-off, op het toestel van de tafel; de afstandsbediening is een invoermethode van dat toestel, geen aparte login |
| `coach/speler` | enkel lezen |
| `tournamentAdmin` | alles + forfait/staking + correcties na `final` (met audit) |

Dwing dit af in de Firebase security rules, niet alleen in de UI.

## 4. Schermen (hs_coaching_screen) – alle read-only

Alle schermen lezen alleen en gebruiken hetzelfde reduce-pad als de app (via hs_coaching_core). Een scherm is een **`Display`** met een layout; zie 04-toernooi.md §4 voor de toewijzing. Layouts zijn **resolutie-onafhankelijk** (schalen op de schermgrootte); 624×416 is één doelresolutie, een groot toernooischerm of tv (1920×1080) een andere.

| Layout | Inhoud | Typisch scherm |
|---|---|---|
| `matchScoreboard(matchId)` of `fieldScoreboard(fieldId)` | één wedstrijd in detail (zie 4.1) | het zwembaddisplay (624×416), optioneel één per veld |
| `multiFieldOverview(tournamentId)` | alle velden naast elkaar: per veld teams, score, klok, fase, aantal actieve straffen; eronder de volgende wedstrijd per veld met het (verwachte) startuur | **het grote toernooischerm** |
| `standings(tournamentId, division/group?)` | live klassement, roteert automatisch tussen poules of divisies als ze niet op één scherm passen | tv's |
| `schedule(tournamentId)` | komende wedstrijden + uitslagen van de recentste wedstrijden | tv's |
| `rotation([layouts], interval)` | wisselt tussen layouts | tv's |

`fieldScoreboard(fieldId)` volgt automatisch de live of eerstvolgende wedstrijd op dat veld; er is geen manuele omschakeling per wedstrijd nodig.

### 4.1 Detailscorebord van één wedstrijd
- Layout: teamnamen (wit links/zwart rechts volgens de huidige kant), een grote score, een grote klok, de fase, de strafklokken per team (kap + tijd, max. 3 zichtbaar, daarna "+n"). Bij een team time-out vervangt een aftelling de klok.
- Tussen twee wedstrijden: "Volgende wedstrijd" (uit de toernooimodule) of het lopende klassement.
- Leesbaar vanuit het water: hoog contrast, minimale tekst, de klok neemt ≥ 35 % van de hoogte in.
- Kleuren en typografie zijn voorlopig; later stem je ze af op het stijlbestand van de app (zelfde aanpak als bij het trainingsdisplay).
- Het zwembaddisplay in de eigen club gebruikt de kioskcontroller (Python, ICS): een kalenderitem met een tag opent de route `fieldScoreboard` of `matchScoreboard`. **Op toernooien** worden de schermen centraal gestuurd (04 §4) in plaats van via ICS.

### 4.2 Multi-field overview (groot scherm)
- Er zijn 1 tot 3 velden (configureerbaar, kolommen of rijen naargelang de verhouding van het scherm). Per veld: veldnaam, teams, een grote score, een klok, de fase (P1/rust/P2/OT/SD), een time-out-indicator en het aantal straffen als icoontjes.
- Een veld zonder live wedstrijd toont "Volgende: A – B om 14:35 (verwacht 14:42)".
- Een goal geeft kort een highlight op dat veld (2–3 s), zodat het publiek ziet waar er gescoord werd.
- De klokken lopen per veld onafhankelijk; elke kolom berekent zijn eigen `ClockView`.

## 5. Afstandsbediening van de hoofdscheidsrechter (HID)

- De afstandsbediening is een Bluetooth-toetsenbord (HID). De koppeling gebeurt in het besturingssysteem; de app ziet alleen toetsen.
- **Globale handler** (`HardwareKeyboard.instance.addHandler`) in plaats van focusgebaseerd. De toetsen die aan een actie toegewezen zijn, worden **geconsumeerd**, anders activeren Enter en Spatie een knop die toevallig focus heeft.
- **Toetsen leren**: bij de voorbereiding druk je op "toewijzen" en daarna op de knop van de afstandsbediening. De mapping wordt per toestel bewaard:
  - Eén toets: wisselknop. Loopt het spel, dan geeft ze `PlayStopped(unspecified)`; staat het stil, dan `PlayStarted(restartType)` met het type dat de tafel op het scherm voorgekozen heeft.
  - Twee of meer toetsen: aparte start- en stoptoets, plus optioneel officials' time-out.
- **Bescherming**: negeer toetsherhalingen en indrukken binnen 250 ms van de vorige; negeer alles als er geen wedstrijd `live` is of de console niet op de voorgrond staat; negeer tijdens `awaitingSignOff`. Elk event krijgt `source: remote`.
- **Risico van de wisselknop**: een gemiste of dubbele indruk keert de toestand om. Daarom een grote indicator RUNNING (groen) / STOPPED (rood), trillen of een pieptoon bij elke aanvaarde indruk, een teller "laatste afstandsbediening: 12:03:41", en de START/STOP-knoppen op het scherm als back-up. Heeft de afstandsbediening twee knoppen, gebruik dan aparte start- en stoptoetsen.
- **Tijdstip**: het officiële moment is de indruk (lokale tijd + serverTimeOffset). Bluetooth-vertraging van enkele tientallen ms is aanvaardbaar.
- **Geluidssignaal**: het officiële signaal (15.1.8, 15.3.4) komt van het geluidssysteem van de hoofdscheidsrechter. De app maakt dat niet; het is alleen een hint aan de tafel (OPEN-9).
- Schermvergrendeling of uitgeschakeld scherm blokkeert de toetsen: wakelock aan, en test met de echte afstandsbediening vóór je erop vertrouwt.
