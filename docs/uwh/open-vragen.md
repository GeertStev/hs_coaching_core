# Open vragen en beslissingen

Claude Code: **niet zelf invullen.** Open punten implementeer je als configureerbare policy met de vermelde default, en je markeert ze in de code met `// OPEN-x`.

## Beslist

| # | Vraag | Regel | Beslissing | Gevolg voor de implementatie |
|---|---|---|---|---|
| OPEN-1 | Geldt het stilgezette-klokvenster van 2:00 ook voor P1 en OT1? | 14.2.3.1 | Default aanvaard: **nee** (alleen P2, OT2 en sudden death). Nog niet nagevraagd bij scheidsrechters. | `MatchConfig.stoppedClockPhases` (default `{p2, ot2, suddenDeath}`) en `stoppedClockWindow` |
| OPEN-2 | Loopt de straftijd door tijdens een time-out, officials' time-out en de rust? | 17.3, 14.2.6 | Default aanvaard: straftijd loopt **alleen** als de wedstrijdklok loopt | `PenaltyClockPolicy` |
| OPEN-3 | Telt "1e/2e/3e overtreding" per speler of per team? | 17.7.1 | Default aanvaard: **per speler, per wedstrijd** | `suggestPenalty` |
| OPEN-4 | Welke wisselmethode? | 15.2 | **Dekwissel; wissels worden niet geregistreerd** | Geen wisselevents of -UI. Geen speeltijd per speler (zie 05). Zie 02 §6c |
| OPEN-5 | Afwijkingen van periodeduur, jeugd, time-outs? | – | **Vaak afwijkend per toernooi, en binnen een toernooi tussen poulefase en finales.** Timing hangt af van de beschikbare zwembadtijd. | Configuratie per fase en per wedstrijd, presets, slotduur berekend uit de config, planner. Zie 02 §2 en 04 §1 |
| OPEN-6 | Hoeveel tafeltoestellen? | 4.4.1 | **1 toestel per wedstrijd, 2 bedieners**: de hoofdscheidsrechter bedient de tijd met een afstandsbediening (HID-toetsen), de vierde scheidsrechter is scorer. | Eén schrijver per wedstrijd (lease) en afstandsbedieningsinvoer. Zie 02 §6a en 03 §5 |
| OPEN-7 | Assists loggen? | – | **Nee** | Geen assistveld, geen assiststatistiek |
| OPEN-8 | Papieren wedstrijdblad nog verplicht naast de PDF? | 4.5.5 | Default aanvaard: de PDF-export bootst het papieren blad na | – |

## Nog open

| # | Vraag | Default tot beslissing | Antwoord Geert |
|---|---|---|---|
| OPEN-9 | Afstandsbediening: welk model, welke toetsen stuurt hij, en hoeveel knoppen heeft hij? Geeft de hoofdscheidsrechter met dezelfde knop ook het hoorbare start-/stopsignaal (15.1.8, 15.3.4), of is dat een apart systeem? | Toetsen worden in de app geleerd (druk op de knop om toe te wijzen). Eén toets = wisselknop start/stop. Twee of meer knoppen = aparte start- en stoptoets. De app maakt zelf geen officieel signaal. | Knop nog te ontwikkelen. De app gaat wel een geluidsignaal geven. Voorlopig een mogelijkheid dat de app en start en stop knop toont |
| OPEN-10 | Wat als een knock-outwedstrijd een winnaar vereist maar er niet genoeg zwembadtijd is voor de volledige overtime? | `MatchConfig.overtimePeriods` (2 of 0) en `suddenDeathEnabled` zijn instelbaar. Zijn beide uit en is er gelijkspel, dan blokkeert de app de afsluiting tot de tafel een beslissing invoert (`ResultDecidedByDelegate`). | |
