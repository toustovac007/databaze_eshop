-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Počítač: 127.0.0.1
-- Vytvořeno: Úte 25. lis 2025, 16:57
-- Verze serveru: 10.4.32-MariaDB
-- Verze PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Databáze: `eshop_deskove_hry`
--

-- --------------------------------------------------------

--
-- Struktura tabulky `autor`
--

CREATE TABLE `autor` (
  `id_autor` int(11) NOT NULL,
  `jmeno` varchar(50) DEFAULT NULL,
  `prijmeni` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_czech_ci;

--
-- Vypisuji data pro tabulku `autor`
--

INSERT INTO `autor` (`id_autor`, `jmeno`, `prijmeni`) VALUES
(1, 'Karel', 'Svoboda'),
(2, 'Reiner', 'Knizia'),
(3, 'Vláďa', 'Chvátil'),
(4, 'Eduard', 'Dvořák'),
(5, 'Ondřej', 'Sedláčková'),
(6, 'Viktor', 'Slavík'),
(7, 'Adam', 'Zemanová'),
(8, 'Jolana', 'Kadlec'),
(9, 'Šárka', 'Horváthová'),
(10, 'Edita', 'Bednář'),
(11, 'Albert', 'Bártová'),
(12, 'Martina', 'Bárta'),
(13, 'Hedvika', 'Horáková');

-- --------------------------------------------------------

--
-- Struktura tabulky `dodavatel`
--

CREATE TABLE `dodavatel` (
  `id_dodavatel` int(11) NOT NULL,
  `nazev_firmy` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_czech_ci;

--
-- Vypisuji data pro tabulku `dodavatel`
--

INSERT INTO `dodavatel` (`id_dodavatel`, `nazev_firmy`) VALUES
(1, 'Games4You'),
(2, 'CzechBoardImports'),
(3, 'Valenta'),
(4, 'Sýkora'),
(5, 'Slavíková k.s.'),
(6, 'Vacková'),
(7, 'Kratochvílová o.s.');

-- --------------------------------------------------------

--
-- Struktura tabulky `historicka_cena`
--

CREATE TABLE `historicka_cena` (
  `id` int(11) NOT NULL,
  `id_polozka` int(11) NOT NULL,
  `cena` decimal(10,2) NOT NULL,
  `datum_od` date NOT NULL,
  `datum_do` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_czech_ci;

--
-- Vypisuji data pro tabulku `historicka_cena`
--

INSERT INTO `historicka_cena` (`id`, `id_polozka`, `cena`, `datum_od`, `datum_do`) VALUES
(1, 1, 649.00, '2024-01-01', '2024-12-31'),
(2, 1, 699.00, '2025-01-01', NULL),
(3, 2, 949.00, '2024-01-01', '2024-12-31'),
(4, 2, 999.00, '2025-01-01', NULL),
(5, 3, 449.00, '2024-01-01', '2024-12-31'),
(6, 3, 499.00, '2025-01-01', NULL);

-- --------------------------------------------------------

--
-- Struktura tabulky `objednavka`
--

CREATE TABLE `objednavka` (
  `id_objednavka` int(11) NOT NULL,
  `id_dodavatel` int(11) DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `datum_prevzeti` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_czech_ci;

--
-- Vypisuji data pro tabulku `objednavka`
--

INSERT INTO `objednavka` (`id_objednavka`, `id_dodavatel`, `status`, `datum_prevzeti`) VALUES
(1, 1, 'Vyřízena', '2025-01-02'),
(2, 2, 'Čeká na dodání', NULL);

-- --------------------------------------------------------

--
-- Struktura tabulky `objednavka_polozka`
--

CREATE TABLE `objednavka_polozka` (
  `id_objednavka` int(11) NOT NULL,
  `id_polozka` int(11) NOT NULL,
  `mnozstvi` int(11) DEFAULT 1,
  `cena_za_kus` decimal(10,2) DEFAULT NULL,
  `datum_prevzeti` date NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_czech_ci;

--
-- Vypisuji data pro tabulku `objednavka_polozka`
--

INSERT INTO `objednavka_polozka` (`id_objednavka`, `id_polozka`, `mnozstvi`, `cena_za_kus`, `datum_prevzeti`) VALUES
(1, 1, 20, 420.00, '2025-11-24'),
(1, 3, 30, 300.00, '2025-11-24'),
(2, 2, 15, 650.00, '2025-11-24');

-- --------------------------------------------------------

--
-- Struktura tabulky `polozka`
--

CREATE TABLE `polozka` (
  `id_polozka` int(11) NOT NULL,
  `nazev` varchar(100) NOT NULL,
  `cena_prodeje` decimal(10,2) DEFAULT NULL,
  `cena_koupe` decimal(10,2) DEFAULT NULL,
  `hmotnost` decimal(6,2) DEFAULT NULL,
  `pocet_na_sklade` int(11) DEFAULT 0,
  `casova_narocnost` varchar(50) DEFAULT NULL,
  `doporuceny_vek` int(11) DEFAULT NULL,
  `obtiznost` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_czech_ci;

--
-- Vypisuji data pro tabulku `polozka`
--

INSERT INTO `polozka` (`id_polozka`, `nazev`, `cena_prodeje`, `cena_koupe`, `hmotnost`, `pocet_na_sklade`, `casova_narocnost`, `doporuceny_vek`, `obtiznost`) VALUES
(1, 'Carcassonne', 699.00, 420.00, 1.20, 15, '30–45 min', 7, 'Lehká'),
(2, 'Catan', 999.00, 650.00, 1.50, 10, '60–90 min', 10, 'Střední'),
(3, 'Krycí jména', 499.00, 300.00, 0.90, 25, '15 min', 10, 'Lehká'),
(4, 'Padat Game', 1011.00, 854.00, 1.98, 7, '30–45 min', 8, 'Těžká'),
(5, 'Jindy Game', 683.00, 304.00, 1.68, 1, '15 min', 7, 'Lehká'),
(6, 'Ruka Game', 796.00, 438.00, 1.62, 22, '120+ min', 12, 'Lehká'),
(7, 'Způsobit Game', 901.00, 659.00, 2.02, 5, '60–90 min', 11, 'Střední'),
(8, 'Naklonit Arena', 569.00, 359.00, 0.70, 12, '15 min', 11, 'Střední'),
(9, 'Prostorový Game', 1053.00, 818.00, 1.96, 17, '15 min', 12, 'Lehká'),
(10, 'Židle Arena', 1015.00, 765.00, 1.65, 22, '15 min', 6, 'Těžká'),
(11, 'Užívání Game', 681.00, 433.00, 2.21, 27, '15 min', 12, 'Střední'),
(12, 'Spojovat Quest', 950.00, 664.00, 1.24, 6, '45–60 min', 16, 'Těžká'),
(13, 'Zahrát Quest', 460.00, 273.00, 0.83, 12, '45–60 min', 16, 'Těžká'),
(14, 'Mladík Arena', 982.00, 770.00, 2.19, 24, '15 min', 9, 'Lehká'),
(15, 'Asie Arena', 828.00, 523.00, 0.63, 29, '120+ min', 11, 'Lehká'),
(16, 'Dokument Battle', 1226.00, 871.00, 2.27, 20, '60–90 min', 8, 'Střední'),
(17, 'Individuální Arena', 568.00, 342.00, 1.99, 13, '120+ min', 12, 'Střední'),
(18, 'Výpověď Battle', 594.00, 424.00, 0.68, 1, '15 min', 8, 'Těžká'),
(19, 'Avšak Game', 679.00, 363.00, 1.27, 19, '60–90 min', 14, 'Střední'),
(20, 'Interiér Game', 871.00, 766.00, 1.86, 17, '45–60 min', 16, 'Střední'),
(21, 'Dopadnout Battle', 564.00, 314.00, 0.82, 0, '45–60 min', 14, 'Lehká'),
(22, 'Prudce Arena', 873.00, 719.00, 2.18, 16, '120+ min', 9, 'Lehká'),
(23, 'Terén Game', 764.00, 582.00, 1.70, 15, '15 min', 7, 'Střední');

-- --------------------------------------------------------

--
-- Struktura tabulky `polozka_autor`
--

CREATE TABLE `polozka_autor` (
  `id_polozka` int(11) NOT NULL,
  `id_autor` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_czech_ci;

--
-- Vypisuji data pro tabulku `polozka_autor`
--

INSERT INTO `polozka_autor` (`id_polozka`, `id_autor`) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(4, 7),
(5, 13),
(6, 5),
(7, 5),
(7, 12),
(8, 6),
(9, 6),
(9, 12),
(10, 10),
(10, 12),
(11, 12),
(12, 8),
(13, 9),
(13, 11),
(14, 5),
(14, 7),
(15, 5),
(16, 4),
(16, 12),
(17, 13),
(18, 4),
(19, 4),
(20, 5),
(21, 9),
(22, 12),
(23, 8);

-- --------------------------------------------------------

--
-- Struktura tabulky `polozka_vydavatel`
--

CREATE TABLE `polozka_vydavatel` (
  `id_polozka` int(11) NOT NULL,
  `id_vydavatelstvi` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_czech_ci;

--
-- Vypisuji data pro tabulku `polozka_vydavatel`
--

INSERT INTO `polozka_vydavatel` (`id_polozka`, `id_vydavatelstvi`) VALUES
(1, 2),
(2, 2),
(3, 1),
(4, 6),
(5, 4),
(6, 7),
(7, 4),
(8, 7),
(9, 7),
(10, 6),
(11, 4),
(12, 6),
(13, 6),
(14, 4),
(15, 3),
(16, 3),
(17, 6),
(18, 5),
(19, 6),
(20, 6),
(21, 6),
(22, 3),
(23, 3);

-- --------------------------------------------------------

--
-- Struktura tabulky `polozka_zanr`
--

CREATE TABLE `polozka_zanr` (
  `id_polozka` int(11) NOT NULL,
  `id_zanr` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_czech_ci;

--
-- Vypisuji data pro tabulku `polozka_zanr`
--

INSERT INTO `polozka_zanr` (`id_polozka`, `id_zanr`) VALUES
(1, 2),
(2, 1),
(3, 2),
(3, 3),
(4, 10),
(5, 5),
(5, 11),
(6, 7),
(7, 6),
(7, 7),
(8, 8),
(9, 7),
(9, 10),
(10, 11),
(11, 4),
(12, 5),
(13, 6),
(14, 7),
(14, 11),
(15, 10),
(16, 6),
(17, 4),
(17, 7),
(18, 6),
(18, 11),
(19, 5),
(19, 11),
(20, 8),
(21, 4),
(22, 9),
(23, 4);

-- --------------------------------------------------------

--
-- Struktura tabulky `vydavatelstvi`
--

CREATE TABLE `vydavatelstvi` (
  `id_vydavatelstvi` int(11) NOT NULL,
  `nazev` varchar(100) DEFAULT NULL,
  `popis` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_czech_ci;

--
-- Vypisuji data pro tabulku `vydavatelstvi`
--

INSERT INTO `vydavatelstvi` (`id_vydavatelstvi`, `nazev`, `popis`) VALUES
(1, 'MindOK', 'České vydavatelství deskových her.'),
(2, 'Albi', 'Vydavatel moderních deskových her.'),
(3, 'Tomanová', 'Tvrzení vysoce přiznat přeprava klást samozřejmě.'),
(4, 'Vlček Marková o.s.', 'Závodník spotřeba tah spoj ambice.'),
(5, 'Sedlák Kříž o.s.', 'Setkat vstříc kvůli obnovit.'),
(6, 'Vlček Jandová a.s.', 'Položit soubor vznikat.'),
(7, 'Stejskalová', 'Přehled dlouhodobě televizor vybavit správní kdy.');

-- --------------------------------------------------------

--
-- Struktura tabulky `zakazka`
--

CREATE TABLE `zakazka` (
  `id_zakazka` int(11) NOT NULL,
  `cas_prijeti` datetime NOT NULL DEFAULT current_timestamp(),
  `status` enum('Přijato','Připraveno k odeslání','Odesláno','Vráceno','Doručeno') NOT NULL DEFAULT 'Přijato',
  `adresa_doruceni` varchar(255) DEFAULT NULL,
  `forma_prevzeti` enum('Zásilkovna','Kurýr','Osobní odběr') NOT NULL DEFAULT 'Osobní odběr',
  `datum_odeslani` date DEFAULT NULL,
  `datum_doruceni` date DEFAULT NULL,
  `id_zakaznik` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_czech_ci;

--
-- Vypisuji data pro tabulku `zakazka`
--

INSERT INTO `zakazka` (`id_zakazka`, `cas_prijeti`, `status`, `adresa_doruceni`, `forma_prevzeti`, `datum_odeslani`, `datum_doruceni`, `id_zakaznik`) VALUES
(1, '2025-01-05 14:32:00', 'Odesláno', 'Praha 1, Ulice 10', 'Kurýr', '2025-01-06', NULL, 1),
(2, '2025-01-10 09:20:00', 'Přijato', 'Brno, Dům 22', 'Zásilkovna', NULL, NULL, 2),
(3, '2025-03-10 10:39:02', 'Doručeno', 'K Vidouli 33, 693 31 Červený Kostelec', 'Kurýr', '2025-02-17', '2024-11-29', 11),
(4, '2024-12-20 21:04:48', 'Doručeno', 'U Nové Dálnice 786, 470 13 Chabařovice', 'Zásilkovna', '2025-09-24', '2025-01-05', 3),
(5, '2025-07-05 05:01:09', 'Doručeno', 'Kazín 317, 388 08 Přerov', 'Zásilkovna', '2025-02-24', '2025-01-09', 16),
(6, '2025-08-13 16:48:33', 'Připraveno k odeslání', 'Ke Hrázi 867, 532 99 Praha', 'Zásilkovna', NULL, NULL, 12),
(7, '2025-09-13 00:21:49', 'Přijato', 'Otradovická 1, 117 98 Habartov', 'Osobní odběr', NULL, NULL, 16),
(8, '2025-02-20 10:11:31', 'Připraveno k odeslání', 'Slatiňanská 42, 289 35 Velká Bíteš', 'Kurýr', NULL, NULL, 4),
(9, '2025-04-28 04:38:47', 'Doručeno', 'Musílkova 494, 661 28 Volary', 'Zásilkovna', '2025-11-23', '2025-09-04', 12),
(10, '2025-08-25 21:29:30', 'Doručeno', 'Na Pěšině 7, 387 35 Ždírec nad Doubravou', 'Zásilkovna', '2025-06-09', '2025-10-16', 12),
(11, '2025-10-21 16:12:58', 'Přijato', 'Branická 822, 276 11 Moravský Beroun', 'Kurýr', NULL, NULL, 13),
(12, '2025-11-02 10:57:26', 'Doručeno', 'U Podjezdu 521, 711 58 Radnice', 'Osobní odběr', '2025-11-10', '2025-03-12', 11),
(13, '2025-10-27 03:06:26', 'Odesláno', 'U Podjezdu 280, 550 51 Dolní Poustevna', 'Kurýr', '2025-08-23', NULL, 6),
(14, '2025-08-27 00:16:15', 'Odesláno', 'Za Statky 1, 528 54 Kraslice', 'Zásilkovna', '2025-04-02', NULL, 7),
(15, '2025-07-16 19:24:44', 'Vráceno', 'Medlovská 2, 105 60 Velké Hamry', 'Zásilkovna', NULL, NULL, 13),
(16, '2025-08-01 13:52:32', 'Odesláno', 'Heydukova 993, 783 46 Rýmařov', 'Kurýr', '2025-03-09', NULL, 8),
(17, '2025-10-16 11:56:47', 'Přijato', 'Krátký Lán 1, 183 63 Chvaletice', 'Zásilkovna', NULL, NULL, 10);

-- --------------------------------------------------------

--
-- Struktura tabulky `zakazka_polozka`
--

CREATE TABLE `zakazka_polozka` (
  `id_zakazka` int(11) NOT NULL,
  `id_polozka` int(11) NOT NULL,
  `mnozstvi` int(11) DEFAULT 1,
  `cena_v_dobe_prodeje` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_czech_ci;

--
-- Vypisuji data pro tabulku `zakazka_polozka`
--

INSERT INTO `zakazka_polozka` (`id_zakazka`, `id_polozka`, `mnozstvi`, `cena_v_dobe_prodeje`) VALUES
(1, 1, 1, 699.00),
(1, 3, 2, 499.00),
(2, 2, 1, 999.00),
(3, 6, 2, 796.00),
(4, 6, 2, 796.00),
(4, 8, 3, 569.00),
(4, 15, 3, 828.00),
(5, 18, 3, 594.00),
(5, 23, 1, 764.00),
(6, 7, 2, 901.00),
(6, 12, 1, 950.00),
(7, 13, 2, 460.00);

-- --------------------------------------------------------

--
-- Struktura tabulky `zakaznik`
--

CREATE TABLE `zakaznik` (
  `id_zakaznik` int(11) NOT NULL,
  `jmeno` varchar(50) DEFAULT NULL,
  `prijmeni` varchar(50) NOT NULL,
  `telefon` varchar(20) NOT NULL,
  `mobil` varchar(20) DEFAULT NULL,
  `email` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_czech_ci;

--
-- Vypisuji data pro tabulku `zakaznik`
--

INSERT INTO `zakaznik` (`id_zakaznik`, `jmeno`, `prijmeni`, `telefon`, `mobil`, `email`) VALUES
(1, 'Jan', 'Novák', '222333444', '777111222', 'jan.novak@example.com'),
(2, 'Eva', 'Dvořáková', '224556677', '777333444', 'eva.dvorakova@example.com'),
(3, 'Jana', 'Beránková', '00420 794 715 131', '+420 703 539 468', 'matejkovasvetlana@example.net'),
(4, 'Arnošt', 'Tichý', '+420 604 249 589', '+420 735 622 820', 'machludvik@example.com'),
(5, 'Jana', 'Čermák', '00420 603 414 249', '+420 703 003 519', 'vilem57@example.org'),
(6, 'Klement', 'Slavíková', '+420 602 769 547', '+420 733 890 016', 'jindriskasedlackova@example.net'),
(7, 'Rostislav', 'Stejskal', '00420 798 506 830', '00420 705 620 196', 'malamarie@example.com'),
(8, 'Lada', 'Soukupová', '+420 605 574 060', '00420 730 614 018', 'fstrnadova@example.org'),
(9, 'Květoslava', 'Mach', '+420 607 171 289', '00420 602 239 380', 'pavlicekignac@example.net'),
(10, 'Otakar', 'Müllerová', '+420 702 586 864', '00420 606 193 557', 'davidsvec@example.com'),
(11, 'Klára', 'Bílková', '+420 702 703 261', '+420 606 643 208', 'nemcovatereza@example.org'),
(12, 'Blahoslav', 'Kovář', '00420 728 783 683', '00420 797 141 066', 'jakubdusek@example.org'),
(13, 'Kateřina', 'Benešová', '00420 732 387 183', '+420 604 181 639', 'ismidova@example.net'),
(14, 'Milena', 'Fiala', '00420 604 155 328', '00420 608 795 083', 'vacekmojmir@example.com'),
(15, 'Stanislava', 'Kratochvílová', '+420 603 040 362', '+420 793 845 354', 'ilonanemeckova@example.net'),
(16, 'Ctirad', 'Holub', '00420 605 154 124', '00420 703 553 188', 'veselajulie@example.net'),
(17, 'Iva', 'Urbanová', '00420 604 203 951', '+420 604 796 210', 'marekbednar@example.com');

-- --------------------------------------------------------

--
-- Struktura tabulky `zanr`
--

CREATE TABLE `zanr` (
  `id_zanr` int(11) NOT NULL,
  `nazev` varchar(50) DEFAULT NULL,
  `popis` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_czech_ci;

--
-- Vypisuji data pro tabulku `zanr`
--

INSERT INTO `zanr` (`id_zanr`, `nazev`, `popis`) VALUES
(1, 'Strategie', 'Hry zaměřené na plánování a taktiku.'),
(2, 'Rodinná hra', 'Jednodušší hry vhodné pro rodiny.'),
(3, 'Kooperativní', 'Hráči spolupracují proti hře.'),
(4, 'Horizont', 'Vytrhnout přitáhnout nízko.'),
(5, 'Zvát', 'Zima tvůrce potenciální slabost.'),
(6, 'Samostatně', 'Ml gymnázium hájit hladina resp zejména.'),
(7, 'Celkem', 'Tamní účinnost mimořádný hodně zvyknout.'),
(8, 'Kalhoty', 'Stadión víno časový organický karlovarský poloha posvátný.'),
(9, 'Zase', 'Chystat podrobnost dole originál keř.'),
(10, 'Odnést', 'Opouštět protestovat pouto sportovec zázrak cíl výročí.'),
(11, 'Gesto', 'Klid údolí pošta doprovázet samotný infekce.');

--
-- Indexy pro exportované tabulky
--

--
-- Indexy pro tabulku `autor`
--
ALTER TABLE `autor`
  ADD PRIMARY KEY (`id_autor`);

--
-- Indexy pro tabulku `dodavatel`
--
ALTER TABLE `dodavatel`
  ADD PRIMARY KEY (`id_dodavatel`);

--
-- Indexy pro tabulku `historicka_cena`
--
ALTER TABLE `historicka_cena`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_polozka` (`id_polozka`);

--
-- Indexy pro tabulku `objednavka`
--
ALTER TABLE `objednavka`
  ADD PRIMARY KEY (`id_objednavka`),
  ADD KEY `id_dodavatel` (`id_dodavatel`);

--
-- Indexy pro tabulku `objednavka_polozka`
--
ALTER TABLE `objednavka_polozka`
  ADD PRIMARY KEY (`id_objednavka`,`id_polozka`),
  ADD KEY `id_polozka` (`id_polozka`);

--
-- Indexy pro tabulku `polozka`
--
ALTER TABLE `polozka`
  ADD PRIMARY KEY (`id_polozka`);

--
-- Indexy pro tabulku `polozka_autor`
--
ALTER TABLE `polozka_autor`
  ADD PRIMARY KEY (`id_polozka`,`id_autor`),
  ADD KEY `id_autor` (`id_autor`);

--
-- Indexy pro tabulku `polozka_vydavatel`
--
ALTER TABLE `polozka_vydavatel`
  ADD PRIMARY KEY (`id_polozka`,`id_vydavatelstvi`),
  ADD KEY `id_vydavatelstvi` (`id_vydavatelstvi`);

--
-- Indexy pro tabulku `polozka_zanr`
--
ALTER TABLE `polozka_zanr`
  ADD PRIMARY KEY (`id_polozka`,`id_zanr`),
  ADD KEY `id_zanr` (`id_zanr`);

--
-- Indexy pro tabulku `vydavatelstvi`
--
ALTER TABLE `vydavatelstvi`
  ADD PRIMARY KEY (`id_vydavatelstvi`);

--
-- Indexy pro tabulku `zakazka`
--
ALTER TABLE `zakazka`
  ADD PRIMARY KEY (`id_zakazka`),
  ADD KEY `id_zakaznik` (`id_zakaznik`);

--
-- Indexy pro tabulku `zakazka_polozka`
--
ALTER TABLE `zakazka_polozka`
  ADD PRIMARY KEY (`id_zakazka`,`id_polozka`),
  ADD KEY `id_polozka` (`id_polozka`);

--
-- Indexy pro tabulku `zakaznik`
--
ALTER TABLE `zakaznik`
  ADD PRIMARY KEY (`id_zakaznik`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexy pro tabulku `zanr`
--
ALTER TABLE `zanr`
  ADD PRIMARY KEY (`id_zanr`);

--
-- AUTO_INCREMENT pro tabulky
--

--
-- AUTO_INCREMENT pro tabulku `autor`
--
ALTER TABLE `autor`
  MODIFY `id_autor` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT pro tabulku `dodavatel`
--
ALTER TABLE `dodavatel`
  MODIFY `id_dodavatel` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT pro tabulku `historicka_cena`
--
ALTER TABLE `historicka_cena`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT pro tabulku `objednavka`
--
ALTER TABLE `objednavka`
  MODIFY `id_objednavka` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pro tabulku `polozka`
--
ALTER TABLE `polozka`
  MODIFY `id_polozka` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT pro tabulku `vydavatelstvi`
--
ALTER TABLE `vydavatelstvi`
  MODIFY `id_vydavatelstvi` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT pro tabulku `zakazka`
--
ALTER TABLE `zakazka`
  MODIFY `id_zakazka` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT pro tabulku `zakaznik`
--
ALTER TABLE `zakaznik`
  MODIFY `id_zakaznik` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT pro tabulku `zanr`
--
ALTER TABLE `zanr`
  MODIFY `id_zanr` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- Omezení pro exportované tabulky
--

--
-- Omezení pro tabulku `historicka_cena`
--
ALTER TABLE `historicka_cena`
  ADD CONSTRAINT `historicka_cena_ibfk_1` FOREIGN KEY (`id_polozka`) REFERENCES `polozka` (`id_polozka`);

--
-- Omezení pro tabulku `objednavka`
--
ALTER TABLE `objednavka`
  ADD CONSTRAINT `objednavka_ibfk_1` FOREIGN KEY (`id_dodavatel`) REFERENCES `dodavatel` (`id_dodavatel`);

--
-- Omezení pro tabulku `objednavka_polozka`
--
ALTER TABLE `objednavka_polozka`
  ADD CONSTRAINT `objednavka_polozka_ibfk_1` FOREIGN KEY (`id_objednavka`) REFERENCES `objednavka` (`id_objednavka`),
  ADD CONSTRAINT `objednavka_polozka_ibfk_2` FOREIGN KEY (`id_polozka`) REFERENCES `polozka` (`id_polozka`);

--
-- Omezení pro tabulku `polozka_autor`
--
ALTER TABLE `polozka_autor`
  ADD CONSTRAINT `polozka_autor_ibfk_1` FOREIGN KEY (`id_polozka`) REFERENCES `polozka` (`id_polozka`),
  ADD CONSTRAINT `polozka_autor_ibfk_2` FOREIGN KEY (`id_autor`) REFERENCES `autor` (`id_autor`);

--
-- Omezení pro tabulku `polozka_vydavatel`
--
ALTER TABLE `polozka_vydavatel`
  ADD CONSTRAINT `polozka_vydavatel_ibfk_1` FOREIGN KEY (`id_polozka`) REFERENCES `polozka` (`id_polozka`),
  ADD CONSTRAINT `polozka_vydavatel_ibfk_2` FOREIGN KEY (`id_vydavatelstvi`) REFERENCES `vydavatelstvi` (`id_vydavatelstvi`);

--
-- Omezení pro tabulku `polozka_zanr`
--
ALTER TABLE `polozka_zanr`
  ADD CONSTRAINT `polozka_zanr_ibfk_1` FOREIGN KEY (`id_polozka`) REFERENCES `polozka` (`id_polozka`),
  ADD CONSTRAINT `polozka_zanr_ibfk_2` FOREIGN KEY (`id_zanr`) REFERENCES `zanr` (`id_zanr`);

--
-- Omezení pro tabulku `zakazka`
--
ALTER TABLE `zakazka`
  ADD CONSTRAINT `zakazka_ibfk_1` FOREIGN KEY (`id_zakaznik`) REFERENCES `zakaznik` (`id_zakaznik`);

--
-- Omezení pro tabulku `zakazka_polozka`
--
ALTER TABLE `zakazka_polozka`
  ADD CONSTRAINT `zakazka_polozka_ibfk_1` FOREIGN KEY (`id_zakazka`) REFERENCES `zakazka` (`id_zakazka`),
  ADD CONSTRAINT `zakazka_polozka_ibfk_2` FOREIGN KEY (`id_polozka`) REFERENCES `polozka` (`id_polozka`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
