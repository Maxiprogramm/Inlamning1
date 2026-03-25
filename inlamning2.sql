DROP DATABASE IF EXISTS Bokhandel;
CREATE DATABASE Bokhandel;
USE Bokhandel;

-- Tabeller

CREATE TABLE Bocker (
    ISBNID VARCHAR(20) PRIMARY KEY,
    Titel VARCHAR(100) NOT NULL,
    Forfattare VARCHAR(100) NOT NULL,
    Pris DECIMAL(10,2) NOT NULL CHECK (Pris > 0),
    Lagerstatus INT NOT NULL CHECK (Lagerstatus >= 0)
);

CREATE TABLE Kunder (
    KundID INT AUTO_INCREMENT PRIMARY KEY,
    Namn VARCHAR(100) NOT NULL,
    Epost VARCHAR(100) NOT NULL UNIQUE,
    Telefon VARCHAR(30),
    Adress VARCHAR(100)
);

CREATE TABLE Bestallningar (
    Ordernummer INT AUTO_INCREMENT PRIMARY KEY,
    KundID INT NOT NULL,
    Datum TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Totalbelopp DECIMAL(10,2) NOT NULL CHECK (Totalbelopp >= 0),
    FOREIGN KEY (KundID) REFERENCES Kunder(KundID)
);

CREATE TABLE Orderrader (
    OrderradID INT AUTO_INCREMENT PRIMARY KEY,
    Ordernummer INT NOT NULL,
    ISBNID VARCHAR(20) NOT NULL,
    Antal INT NOT NULL CHECK (Antal > 0),
    Pris DECIMAL(10,2) NOT NULL CHECK (Pris > 0),
    FOREIGN KEY (Ordernummer) REFERENCES Bestallningar(Ordernummer),
    FOREIGN KEY (ISBNID) REFERENCES Bocker(ISBNID)
);

CREATE TABLE KundLogg (
    LoggID INT AUTO_INCREMENT PRIMARY KEY,
    KundID INT,
    RegistreradTid TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Index

CREATE INDEX idx_epost ON Kunder(Epost);

-- Triggers

DELIMITER //

CREATE TRIGGER trg_minska_lager
AFTER INSERT ON Orderrader
FOR EACH ROW
BEGIN
    UPDATE Bocker
    SET Lagerstatus = Lagerstatus - NEW.Antal
    WHERE ISBNID = NEW.ISBNID;
END //

CREATE TRIGGER trg_logga_kund
AFTER INSERT ON Kunder
FOR EACH ROW
BEGIN
    INSERT INTO KundLogg (KundID)
    VALUES (NEW.KundID);
END //

DELIMITER ;

-- Testdata

INSERT INTO Bocker (ISBNID, Titel, Forfattare, Pris, Lagerstatus) VALUES
('1', 'Bok 1', 'Forfattare 1', 100.00, 10),
('2', 'Bok 2', 'Forfattare 2', 150.00, 10),
('3', 'Bok 3', 'Forfattare 3', 200.00, 10);

INSERT INTO Kunder (Namn, Epost, Telefon, Adress) VALUES
('Max', 'max@example.com', '0701111111', 'Kalmar'),
('John', 'john@example.com', '0702222222', 'Oskarshamn'),
('Sara', 'sara@example.com', '0703333333', 'Vastervik'),
('Anna', 'anna@example.com', '0704444444', 'Kalmar');

INSERT INTO Bestallningar (KundID, Totalbelopp) VALUES
(1, 100.00),
(1, 150.00),
(1, 200.00),
(2, 100.00),
(3, 150.00);

INSERT INTO Orderrader (Ordernummer, ISBNID, Antal, Pris) VALUES
(1, '1', 1, 100.00),
(2, '2', 1, 150.00),
(3, '3', 1, 200.00),
(4, '1', 1, 100.00),
(5, '2', 1, 150.00);

-- Hämta, filtrera, sortera

SELECT * FROM Kunder;
SELECT * FROM Bestallningar;

SELECT * FROM Kunder
WHERE Namn = 'Max';

SELECT * FROM Kunder
WHERE Epost = 'john@example.com';

SELECT * FROM Bocker
ORDER BY Pris ASC;

-- UPDATE, DELETE, TRANSAKTION

START TRANSACTION;
UPDATE Kunder
SET Epost = 'maxny@example.com'
WHERE KundID = 1;
ROLLBACK;

START TRANSACTION;
DELETE FROM Kunder
WHERE KundID = 4;
ROLLBACK;

-- JOIN och GROUP BY

SELECT k.Namn, b.Ordernummer
FROM Kunder k
INNER JOIN Bestallningar b ON k.KundID = b.KundID;

SELECT k.Namn, b.Ordernummer
FROM Kunder k
LEFT JOIN Bestallningar b ON k.KundID = b.KundID;

SELECT k.Namn, COUNT(b.Ordernummer) AS AntalBestallningar
FROM Kunder k
LEFT JOIN Bestallningar b ON k.KundID = b.KundID
GROUP BY k.KundID, k.Namn;

SELECT k.Namn, COUNT(b.Ordernummer) AS AntalBestallningar
FROM Kunder k
INNER JOIN Bestallningar b ON k.KundID = b.KundID
GROUP BY k.KundID, k.Namn
HAVING COUNT(b.Ordernummer) > 2;

-- Visa trigger-resultat

SELECT * FROM Bocker;
SELECT * FROM KundLogg;

