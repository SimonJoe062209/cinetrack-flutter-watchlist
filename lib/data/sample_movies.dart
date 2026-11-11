import 'package:flutter/material.dart';
import '../models/movie.dart';

/// List of genres displayed in the filter bar and add-movie form.
const List<String> movieGenres = [
  'All',
  'Sci-Fi',
  'Action',
  'Drama',
  'Thriller',
  'Animation',
  'Comedy',
];

/// Preloaded sample movies so the app looks full and ready on first launch.
final List<Movie> sampleMovies = [
  const Movie(
    id: 'm1',
    title: 'Interstellar',
    genre: 'Sci-Fi',
    year: 2014,
    duration: '2h 49m',
    rating: 8.7,
    overview:
        'A team of explorers travels through a wormhole in space in an attempt to ensure humanity\'s survival as Earth becomes uninhabitable.',
    posterColors: [Color(0xFF1D4ED8), Color(0xFF090D16)],
    isWatched: false,
  ),
  const Movie(
    id: 'm2',
    title: 'The Dark Knight',
    genre: 'Action',
    year: 2008,
    duration: '2h 32m',
    rating: 9.0,
    overview:
        'Batman faces his greatest psychological and physical test when the chaotic Joker wreaks havoc on Gotham City.',
    posterColors: [Color(0xFF991B1B), Color(0xFF111827)],
    isWatched: true,
  ),
  const Movie(
    id: 'm3',
    title: 'Spider-Man: Across the Spider-Verse',
    genre: 'Animation',
    year: 2023,
    duration: '2h 20m',
    rating: 8.6,
    overview:
        'Miles Morales catapults across the Multiverse, encountering a team of Spider-People charged with protecting its very existence.',
    posterColors: [Color(0xFFE11D48), Color(0xFF1E1B4B)],
    isWatched: false,
  ),
  const Movie(
    id: 'm4',
    title: 'Inception',
    genre: 'Thriller',
    year: 2010,
    duration: '2h 28m',
    rating: 8.8,
    overview:
        'A skilled thief who steals secrets through dream-sharing technology is given a final task: planting an idea into a CEO\'s mind.',
    posterColors: [Color(0xFF0F766E), Color(0xFF0B1120)],
    isWatched: true,
  ),
  const Movie(
    id: 'm5',
    title: 'Dune: Part Two',
    genre: 'Sci-Fi',
    year: 2024,
    duration: '2h 46m',
    rating: 8.5,
    overview:
        'Paul Atreides unites with Chani and the Fremen while seeking revenge against the conspirators who destroyed his family.',
    posterColors: [Color(0xFFD97706), Color(0xFF1C1917)],
    isWatched: false,
  ),
  const Movie(
    id: 'm6',
    title: 'Parasite',
    genre: 'Thriller',
    year: 2019,
    duration: '2h 12m',
    rating: 8.5,
    overview:
        'Greed and class discrimination threaten the newly formed symbiotic relationship between the wealthy Park family and the destitute Kim clan.',
    posterColors: [Color(0xFF047857), Color(0xFF090D16)],
    isWatched: false,
  ),
  const Movie(
    id: 'm7',
    title: 'Oppenheimer',
    genre: 'Drama',
    year: 2023,
    duration: '3h 00m',
    rating: 8.4,
    overview:
        'The story of American scientist J. Robert Oppenheimer and his pivotal role in the development of the atomic bomb.',
    posterColors: [Color(0xFFB45309), Color(0xFF18181B)],
    isWatched: false,
  ),
  const Movie(
    id: 'm8',
    title: '3 Idiots',
    genre: 'Comedy',
    year: 2009,
    duration: '2h 50m',
    rating: 8.4,
    overview:
        'Two friends search for their long-lost college companion while recalling the unforgettable lessons he taught them about life.',
    posterColors: [Color(0xFF7C3AED), Color(0xFF111827)],
    isWatched: true,
  ),
];
