import 'package:flutter/material.dart';
import '../models/movie.dart';

/// Reusable dark card widget representing a single movie in the list.
class MovieCard extends StatelessWidget {
  final Movie movie;
  final VoidCallback onTap;
  final VoidCallback onToggleWatched;

  const MovieCard({
    super.key,
    required this.movie,
    required this.onTap,
    required this.onToggleWatched,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFF141B29),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: movie.isWatched
                  ? const Color(0xFF22C55E).withValues(alpha: 0.35)
                  : const Color(0xFF232D42),
            ),
          ),
          child: Row(
            children: [
              // Left stylized gradient poster tile with Hero animation
              Hero(
                tag: 'movie-poster-${movie.id}',
                child: Container(
                  width: 72,
                  height: 100,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: movie.posterColors,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(13),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.14),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Center(
                        child: Icon(
                          movie.genreIcon,
                          size: 32,
                          color: Colors.white.withValues(alpha: 0.92),
                        ),
                      ),
                      Positioned(
                        bottom: 6,
                        left: 6,
                        right: 6,
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.45),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            '${movie.year}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 14),

              // Middle column: Title, metadata, rating & status
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFFF8FAFC),
                        height: 1.25,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '${movie.genre}  •  ${movie.duration}',
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF94A3B8),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        // Star Rating Pill
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF5C518).withValues(alpha: 0.14),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.star_rounded,
                                size: 15,
                                color: Color(0xFFF5C518),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                movie.rating.toStringAsFixed(1),
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFFF5C518),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),

                        // Status Pill
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: movie.isWatched
                                ? const Color(0xFF22C55E).withValues(alpha: 0.14)
                                : const Color(0xFFE50914).withValues(alpha: 0.14),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            movie.isWatched ? 'Watched' : 'To Watch',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: movie.isWatched
                                  ? const Color(0xFF4ADE80)
                                  : const Color(0xFFFF6B6B),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),

              // Right action button to quickly toggle Watchlist <-> Watched
              IconButton(
                onPressed: onToggleWatched,
                tooltip: movie.isWatched
                    ? 'Move to Watchlist'
                    : 'Mark as Watched',
                style: IconButton.styleFrom(
                  backgroundColor: movie.isWatched
                      ? const Color(0xFF22C55E).withValues(alpha: 0.18)
                      : const Color(0xFF1E293B),
                  padding: const EdgeInsets.all(10),
                ),
                icon: Icon(
                  movie.isWatched
                      ? Icons.check_circle_rounded
                      : Icons.bookmark_add_outlined,
                  color: movie.isWatched
                      ? const Color(0xFF4ADE80)
                      : const Color(0xFFCBD5E1),
                  size: 22,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
