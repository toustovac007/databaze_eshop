

# 🛒 E-shop s deskovými hrami – SQL databáze

Tento projekt představuje kompletní model SQL databáze pro malý online e-shop s deskovými hrami.
Cílem je poskytnout strukturu, která umožňuje:

* sledovat stav zásob deskových her
* evidovat objednávky zákazníků
* spravovat nákupy od dodavatelů
* monitorovat historický vývoj cen
* pracovat s ukázkovými (fake) daty

Projekt obsahuje databázový diagram, SQL dump i Python skript pro generování testovacích dat.

---

## 📁 Struktura repozitáře

```
📦 E-shop-desktop-games
├── README.md                         → Dokumentace projektu
├── Shrnutí projektu.txt              → Textové shrnutí / původní zadání
├── data_faker.py                     → Skript pro generování fake dat (SQL INSERTy)
├── diagram.png                       → Databázový diagram (PNG)
├── diagram.svg                       → Databázový diagram (SVG)
├── eshop_deskove_hry_se_vzorovymi_daty.sql  → SQL dump celé DB + fake data
└── fake_eshop_deskove_hry.sql        → Pouze INSERTy s fake daty
```

---

## 🧱 Popis projektu

Databáze je navržena pro malý e-shop specializující se na prodej deskových her.
Zaměřuje se na několik hlavních oblastí:

### 📦 Sklad & produkty

* evidence jednotlivých deskových her
* počty kusů skladem
* aktuální a historická cena

### 🛍️ Objednávky zákazníků

* zákazník → objednávka
* objednávka → položky
* historie cen v době objednávky

### 🔄 Nákupy od dodavatelů

* dodavatelé a jejich zásoby
* příjem zboží do skladu
* ceny nákupů

### 📈 Historický vývoj cen

* trackování změn cen produktů
* možnost analyzovat vývoj cen v čase

---

## 🗂️ Databázový diagram

Diagram je dostupný ve formátech:

* **PNG** – `diagram.png`
* **SVG** – `diagram.svg`

> Diagram znázorňuje vazby mezi tabulkami, klíče a datové typy.

---

## 🧪 Fake data

Fake data jsou generována pomocí Python skriptu:

### ▶️ `data_faker.py`

* generuje SQL INSERT dotazy
* používá knihovnu `Faker`
* vhodné pro testování, prezentaci nebo vývoj aplikace

Ukázkové výstupy:

* `fake_eshop_deskove_hry.sql` – pouze INSERTy
* `eshop_deskove_hry_se_vzorovymi_daty.sql` – celá struktura DB + data

---

## 🛠️ Jak databázi použít

### 1️⃣ Import do MySQL

```bash
mysql -u root -p < eshop_deskove_hry_se_vzorovymi_daty.sql
```

### 2️⃣ Nebo vytvoření databáze bez dat

```bash
mysql -u root -p < eshop_deskove_hry.sql
```

(a přidat data pomocí `fake_eshop_deskove_hry.sql`)

---

## 🧩 Použité technologie

* **MySQL / MariaDB** – databázový systém
* **Python 3** – generování fake dat
* **Faker** – knihovna pro realistické testovací údaje
* **Draw.io / dbdiagram** – tvorba databázového diagramu

---

## 💡 Možnosti rozšíření

* REST API pro správu produktů a objednávek
* Admin rozhraní pro správu skladu
* Automatické přepočty dostupnosti
* Doplnění plateb, fakturace, uživatelských účtů

---


odkaz na diagram v dbdiagram.io: https://dbdiagram.io/d/690dc7316735e11170b77da2
## 📜 Licence

Projekt je dostupný pro studijní a demonstrační účely.
Úpravy a další použití jsou vítány!


