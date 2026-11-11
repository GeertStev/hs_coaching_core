# Toernooimodule (fase 2 – wordt verfijnd zodra de match engine stabiel is)

## 1. Model

- `Tournament(id, name, dates, venue, substitutionMethod: deck|inWater|endLine, rulesVersion, matchConfigDefaults)` – één wisselmethode per toernooi (15.2).
- `Division` → `Team` → `Squad` (max. 12, unieke kapnummers 1–15, één selectie per team, 3.1.1; vervanging enkel met een medisch attest, 3.1.3).
- `Stage`: `roundRobin(groups)` | `knockout(bracket)` | `placement`, met een eigen `matchConfig`, `changeoverBuffer` en klassementsregels (de poulefase en de finales mogen dus verschillen).
- `Field` (bad of speelveld) + `TimeSlot`s.
- `Match(tournamentId, stageId, fieldId, scheduledStart, white, black, officials, requiresWinner, `configOverride?`, status)` → koppelt aan de match engine via `matchId`.
- Statussen: `scheduled → ready → live → awaitingSignOff → final` | `forfeited` | `abandoned`.

### Configuratie en slotduur (OPEN-5)

- **Effectieve config** = toernooi-standaard → `Stage.matchConfig` → `Match.configOverride`, waarbij het meest specifieke wint. Ze wordt als snapshot in `MatchCreated` gezet als de wedstrijd `ready` wordt; tot `live` mag de beheerder ze nog wijzigen, daarna is ze bevroren.
- **Presets**: de beheerder maakt zelf presets (bv. "CMAS standaard 2×15"; eigen varianten zoals een kortere poulefase). De app levert enkel "CMAS standaard" mee en bedenkt geen Belgische formats.
- **Slotduur wordt berekend** uit de config: periodes + rust + `changeoverBuffer` (tijd tussen twee wedstrijden op een veld). Bij `requiresWinner` kies je of de planning ruimte voor overtime meerekent (aanbevolen voor finales).
- **Zwembadtijd-planner**: de beheerder geeft per veld de beschikbare tijd (bv. 08:30–18:00). De app rekent uit of het schema met de gekozen config past en toont de marge. Past het niet, dan toont ze wat wel past (bv. "met 2×12 min past het, met 2×15 min niet"). Dat is een berekening, geen automatische keuze.

## 2. Functies

1. **Schemagenerator**: round-robin (circle method), met een minimum aantal rustslots per team tussen twee wedstrijden en een evenwichtige verdeling wit/zwart. Een slot = berekend uit de effectieve config van de fase + `changeoverBuffer` (zie hierboven).
2. **Toewijzing van scheidsrechters**: geen official in een wedstrijd van zijn eigen team (of van een team uit dezelfde poule, optioneel), en een evenwichtige verdeling van de belasting.
3. **Klassement** (configureerbaar): punten W/G/V (default 3/1/0), daarna doelsaldo, gescoorde goals en onderling resultaat. Een forfait krijgt een configureerbare score (bv. 0–5).
4. **Knock-out**: de bracket vult zich automatisch uit het eindklassement van de poules; `requiresWinner=true`.
5. **Vertraging**: als een wedstrijd uitloopt, schuiven alle volgende slots op hetzelfde veld op, en zie je een "verwacht startuur".
6. **Forfait-knop** wordt actief 2:00 na het geplande startuur (5.3.1). Het resultaat volgt uit de beslissing van de Technical Delegate (vrij tekstveld + resultaat).
7. **Tuchtjury**: de dismissal-rapporten (17.4.4) komen in een lijst per toernooi.

## 3. Gelijktijdige wedstrijden (BK: tot 3 velden)

- Elke wedstrijd is een **onafhankelijke** event log (`matchId`) met een eigen klok. De engine heeft geen globale "huidige wedstrijd": ze kan perfect meerdere wedstrijden tegelijk aan.
- `Field` is een eerste-klasse-entiteit. Per veld loopt **hooguit één** wedstrijd tegelijk met status `live`. De validatie gebeurt in de repository met een transactie op `fields/{fieldId}/liveMatchId`.
- De schemagenerator plant parallel over de velden en vermijdt conflicten:
  - Een team speelt nooit gelijktijdig op twee velden en krijgt minstens N slots rust tussen twee wedstrijden.
  - Een official (CR, water referee of vierde scheidsrechter) staat nooit op twee velden in hetzelfde slot, en heeft geen dienst in een slot waarin zijn eigen team speelt.
  - Een speler die ook official is, telt mee voor beide beperkingen.
- Vertraging propageert **per veld**. Een wedstrijd met teams of officials die nog op een ander veld bezig zijn, krijgt de waarschuwing "wacht op veld X".

## 4. Schermbeheer op het toernooi

- `Display(id, name, tournamentId, layout, params, pairedAt, lastSeen)` – de layouts staan in 03 §4.
- **Koppelen**: een nieuw scherm (browser in kioskmodus op `/display`) toont een koppelcode van 6 tekens. De `tournamentAdmin` voert die code in de app in en kiest de layout. Daarna luistert het scherm naar `displays/{id}` en wisselt het live van layout, zonder dat iemand bij het scherm moet zijn.
- Typische opstelling op het BK: 1 groot scherm met `multiFieldOverview`, tv's met `standings` en `schedule` (of `rotation`), en optioneel per veld een `fieldScoreboard`.
- In de app een admin-overzicht met alle schermen: online/offline (`lastSeen`), de huidige layout, en een knop om het scherm te herladen.
- Leesbelasting: elk scherm reduceert zelf de event logs van de live wedstrijden (3 wedstrijden ≈ enkele honderden events: verwaarloosbaar). Een server-side projectie (Cloud Function → `tournaments/{id}/live`) komt er pas als dat nodig blijkt; dan blijven de event logs wel de enige bron.

## 5. Open punten voor later
- Import/export van het schema (CSV, ICS voor de kioskcontroller).
- Publieke read-only link voor ouders en supporters.
