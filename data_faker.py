from faker import Faker
import random
from datetime import datetime, timedelta

fake = Faker("cs_CZ")
random.seed(42)

# -----------------------------
# PARAMETRY – UPRAV DLE POTŘEB
# -----------------------------
NUM_AUTORI = 10
NUM_DODAVATELE = 5
NUM_POLOZKY = 20
NUM_VYDAVATELSTVI = 5
NUM_ZANRY = 8
NUM_OBJEDNAVKY = 15
NUM_ZAKAZNICI = 15

# -----------------------------
# FUNKCE PRO GENEROVÁNÍ DAT
# -----------------------------

def rand_date(start_days_ago=365):
    start = datetime.now() - timedelta(days=start_days_ago)
    end = datetime.now()
    return fake.date_between(start, end).strftime("%Y-%m-%d")

def rand_datetime(start_days_ago=365):
    start = datetime.now() - timedelta(days=start_days_ago)
    end = datetime.now()
    return fake.date_time_between(start, end).strftime("%Y-%m-%d %H:%M:%S")

# -----------------------------
# GENEROVÁNÍ DAT
# -----------------------------

# AUTOR
autori = [
    (i, fake.first_name(), fake.last_name())
    for i in range(4, 4 + NUM_AUTORI)
]

# DODAVATEL
dodavatele = [
    (i, fake.company())
    for i in range(3, 3 + NUM_DODAVATELE)
]

# ZANR
zanry = [
    (i, fake.word().capitalize(), fake.sentence())
    for i in range(4, 4 + NUM_ZANRY)
]

# VYDAVATELSTVI
vydavatelstvi = [
    (i, fake.company(), fake.text(50))
    for i in range(3, 3 + NUM_VYDAVATELSTVI)
]

# POLOZKA
obtiznosti = ["Lehká", "Střední", "Těžká"]
casovky = ["15 min", "30–45 min", "45–60 min", "60–90 min", "120+ min"]

polozky = []
for i in range(4, 4 + NUM_POLOZKY):
    cena_koupe = random.randint(200, 900)
    cena_prodeje = cena_koupe + random.randint(100, 400)
    polozky.append((
        i,
        fake.word().capitalize() + " " + random.choice(["Game", "Quest", "Arena", "Battle"]),
        cena_prodeje,
        cena_koupe,
        round(random.uniform(0.5, 2.5), 2),
        random.randint(0, 30),
        random.choice(casovky),
        random.randint(6, 16),
        random.choice(obtiznosti)
    ))

# POLOZKA_AUTOR (m:n)
polozka_autor = []
for pol in polozky:
    assigned = random.sample(autori, random.randint(1, 2))
    for aut in assigned:
        polozka_autor.append((pol[0], aut[0]))

# POLOZKA_VYDAVATEL (m:n)
polozka_vydavatel = []
for pol in polozky:
    vyd = random.choice(vydavatelstvi)
    polozka_vydavatel.append((pol[0], vyd[0]))

# POLOZKA_ZANR (m:n)
polozka_zanr = []
for pol in polozky:
    zanry_assign = random.sample(zanry, random.randint(1, 2))
    for z in zanry_assign:
        polozka_zanr.append((pol[0], z[0]))

# ZAKAZNIK
zakaznici = [
    (
        i,
        fake.first_name(),
        fake.last_name(),
        fake.phone_number(),
        fake.phone_number(),
        fake.unique.email()
    )
    for i in range(3, 3 + NUM_ZAKAZNICI)
]

# ZAKAZKA
statusy = ["Přijato","Připraveno k odeslání","Odesláno","Vráceno","Doručeno"]
formy_prevzeti = ["Zásilkovna","Kurýr","Osobní odběr"]

zakazky = []
for i in range(3, 3 + NUM_OBJEDNAVKY):
    prijeti = rand_datetime()
    status = random.choice(statusy)
    odeslani = rand_date() if status in ["Odesláno", "Doručeno"] else None
    doruceni = rand_date() if status == "Doručeno" else None
    zakazky.append((
        i,
        prijeti,
        status,
        fake.address().replace("\n", ", "),
        random.choice(formy_prevzeti),
        odeslani,
        doruceni,
        random.choice(zakaznici)[0]
    ))

# ZAKAZKA_POLOZKA
zakazka_polozka = []
for zak in zakazky:
    for _ in range(random.randint(1, 4)):
        pol = random.choice(polozky)
        zakazka_polozka.append((
            zak[0],
            pol[0],
            random.randint(1, 4),
            pol[2]
        ))

# OBJEDNAVKA (dodavatelské)
objednavky = []
for i in range(3, 10):
    status = random.choice(["Vyřízena", "Čeká na dodání"])
    objednavky.append((
        i,
        random.choice(dodavatele)[0],
        status,
        rand_date() if status == "Vyřízena" else None
    ))

# OBJEDNAVKA_POLOZKA
objednavka_polozka = []
for obj in objednavky:
    for _ in range(random.randint(1, 4)):
        pol = random.choice(polozky)
        objednavka_polozka.append((
            obj[0],
            pol[0],
            random.randint(5, 50),
            pol[3],
            rand_date()
        ))


# --------------------------------
# FUNKCE PRO GENEROVÁNÍ SQL
# --------------------------------
def insert(table, columns, data):
    lines = [f"-- {table}"]
    for row in data:
        vals = []
        for v in row:
            if v is None:
                vals.append("NULL")
            elif isinstance(v, str):
                vals.append(f"'{v.replace('\'','\\\'')}'")
            else:
                vals.append(str(v))
        lines.append(f"INSERT INTO {table} ({', '.join(columns)}) VALUES ({', '.join(vals)});")
    lines.append("")
    return "\n".join(lines)

# -----------------------------
# GENEROVÁNÍ CELÉHO SQL DUMPU
# -----------------------------
sql = ""

sql += insert("autor", ["id_autor","jmeno","prijmeni"], autori)
sql += insert("dodavatel", ["id_dodavatel","nazev_firmy"], dodavatele)
sql += insert("zanr", ["id_zanr","nazev","popis"], zanry)
sql += insert("vydavatelstvi", ["id_vydavatelstvi","nazev","popis"], vydavatelstvi)
sql += insert("polozka", ["id_polozka","nazev","cena_prodeje","cena_koupe","hmotnost",
                          "pocet_na_sklade","casova_narocnost","doporuceny_vek","obtiznost"], polozky)
sql += insert("polozka_autor", ["id_polozka","id_autor"], polozka_autor)
sql += insert("polozka_vydavatel", ["id_polozka","id_vydavatelstvi"], polozka_vydavatel)
sql += insert("polozka_zanr", ["id_polozka","id_zanr"], polozka_zanr)
sql += insert("zakaznik", ["id_zakaznik","jmeno","prijmeni","telefon","mobil","email"], zakaznici)
sql += insert("zakazka", ["id_zakazka","cas_prijeti","status","adresa_doruceni","forma_prevzeti",
                          "datum_odeslani","datum_doruceni","id_zakaznik"], zakazky)
sql += insert("zakazka_polozka", ["id_zakazka","id_polozka","mnozstvi","cena_v_dobe_prodeje"], zakazka_polozka)
sql += insert("objednavka", ["id_objednavka","id_dodavatel","status","datum_prevzeti"], objednavky)
sql += insert("objednavka_polozka", ["id_objednavka","id_polozka","mnozstvi","cena_za_kus","datum_prevzeti"],
              objednavka_polozka)

# -----------------------------
# ULOŽENÍ DO SOUBORU
# -----------------------------
with open("fake_eshop_deskove_hry.sql", "w", encoding="utf-8") as f:
    f.write(sql)

print("Hotovo! SQL dump uložen jako fake_eshop_deskove_hry.sql")
