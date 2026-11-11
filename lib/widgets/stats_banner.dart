import 'package:flutter/material.dart';

/// Displays a compact 3-column summary card at the top of the home screen
/// showing Total movies, To Watch count, and Watched count.
class StatsBanner extends StatelessWidget {
  final int totalCount;
  final int watchlistCount;
  final int watchedCount;

  const StatsBanner({
    super.key,
    required this.totalCount,
    required this.watchlistCount,
    required this.watchedCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF171F30), Color(0xFF111724)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFF243047)),
      ),
      child: Row(
        children: [
          _StatItem(
            label: 'Total',
            count: totalCount,
            accentColor: const Color(0xFF38BDF8),
            icon: Icons.movie_filter_rounded,
          ),
          _verticalDivider(),
          _StatItem(
            label: 'Watchlist',
            count: watchlistCount,
            accentColor: const Color(0xFFF5C518),
            icon: Icons.bookmark_rounded,
          ),
          _verticalDivider(),
          _StatItem(
            label: 'Watched',
            count: watchedCount,
            accentColor: const Color(0xFF22C55E),
            icon: Icons.check_circle_rounded,
          ),
        ],
      ),
    );
  }

  Widget _verticalDivider() {
    return Container(
      height: 34,
      width: 1,
      color: const Color(0xFF25324A),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final int count;
  final Color accentColor;
  final IconData icon;

  const _StatItem({
    required this.label,
    required this.count,
    required this.accentColor,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 15, color: accentColor),
              const SizedBox(width: 5),
              Text(
                '$count',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFFF8FAFC),
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Color(0xFF94A3B8),
            ),
          ),
        ],
      ),
    );
  }
}
