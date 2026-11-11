import 'package:flutter/material.dart';
import '../data/sample_movies.dart';
import '../models/movie.dart';
import '../widgets/add_movie_sheet.dart';
import '../widgets/movie_card.dart';
import '../widgets/stats_banner.dart';
import 'movie_detail_screen.dart';

/// Main screen of the CineTrack app.
/// Manages the movie list, search query, genre filter, and active bottom tab.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Master list of movies (starts with preloaded sample movies).
  final List<Movie> _movies = List<Movie>.from(sampleMovies);

  // 0 = Watchlist, 1 = Watched, 2 = All Movies
  int _selectedTab = 0;
  String _selectedGenre = 'All';
  String _searchQuery = '';

  /// Filters the movie list by active tab, genre chip, and search text.
  List<Movie> get _filteredMovies {
    return _movies.where((movie) {
      // 1. Filter by bottom navigation tab
      if (_selectedTab == 0 && movie.isWatched) return false;
      if (_selectedTab == 1 && !movie.isWatched) return false;

      // 2. Filter by selected genre chip
      if (_selectedGenre != 'All' && movie.genre != _selectedGenre) {
        return false;
      }

      // 3. Filter by search query
      if (_searchQuery.isNotEmpty &&
          !movie.title.toLowerCase().contains(_searchQuery.toLowerCase())) {
        return false;
      }

      return true;
    }).toList();
  }

  void _addMovie(Movie newMovie) {
    setState(() {
      _movies.insert(0, newMovie);
      _selectedTab = 0;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Added "${newMovie.title}" to Watchlist'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _toggleWatched(Movie movie) {
    final index = _movies.indexWhere((item) => item.id == movie.id);
    if (index == -1) return;

    final updated = movie.copyWith(isWatched: !movie.isWatched);
    setState(() {
      _movies[index] = updated;
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          updated.isWatched
              ? 'Marked "${updated.title}" as Watched'
              : 'Moved "${updated.title}" back to Watchlist',
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _updateMovie(Movie updatedMovie) {
    final index = _movies.indexWhere((item) => item.id == updatedMovie.id);
    if (index == -1) return;

    setState(() {
      _movies[index] = updatedMovie;
    });
  }

  void _deleteMovie(String movieId) {
    setState(() {
      _movies.removeWhere((item) => item.id == movieId);
    });
  }

  void _openAddMovieSheet() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => AddMovieSheet(onAddMovie: _addMovie),
    );
  }

  void _openMovieDetails(Movie movie) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => MovieDetailScreen(
          movie: movie,
          onMovieUpdated: _updateMovie,
          onMovieDeleted: () => _deleteMovie(movie.id),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final visibleMovies = _filteredMovies;
    final watchlistCount = _movies.where((m) => !m.isWatched).length;
    final watchedCount = _movies.where((m) => m.isWatched).length;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // App Header
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE50914).withValues(alpha: 0.16),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: const Color(0xFFE50914).withValues(alpha: 0.4),
                      ),
                    ),
                    child: const Icon(
                      Icons.local_movies_rounded,
                      color: Color(0xFFFF4D5A),
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'CineTrack',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFFF8FAFC),
                          letterSpacing: -0.3,
                        ),
                      ),
                      Text(
                        'Personal Movie Watchlist',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF94A3B8),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Search Input
              TextField(
                onChanged: (value) => setState(() => _searchQuery = value),
                decoration: const InputDecoration(
                  hintText: 'Search movies by title...',
                  prefixIcon: Icon(Icons.search_rounded),
                ),
              ),
              const SizedBox(height: 14),

              // Summary Banner
              StatsBanner(
                totalCount: _movies.length,
                watchlistCount: watchlistCount,
                watchedCount: watchedCount,
              ),
              const SizedBox(height: 14),

              // Horizontal Genre Chips
              SizedBox(
                height: 38,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: movieGenres.length,
                  separatorBuilder: (_, _) => const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    final genre = movieGenres[index];
                    final isSelected = _selectedGenre == genre;
                    return ChoiceChip(
                      label: Text(genre),
                      selected: isSelected,
                      onSelected: (_) => setState(() => _selectedGenre = genre),
                    );
                  },
                ),
              ),
              const SizedBox(height: 14),

              // Movie List
              Expanded(
                child: visibleMovies.isEmpty
                    ? _EmptyState(
                        selectedTab: _selectedTab,
                        hasSearch: _searchQuery.isNotEmpty,
                      )
                    : ListView.separated(
                        padding: const EdgeInsets.only(bottom: 88),
                        itemCount: visibleMovies.length,
                        separatorBuilder: (_, _) => const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final movie = visibleMovies[index];
                          return MovieCard(
                            movie: movie,
                            onTap: () => _openMovieDetails(movie),
                            onToggleWatched: () => _toggleWatched(movie),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openAddMovieSheet,
        backgroundColor: const Color(0xFFE50914),
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add_rounded),
        label: const Text(
          'Add Movie',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedTab,
        onDestinationSelected: (index) => setState(() => _selectedTab = index),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.bookmark_border_rounded),
            selectedIcon: Icon(Icons.bookmark_rounded),
            label: 'Watchlist',
          ),
          NavigationDestination(
            icon: Icon(Icons.check_circle_outline_rounded),
            selectedIcon: Icon(Icons.check_circle_rounded),
            label: 'Watched',
          ),
          NavigationDestination(
            icon: Icon(Icons.grid_view_outlined),
            selectedIcon: Icon(Icons.grid_view_rounded),
            label: 'All Movies',
          ),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  final int selectedTab;
  final bool hasSearch;

  const _EmptyState({required this.selectedTab, required this.hasSearch});

  @override
  Widget build(BuildContext context) {
    final title = hasSearch
        ? 'No matching movies found'
        : selectedTab == 0
            ? 'Your Watchlist is empty'
            : selectedTab == 1
                ? 'No watched movies yet'
                : 'No movies added yet';

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.movie_filter_outlined,
            size: 54,
            color: Color(0xFF475569),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xFFCBD5E1),
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Tap "+ Add Movie" to save a film.',
            style: TextStyle(fontSize: 13, color: Color(0xFF64748B)),
          ),
        ],
      ),
    );
  }
}
