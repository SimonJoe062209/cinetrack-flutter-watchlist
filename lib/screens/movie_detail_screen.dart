import 'package:flutter/material.dart';
import '../models/movie.dart';

/// Displays full details of a selected movie, lets the user update its rating,
/// toggle its watched status, or delete it from the list.
class MovieDetailScreen extends StatefulWidget {
  final Movie movie;
  final ValueChanged<Movie> onMovieUpdated;
  final VoidCallback onMovieDeleted;

  const MovieDetailScreen({
    super.key,
    required this.movie,
    required this.onMovieUpdated,
    required this.onMovieDeleted,
  });

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  late Movie _movie;

  @override
  void initState() {
    super.initState();
    _movie = widget.movie;
  }

  void _toggleWatched() {
    setState(() {
      _movie = _movie.copyWith(isWatched: !_movie.isWatched);
    });
    widget.onMovieUpdated(_movie);
  }

  void _updateRating(double newRating) {
    setState(() {
      _movie = _movie.copyWith(
        rating: double.parse(newRating.toStringAsFixed(1)),
      );
    });
    widget.onMovieUpdated(_movie);
  }

  void _confirmDelete() {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: const Color(0xFF141B29),
        title: const Text('Remove Movie?'),
        content: Text('Remove "${_movie.title}" from your list?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              widget.onMovieDeleted();
              Navigator.of(context).pop();
            },
            style: FilledButton.styleFrom(
              backgroundColor: const Color(0xFFE50914),
            ),
            child: const Text('Remove'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie Details'),
        actions: [
          IconButton(
            onPressed: _confirmDelete,
            tooltip: 'Remove movie',
            icon: const Icon(Icons.delete_outline_rounded),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Poster Banner
            Hero(
              tag: 'movie-poster-${_movie.id}',
              child: Container(
                height: 210,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: _movie.posterColors,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.14),
                  ),
                ),
                child: Stack(
                  children: [
                    Center(
                      child: Icon(
                        _movie.genreIcon,
                        size: 76,
                        color: Colors.white.withValues(alpha: 0.9),
                      ),
                    ),
                    Positioned(
                      top: 14,
                      right: 14,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.48),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.star_rounded,
                              size: 16,
                              color: Color(0xFFF5C518),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              _movie.rating.toStringAsFixed(1),
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                decoration: TextDecoration.none,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Movie Title
            Text(
              _movie.title,
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w800,
                color: Color(0xFFF8FAFC),
              ),
            ),
            const SizedBox(height: 10),

            // Metadata Chips
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _InfoBadge(label: _movie.genre, icon: _movie.genreIcon),
                _InfoBadge(
                  label: '${_movie.year}',
                  icon: Icons.calendar_today_rounded,
                ),
                _InfoBadge(
                  label: _movie.duration,
                  icon: Icons.schedule_rounded,
                ),
                _InfoBadge(
                  label: _movie.isWatched ? 'Watched' : 'On Watchlist',
                  icon: _movie.isWatched
                      ? Icons.check_circle_rounded
                      : Icons.bookmark_rounded,
                  highlightColor: _movie.isWatched
                      ? const Color(0xFF4ADE80)
                      : const Color(0xFFF5C518),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Synopsis Section
            const Text(
              'Storyline',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Color(0xFFF8FAFC),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _movie.overview,
              style: const TextStyle(
                fontSize: 15,
                height: 1.55,
                color: Color(0xFFCBD5E1),
              ),
            ),
            const SizedBox(height: 24),

            // Interactive Rating Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF141B29),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: const Color(0xFF232D42)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Your Rating',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFFF8FAFC),
                        ),
                      ),
                      Text(
                        '${_movie.rating.toStringAsFixed(1)} / 10',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFFF5C518),
                        ),
                      ),
                    ],
                  ),
                  Slider(
                    value: _movie.rating,
                    min: 1.0,
                    max: 10.0,
                    divisions: 18,
                    activeColor: const Color(0xFFF5C518),
                    inactiveColor: const Color(0xFF25324A),
                    onChanged: _updateRating,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),

            // Primary Action Button
            SizedBox(
              width: double.infinity,
              height: 52,
              child: FilledButton.icon(
                onPressed: _toggleWatched,
                style: FilledButton.styleFrom(
                  backgroundColor: _movie.isWatched
                      ? const Color(0xFF1E293B)
                      : const Color(0xFF22C55E),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                icon: Icon(
                  _movie.isWatched
                      ? Icons.bookmark_add_outlined
                      : Icons.check_circle_rounded,
                ),
                label: Text(
                  _movie.isWatched
                      ? 'Move Back to Watchlist'
                      : 'Mark as Watched',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoBadge extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color? highlightColor;

  const _InfoBadge({
    required this.label,
    required this.icon,
    this.highlightColor,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = highlightColor ?? const Color(0xFFCBD5E1);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF141B29),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFF232D42)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: textColor),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
