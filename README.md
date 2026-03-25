Inlamning1 skapad av Maximilian Walder Lövgren YH25
Jag har skapat en databas för en bokhandel som visar upp information i olika tabeller och beskriver hur tabellerna hänger ihop med hjälp av nycklar (PK) och (FK).

Databasen innehåller tabellerna
Kunder
Böcker
Beställningar
Orderrader
Databasen innehåller relationer som gör det möjligt att, 
En kund kan göra flera beställningar
En beställning kan innehålla flera orderrader
En bok kan finnas på flera orderrader
Bild på mitt ER-diagram kommer nedan.
<img width="580" height="416" alt="Er-diagram" src="https://github.com/user-attachments/assets/47654e87-e8db-499d-a5d0-6157fc57d74b" />

Inlamning 2

Denna uppgift bygger vidare på databasen från inlämning 1.
Fokus i denna uppgift är att arbeta mer med SQL för att hantera och analysera data.

Testdata

Databasen innehåller flera testposter för att kunna testa olika SQL-frågor.
Det finns minst tre kunder, tre böcker och flera beställningar.

Hämta och filtrera data

SQL-frågor används för att:

visa alla kunder och beställningar
filtrera kunder med WHERE
sortera böcker efter pris med ORDER BY
Modifiera data

Databasen visar hur man kan ändra data med SQL.

Detta görs med:

UPDATE för att ändra kundinformation
DELETE för att ta bort en kund
TRANSACTION och ROLLBACK för att kunna ångra ändringar
JOIN och GROUP BY

Flera frågor används för att analysera data i databasen.

INNER JOIN visar kunder som har gjort beställningar
LEFT JOIN visar alla kunder även de utan beställningar
GROUP BY räknar antal beställningar per kund
HAVING visar kunder som gjort fler än två beställningar
Index

Ett index har skapats på kunders e-postadress för att göra sökningar snabbare.

Constraints

Databasen använder constraints för att säkerställa korrekt data.

Exempel:

pris på böcker måste vara större än 0
antal i en orderrad måste vara större än 0
lagerstatus kan inte vara negativ
Triggers

Två triggers används i databasen.

Trigger 1
När en orderrad läggs till minskar lagersaldot för boken.

Trigger 2
När en ny kund registreras sparas information i en loggtabell.

Backup och Restore

En backup av databasen har skapats och sparats i filen: bokhandel_backup.sql

Databasen kan återställas genom att köra denna fil.

Reflektion

Databasen är designad för att vara enkel och tydlig.
Orderrader används eftersom en beställning kan innehålla flera böcker.

Om databasen skulle användas för många fler kunder (t.ex. 100 000) skulle fler index kunna läggas till för att förbättra prestanda, till exempel på KundID och Ordernummer.

