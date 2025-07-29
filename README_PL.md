# 🎧 Dashboard najpopularniejszych utworów Spotify

![Power BI](https://img.shields.io/badge/Power%20BI-Dashboard-F2C811?logo=power-bi\&logoColor=white)
![SQL Server](https://img.shields.io/badge/SQL%20Server-Database-CC2927?logo=microsoft-sql-server\&logoColor=white)
![Zbiór danych Kaggle](https://img.shields.io/badge/Kaggle-Dataset-20BEFF?logo=kaggle\&logoColor=white)
![Licencja](https://img.shields.io/badge/License-MIT-green.svg)

---

![Podgląd dashboardu](./screenshots/dashboard_preview.png)

Interaktywny **pulpit nawigacyjny Power BI** analizujący **najpopularniejsze utwory Spotify** w 73 krajach. Zapewnia wgląd w **trendy popularności utworów, cechy audio i wyniki artystów** przy użyciu **modelu danych typu star-schema** zbudowanego w SQL Server.

---

## 📊 Funkcje

* **Globalne trendy popularności**

  * Śledź codzienną popularność najpopularniejszych utworów w różnych krajach.
  * Wizualizuj **popularność według kraju** za pomocą interaktywnej mapy.

* **Analiza cech audio**

  * Porównaj **taneczność, energię, walencję, akustyczność i żywiołowość** najpopularniejszych utworów.
  * Poznaj profile emocjonalne/energetyczne utworów.

* **Kluczowe wskaźniki KPI**

  * **Średnia popularność**
  * **Unikalne utwory i artyści**
  * **Odsetek treści nieodpowiednich dla dzieci**

* **Interaktywność**

  * **Wyszukiwanie i filtrowanie** według artystów i zakresu dat.
  * Wszystkie elementy wizualne można filtrować krzyżowo w celu przeprowadzenia dogłębnej analizy.

---

## 🛠 Technologia

* **Źródło danych**: [Kaggle – Najpopularniejsze utwory Spotify w 73 krajach (aktualizowane codziennie)](https://www.kaggle.com/datasets/asaniczka/top-spotify-songs-in-73-countries-daily-updated)
* **Baza danych**: SQL Server (ETL, czyszczenie danych, projekt schematu gwiaździstego)
* **Wizualizacja**: Power BI Desktop
* **Języki**: SQL (modelowanie danych), DAX (wskaźniki KPI, obliczenia)

---

## 📂 Struktura projektu

```
spotify-analytics-dashboard/
│
├── data/
│   └── top_spotify_songs.csv        # Surowy zbiór danych (z Kaggle)
│
├── sql/
│   ├── 01_create_tables.sql         # Skrypty tworzenia tabel schematu gwiaździstego
│   ├── 02_insert_data.sql           # Skrypty ładowania danych
│   └── 03_views_measures.sql        # Przykładowe widoki analityczne
│
├── powerbi/
│   └── spotify_dashboard.pbix       # Plik pulpitu nawigacyjnego Power BI
│
├── screenshots/
│   └── dashboard-preview.png        # Obraz podglądu pulpitu nawigacyjnego
│
├── README.md
└── LICENSE
```

---

## 📂 Skrypty SQL

* [**01\_create\_tables.sql**](./sql/01_create_tables.sql) – Tworzy tabele wymiarów i faktów
* [**02\_insert\_data.sql**](./sql/02_insert_data.sql) – Wstawia oczyszczone dane Kaggle do tabel
* [**03\_views\_measures.sql**](./sql/03_views_measures.sql) – Przykładowe widoki dla warstwy raportowania

---

## 📈 Model danych

* **Tabela faktów**: `FactSpotifyHistory`

  * Zawiera popularność utworu, ranking, flagę wyraźną i funkcje audio
* **Tabele wymiarów**:

  * `DimArtist`
  * `DimTrack`
  * `DimAlbum`
  * `DimCountry`
  * `DimDate`

Schemat gwiaździsty zapewnia szybką agregację i łatwe filtrowanie.

---

## 📐 Kluczowe miary DAX

```DAX
Unikalne utwory = DISTINCTCOUNT ( »Spotify Facts«[TrackKey] )
Unikalni artyści = DISTINCTCOUNT(»Spotify Facts«[ArtistKey])
Liczba wyraźnych = CALCULATE(
  COUNTROWS(»Spotify Facts«),
  »Spotify Facts«[IsExplicit] = TRUE())

Wyraźne % = DIVIDE(
  [Liczba wyraźnych],
  COUNTROWS(»Spotify Facts«),
  0
)*100
```

Dodatkowe miary: **Danceability, Energy, Valence, Acousticness, Liveness** do analizy cech.

---

## 📊 Przegląd pulpitu nawigacyjnego

**Zawarte elementy wizualne:**

1. **Karty KPI** – średnia popularność, unikalne utwory, unikalni artyści, Explicit %
2. **Wykres słupkowy** – 5 najpopularniejszych utworów
3. **Mapa** – popularność według kraju
4. **Wykres kołowy** – rozkład cech audio
5. **Wykres liniowy** – trend popularności w czasie
6. **Filtr + wyszukiwanie** – wybór artysty i filtr zakresu dat

**Najważniejsze cechy projektu:**

* Ciemny motyw z **zielonymi akcentami Spotify**
* Układ na jednej stronie dla prostoty i przejrzystości
* Interaktywne filtry i wzajemne podświetlanie

---

## 🚀 Jak uruchomić

### 1. Sklonuj repozytorium

```bash
git clone https://github.com/yourusername/spotify-analytics-dashboard.git
cd spotify-analytics-dashboard
````

### 2. (W razie potrzeby) Pobierz zbiór danych

* Pobierz plik `top_spotify_songs.csv` z [linku do zbioru danych Kaggle](https://www.kaggle.com/datasets/asaniczka/top-spotify-songs-in-73-countries-daily-updated), jeśli chcesz ponownie zaimportować lub odświeżyć tabele za pomocą SQL.

### 3. Otwórz pulpit nawigacyjny Power BI

* Otwórz plik `powerbi/spotify_dashboard.pbix` w programie **Power BI Desktop**.
* Ponieważ projekt jest zbudowany w **trybie importu**, **wszystkie wymagane dane są już osadzone w pliku `.pbix`** — **do przeglądania lub eksploracji nie jest wymagane połączenie z serwerem SQL**.

### 4. Opcjonalnie: odśwież dane za pomocą SQL

* Jeśli chcesz ręcznie odświeżyć lub odbudować pulpit nawigacyjny:

* Zaimportuj plik `.csv` do serwera SQL.
* Uruchom pliki `sql/01_create_tables.sql` i `02_insert_data.sql`, aby zbudować schemat gwiaździsty.
  * Uruchom plik `03_views_measures.sql`, jeśli wolisz model oparty na widokach.
  * Następnie otwórz Power BI i odśwież model danych, aby pobrać zaktualizowane dane.

Ciesz się przeglądaniem pulpitu nawigacyjnego od razu — do regularnego przeglądania nie jest wymagana konfiguracja serwera SQL!

---

* **Taneczność** i **energia** dominują wśród cech najpopularniejszych utworów.
* Utwory zawierające wulgarny język stanowią około 33% najpopularniejszych utworów na świecie.
* Stałe wzrosty popularności korelują z wydaniem dużych albumów.

---

## 👤 Autor

**Szymon Janusz**
[LinkedIn](https://www.linkedin.com/in/szymon-janusz) • [Portfolio](https://github.com/szymon-janusz) • [E-mail](mailto:szymonjanusz0613@gmail.com)

---

## 📄 Licencja

Licencja MIT – szczegóły w [LICENCJA](./LICENCJA).