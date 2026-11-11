# Spelersfuncties en statistieken (fase 3)

Alles wordt **afgeleid** uit de event logs (wedstrijden) en de trainingsdata; er is geen aparte invoer.

## 1. "Mijn toernooi"
- Eigen wedstrijden: veld, (verwacht) startuur, tegenstander, kleur (wit/zwart = welke stok en kap meenemen).
- Pushmelding X min vóór de verwachte start (rekening houdend met de vertraging).
- Live score van de eigen wedstrijd.

## 2. Wedstrijdstatistieken (per wedstrijd / toernooi / seizoen)
- Goals, assists (als die gelogd worden), goals uit strafworpen.
- Strafminuten per type, cautions, dismissals.
- Deelname aan strafworpen (aanvaller/verdediger + uitkomst).
- Team: goals per periode en per tijdsblok van 5 min, het resultaat bij een man meer of minder (berekend uit de overlap van strafklokken en goals).

## 3. Trainingstiming
- Voorwaarde: de training registreert **werkelijke** tijden per oefening of herhaling (niet alleen de geplande). Controleer of het huidige trainingsmodel dat kan; zo niet, stel dan eerst een uitbreiding voor.
- Vaste testsets (bv. maandelijks dezelfde reeks): persoonlijk record + evolutie in een grafiek.
- Belasting per week = Σ(werktijd × inspanningsniveau), met het bestaande 0 %-veld (`–` = niet meegeteld).

## 4. Privacy
- Een speler ziet zijn eigen detailstatistieken; de coach ziet het team. Publiek zijn alleen de teamresultaten.
- Data van wearables uit wedstrijden kan enkel als de scheidsrechters het toestel toelaten (3.3.10: communicatietoestellen zijn verboden; tracking alleen met hun toestemming).
