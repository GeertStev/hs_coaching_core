# UWH-domeinregels voor software (CMAS Rules of Play v13.0, feb 2025)

> Bron: `docs/uwh/reference/CMAS_UWH_Rules_of_Play_v13_Feb2025.pdf`.
> Dit bestand is een **software-extract**: alleen wat de app moet afdwingen, tonen of loggen.
> Regelnummers tussen haakjes verwijzen naar de PDF. Bij twijfel geldt de PDF.
> Punten gemarkeerd met **[OPEN-x]** staan in `open-vragen.md` en mogen niet "naar gevoel" ingevuld worden.

## 1. Rollen (4.1–4.4)

| Rol | Waar | Relevant voor app |
|---|---|---|
| Chief Referee (CR) | kant, midden zijlijn | start/stopt spel, officials' time-out, keurt time-outs goed, laat bestrafte spelers terug in het water |
| Water Referees (2 of 3) | in het water | kunnen géén toestel bedienen; beslissingen worden door de tafel ingegeven |
| Timekeeper/Scorer (1+ personen) – in België de **vierde scheidsrechter** | tafel naast CR | **primaire gebruiker van de wedstrijdtafel-UI**: wedstrijdklok, minstens 2 strafklokken tegelijk, score tonen en aankondigen, schriftelijk wedstrijdverslag |

Gevolg: de "scheidsrechtermodule" is in de praktijk een **wedstrijdtafel-console**, bediend door de vierde scheidsrechter (één toestel per veld). De hoofdscheidsrechter bedient de wedstrijdklok met een afstandsbediening die aan dat toestel gekoppeld is.

## 2. Teams en spelers (3.1–3.2)

- Selectie per toernooi: max. **12** spelers per divisie.
- Per wedstrijd: max. **10** opgegeven (max. 6 in het water + 4 wissels); rest = reserves, mogen die wedstrijd niet meedoen.
- Minder dan 10 toegelaten (spelende coach, 3.1.1.1).
- Bij blessure mag geen reserve ingezet worden in die wedstrijd (3.1.2.1).
- Kapnummers **1–15**, uniek binnen de selectie (3.2.2).
- Kapitein "C", vice-kapitein "VC" (3.2.4) – nodig bij 15.2.1.14 (kapitein wijst overtreder aan, anders zit de kapitein de straf uit).
- Teamkleur per wedstrijd: **wit** of **zwart** (stokken, kappen, kledij) (3.2.1–3.2.2).
- Max. 4 begeleiders per wedstrijd, op de teamlijst (3.1.4).
- Overtime: enkel spelers die bij de start van de wedstrijd opgegeven waren (14.2.4.3).

## 3. Wedstrijdstructuur en klok (14.2, 15.1, 15.3)

### 3.1 Periodes

| Fase | Duur | Opmerking |
|---|---|---|
| Periode 1 | 15:00 | |
| Rust | 3:00 | van speelhelft wisselen (14.2.2) |
| Periode 2 | 15:00 | einde: meeste goals wint, of **gelijkspel** (14.2.1.1) |
| *Alleen als een winnaar vereist is* (14.2.4): | | |
| Pauze | 3:00 | |
| Overtime 1 | 5:00 | teams starten aan **dezelfde kant als bij de wedstrijdstart** |
| Pauze | 1:00 | van kant wisselen |
| Overtime 2 | 5:00 | |
| Pauze | 1:00 | **niet** van kant wisselen (14.2.5) |
| Sudden death | onbeperkt | eerste goal wint |

`requiresWinner` is dus een eigenschap van de wedstrijd (komt uit de toernooimodule: knock-out = true, poule = false).

Alle duren in deze tabel zijn **CMAS-defaults**. Toernooien wijken regelmatig af (OPEN-5), dus alles loopt via `MatchConfig`.

### 3.2 Lopende klok vs. stilgezette klok

- **Standaard loopt de klok door** bij onderbrekingen (15.3.3, 14.2.3).
- CR kan de klok stilzetten bij ernstige blessure, overleg tussen scheidsrechters of bijzondere omstandigheden (= *officials' time-out*). Klok herstart op het startsignaal van CR. Als het overleg een goal of strafgoal oplevert, herstart de klok vanaf de aankondiging van die beslissing (14.2.3).
- **Laatste 2 minuten van periode 2**, **laatste 2 minuten van overtime 2**, en **heel sudden death**: de klok staat stil bij **elke** spelonderbreking, **behalve na een goal** (14.2.3.1).
- **Automatische stop op 2:00**: als de klok tijdens een onderbreking (vóór de laatste 2 minuten) doorloopt tot 2:00, moet ze op 2:00 stoppen en herstarten bij het volgende startsignaal (14.2.3.2). → De engine moet dit **zelf** doen.
- Team time-out: klok stil (14.2.6.1).
- Strafworp (penalty shot): **alle** klokken stil – wedstrijdklok én strafklokken; herstart bij het startsignaal na de strafworp (17.8.1, 17.8.7).
- Een toegekende strafworp moet altijd gespeeld worden, ook als de wedstrijdtijd verstreken is (17.8.6).

**[OPEN-1]** Geldt "laatste 2 minuten" ook voor periode 1 en overtime 1? Letterlijke lezing: nee (instelbaar via `stoppedClockPhases`).

### 3.3 Signalen en aftellingen

- **30 s waarschuwing** vóór de start van elke periode (P1, P2, OT1, OT2) en vóór sudden death; startsignaal 30 s later (15.1.5).
- **Na een goal**: herstart zodra het scorende team klaar is, of uiterlijk 30 s na de goal; **geen** 30 s-waarschuwing (15.1.6).
- **Na een strafgoal**: herstart vanaf het middenpunt, geen waarschuwing (17.9.3).
- Start/stop telt vanaf het eerste geluid van het signaalsysteem (15.1.8, 15.3.4) → het tijdstip van de **tik op de knop** is het officiële tijdstip.

## 4. Team time-outs (14.2.6)

- **1 per team per helft**, alleen in de twee reguliere periodes van 15 min (niet in overtime of sudden death).
- Alleen aan te vragen als het spel al stilligt, en **niet** terwijl een toegekende strafworp nog niet gespeeld is.
- Duur **1:00**; op **0:45** een hoorbare waarschuwing (15 s); na 1:00 herstart, tenzij een volgende time-out gevraagd werd.
- **Aaneenschakelen**: een team mag zijn time-out direct laten volgen op de time-out van de tegenstander of op een officials' time-out, als die gevraagd wordt vóór het einde van de eerste time-out (14.2.6.5).
- Tijdens een time-out mogen bestrafte spelers (niet de definitief uitgesloten) bij hun team in het water; aan het einde moeten ze terug in de strafbank (14.2.6.4, 17.3.1.1.3).

**[OPEN-2]** Loopt de straftijd van bestrafte spelers door tijdens team time-out, rust en officials' time-out?

## 5. Straffen (17.1–17.4, 17.7)

### 5.1 Soorten

| Type | Effect in de app |
|---|---|
| Caution (individueel of team) | enkel loggen; telt mee voor escalatie |
| Tijdstraf 1, 2 of 5 min | strafklok per speler; team speelt met één man minder; **niet vervangbaar** (17.3.1.1.2) |
| Totale uitsluiting | rest van de wedstrijd incl. overtime; niet vervangbaar; **verslag aan de tuchtjury verplicht** (17.4.4) |
| Uitsluiting teamofficial | coach/begeleider van de kant voor de rest van de wedstrijd (17.4.3) |

Daarnaast teamsancties die de herstart bepalen: **equal puck**, **advantage puck**, **strafworp**, **strafgoal** (17.1.1.2).

### 5.2 Strafklok-regels

- Straftijd start pas als de speler in de strafbank zit **én** het spel herstart is (17.3.1.1.1). → Een straf heeft de status `pending` tot het volgende `PlayStarted`-event.
- Een wissel die een straf krijgt, zit die uit in de strafbank, en het team moet een speler uit het water halen (17.1.1.3).
- Niet-identificeerbare overtreder bij een foute wissel: de kapitein wijst binnen 5 s iemand aan, anders zit de kapitein de straf uit (15.2.1.14).
- Bij afloop van de straf terwijl het spel stilligt: de speler mag pas het water in nadat een van beide teams de puck raakt (17.3.1.2.3). → Status `expired_waiting` en zo tonen aan CR.
- Terugkeer: zittend, voeten eerst, aan de middellijn; foute terugkeer = 1 min (17.3.1.2.2).
- Er moeten minstens **2 strafklokken tegelijk** mogelijk zijn (4.5.4); de app ondersteunt er onbeperkt.

### 5.3 Overtredingentabel als richtlijn (17.7.1)

De tabel is uitdrukkelijk een **richtlijn** voor de scheidsrechter. In de app mag ze dus alleen een **suggestie** geven (op basis van de voorgaande overtredingen van dezelfde soort door die speler in deze wedstrijd); de app mag de straf **nooit opleggen**.
Codeer de tabel als data (`infringements_v13.json`) met per regel: code (16.3.x), naam, handsignaal (13.1.x), en per stap (1e accidenteel / 1e opzettelijk / 2e accidenteel / 2e opzettelijk / 3e+) de toegelaten uitkomsten. "*" betekent dat de scheidsrechter vrij kiest tussen de vermelde opties.

**[OPEN-3]** Telt "eerste/tweede overtreding" per speler of per team? En geldt dat per wedstrijd of over het toernooi?

> Gekende fouten in de bron: in 17.7.1 staat "I minute" (bedoeld is 1 minute). 15.2.3.9 verwijst naar een "Table 17.6.6.1" die niet bestaat; de bedoelde tabel is 17.7.1. 17.11.1 verwijst naar 16.1.1, maar bedoeld is 16.3.1.

## 6. Strafworp (17.8)

- Wordt toegekend bij een overtreding in de 3 m-zone die een waarschijnlijke goal verhindert.
- Bij de toekenning stoppen alle klokken.
- Het benadeelde team kiest **2 aanvallers**, het andere team **1 verdediger**, uit de geschikte spelers en wissels. Spelers in de strafbank (ook wie er net naartoe gestuurd werd) en uitgesloten spelers mogen niet deelnemen.
- Een aanvaller moet binnen **5 s** in balbezit zijn, anders is de strafworp verdedigd.
- Mogelijke uitkomsten: `goal` (ook bij een overtreding door de verdediger) of `defended` (puck volledig buiten de 6 m-zone, overtreding door een aanvaller, of geen balbezit binnen 5 s).
- Daarna volgt een herstart vanaf de doellijnen (15.1).
- Optioneel loggen: wie de aanvallers en de verdediger waren (nuttig voor statistieken).

## 7. Strafgoal (17.9)

- Telt als een goal voor het benadeelde team.
- Herstart vanaf het middenpunt, zonder 30 s-waarschuwing.

## 8. Herstarttypes (17.5, 17.6, 17.10, 17.11)

Voor de tafel volstaat het om te loggen hoe het spel herstart: `endLineStart`, `equalPuck`, `advantagePuck(team)`, `penaltyShot`.
Een advantage puck vervalt als het team niet binnen 5 s in balbezit komt; daarna volgt een equal puck (17.6.3.1). Dat is iets voor de scheidsrechter in het water; de app doet hier hooguit een optionele 5 s-aftelling.

## 9. Doelpunt (15.4)

- Wordt gelogd met team, kapnummer van de scorer (optioneel), wedstrijdtijd en periode.
- Na een goal geldt een vrije wissel ("free subbing", 15.2).
- Afgekeurde goals bestaan niet als event: de scheidsrechter beslist vóór de registratie. Een vergissing aan de tafel corrigeer je met `EventVoided`.

## 10. Protest, staking, forfait (5.x)

- Een protest tijdens de wedstrijd: CR stopt het spel (= officials' time-out), beslist en het spel herneemt. Log `ProtestLogged(team, by, text)`.
- **Forfait**: een team staat niet klaar binnen 2 min na het geplande startuur (5.3.1). → Toernooimodule: knop "forfait" na de 2 minuten, met de beslissing van de Technical Delegate.
- **Staking**: de wedstrijd kan niet beginnen of niet uitgespeeld worden; de Technical Delegate beslist. → Status `abandoned` + vrij in te vullen beslissing.
- De eindstand wordt pas aangekondigd na verificatie en **medeondertekening door de scheidsrechters** (4.4.2.5). → Status `awaitingSignOff` → `final`.

## 11. Afmetingen (enkel voor tekeningen en scorebord)

Speelveld 12–15 × 21–25 m (min. 300 m²), diepte 2–3,65 m; doelzone r = 3 m; strafworpzone r = 6 m; strafpunt op 3 m; hoeken r = 1 m. Wissels: drie methodes (dek-, in-water- of doellijnwissel), **één methode per toernooi** (15.2) → toernooi-instelling. Voor deze app geldt dekwissel, en wissels worden **niet geregistreerd** (OPEN-4).
