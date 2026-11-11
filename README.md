# CineTrack — Movie Watchlist App (Flutter)

A clean, dark-themed Movie Watchlist mini-project built with **Flutter** and **Dart**.

## Features
- **Dark Cinema UI** using Material 3 (`#0B0F17` obsidian background, `#141B29` cards, gold ratings, crimson accents).
- **Watchlist, Watched & All Movies Tabs** via bottom `NavigationBar`.
- **Live Search & Genre Filtering** (`Sci-Fi`, `Action`, `Drama`, `Thriller`, `Animation`, `Comedy`).
- **Add New Movie Sheet** with title validation, release year, duration, genre chips, and rating slider.
- **Movie Detail Screen** with `Hero` poster transition, storyline, interactive rating slider, watch-status toggle, and delete confirmation.

## Project Structure
```text
cinetrack_watchlist/
├── lib/
│   ├── main.dart
│   ├── data/
│   │   └── sample_movies.dart
│   ├── models/
│   │   └── movie.dart
│   ├── screens/
│   │   ├── home_screen.dart
│   │   └── movie_detail_screen.dart
│   └── widgets/
│       ├── add_movie_sheet.dart
│       ├── movie_card.dart
│       └── stats_banner.dart
└── test/
    └── widget_test.dart
```

## Run Locally
```bash
flutter pub get
flutter run
```

## Author
- **Name:** KHANDAVALLI SIMON JOSEPH
- **Register Number:** 24PA1A05B6
- **Branch / Year / Section:** CSE / 3rd Year / B
- **College:** Vishnu Institute of Technology, Bhimavaram
