<!-- Plak deze sectie in de bestaande CLAUDE.md in de root van de repo -->

## Onderwaterhockey: wedstrijd-, toernooi- en statistiekmodules

**Specificaties** (lees ze vóór je iets aan deze modules doet):
- `docs/uwh/01-regels-domein.md` – software-extract van de CMAS-regels v13 (bron-PDF in `docs/uwh/reference/`)
- `docs/uwh/02-match-engine.md` – event log, reducer, klokregels, acceptatietests
- `docs/uwh/03-wedstrijdtafel-ui.md` – tafelconsole en scorebord
- `docs/uwh/04-toernooi.md`, `docs/uwh/05-spelersstatistieken.md` – latere fases
- `docs/uwh/open-vragen.md` – onbesliste punten: **nooit zelf invullen**; gebruik de vermelde default als configureerbare policy en markeer met `// OPEN-x`

**Harde regels**
- De match engine leeft in `hs_coaching_core` als **pure Dart** (geen imports van `flutter`, `firebase_*` of `cloud_*`). Firebase zit achter een repository-interface.
- Events zijn append-only. Corrigeer altijd met `EventVoided`, nooit met update of delete.
- Klokken worden **berekend** uit events + server-tijd (`localNow + .info/serverTimeOffset`), nooit opgeslagen of getickt.
- Het tijdstip van een event is het moment van de **tik**, niet het uploadmoment (dus geen `ServerValue.timestamp` als eventtijd).
- Elke klokregel heeft een unit test die naar het regelnummer verwijst (bv. `test('14.2.3.2 auto-stop op 2:00', …)`).
- Meerdere wedstrijden lopen tegelijk (tot 3 velden): alles is per `matchId`, met **geen** singleton of globale "actieve wedstrijd" in providers of services.
- Per wedstrijd is er één tafeltoestel met twee bedieners: de hoofdscheidsrechter bedient de tijd met een HID-afstandsbediening (`source: remote`, enkel start/stop en optioneel officials' time-out), de vierde scheidsrechter het scherm.
- Wissels en assists worden **niet** geregistreerd: bouw er geen events, UI of statistieken voor.
- Geen hardgecodeerde speelduren: alles komt uit `MatchConfig`, die per toernooifase en per wedstrijd kan verschillen en bij `MatchCreated` als snapshot bewaard wordt.
- De overtredingentabel 17.7.1 is een **suggestie**, geen afdwinging.
- Werk per fase volgens `docs/uwh/prompts.md`. Begin pas aan de UI als de engine-tests groen zijn.
- Domeintermen in de code zijn Engels zoals in de CMAS-regels (penalty shot, advantage puck, …); de UI-teksten zijn Nederlands (via het bestaande i18n-mechanisme, als dat er is).
