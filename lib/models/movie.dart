import 'package:flutter/material.dart';

/// Simple data model representing a single movie in the watchlist.
class Movie {
  final String id;
  final String title;
  final String genre;
  final int year;
  final String duration;
  final double rating;
  final String overview;
  final List<Color> posterColors;
  final bool isWatched;

  const Movie({
    required this.id,
    required this.title,
    required this.genre,
    required this.year,
    required this.duration,
    required this.rating,
    required this.overview,
    required this.posterColors,
    this.isWatched = false,
  });

  /// Creates a copy of this movie with updated fields.
  /// Useful when toggling watched status or changing the rating.
  Movie copyWith({
    String? title,
    String? genre,
    int? year,
    String? duration,
    double? rating,
    String? overview,
    List<Color>? posterColors,
    bool? isWatched,
  }) {
    return Movie(
      id: id,
      title: title ?? this.title,
      genre: genre ?? this.genre,
      year: year ?? this.year,
      duration: duration ?? this.duration,
      rating: rating ?? this.rating,
      overview: overview ?? this.overview,
      posterColors: posterColors ?? this.posterColors,
      isWatched: isWatched ?? this.isWatched,
    );
  }

  /// Picks a matching Material icon based on the movie's genre.
  IconData get genreIcon {
    switch (genre) {
      case 'Sci-Fi':
        return Icons.rocket_launch_rounded;
      case 'Action':
        return Icons.local_fire_department_rounded;
      case 'Drama':
        return Icons.theater_comedy_rounded;
      case 'Thriller':
        return Icons.psychology_rounded;
      case 'Animation':
        return Icons.auto_awesome_rounded;
      case 'Comedy':
        return Icons.sentiment_very_satisfied_rounded;
      default:
        return Icons.movie_creation_rounded;
    }
  }

  /// Returns a gradient pair for newly added movies based on genre.
  static List<Color> colorsForGenre(String genre) {
    switch (genre) {
      case 'Sci-Fi':
        return const [Color(0xFF1E3A8A), Color(0xFF0F172A)];
      case 'Action':
        return const [Color(0xFF991B1B), Color(0xFF1F1215)];
      case 'Drama':
        return const [Color(0xFF6D28D9), Color(0xFF1E1B4B)];
      case 'Thriller':
        return const [Color(0xFF0F766E), Color(0xFF0F172A)];
      case 'Animation':
        return const [Color(0xFFD97706), Color(0xFF451A03)];
      case 'Comedy':
        return const [Color(0xFFBE185D), Color(0xFF3B0764)];
      default:
        return const [Color(0xFF334155), Color(0xFF0F172A)];
    }
  }
}
