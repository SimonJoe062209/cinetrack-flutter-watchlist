import 'package:flutter/material.dart';
import '../data/sample_movies.dart';
import '../models/movie.dart';

/// Modal bottom sheet form used to add a new movie into the watchlist.
class AddMovieSheet extends StatefulWidget {
  final ValueChanged<Movie> onAddMovie;

  const AddMovieSheet({super.key, required this.onAddMovie});

  @override
  State<AddMovieSheet> createState() => _AddMovieSheetState();
}

class _AddMovieSheetState extends State<AddMovieSheet> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _yearController = TextEditingController(text: '2025');
  final _durationController = TextEditingController(text: '2h 10m');
  final _overviewController = TextEditingController();

  String _selectedGenre = 'Sci-Fi';
  double _rating = 8.0;

  @override
  void dispose() {
    _titleController.dispose();
    _yearController.dispose();
    _durationController.dispose();
    _overviewController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final parsedYear = int.tryParse(_yearController.text.trim()) ?? 2025;
    final overviewText = _overviewController.text.trim().isEmpty
        ? 'Added to your personal CineTrack movie watchlist.'
        : _overviewController.text.trim();

    final newMovie = Movie(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: _titleController.text.trim(),
      genre: _selectedGenre,
      year: parsedYear,
      duration: _durationController.text.trim().isEmpty
          ? '2h 00m'
          : _durationController.text.trim(),
      rating: double.parse(_rating.toStringAsFixed(1)),
      overview: overviewText,
      posterColors: Movie.colorsForGenre(_selectedGenre),
      isWatched: false,
    );

    widget.onAddMovie(newMovie);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    final selectableGenres =
        movieGenres.where((genre) => genre != 'All').toList();

    return Container(
      padding: EdgeInsets.fromLTRB(20, 14, 20, 20 + bottomInset),
      decoration: const BoxDecoration(
        color: Color(0xFF141B29),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Drag handle
              Center(
                child: Container(
                  width: 42,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF334155),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const Text(
                'Add New Movie',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFFF8FAFC),
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Save a movie to watch later with your own rating.',
                style: TextStyle(fontSize: 13, color: Color(0xFF94A3B8)),
              ),
              const SizedBox(height: 18),

              // Title Field
              TextFormField(
                controller: _titleController,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  labelText: 'Movie Title *',
                  hintText: 'e.g., Avengers: Doomsday',
                  prefixIcon: Icon(Icons.movie_outlined),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a movie title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),

              // Year & Duration Row
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _yearController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Year',
                        prefixIcon: Icon(Icons.calendar_today_outlined),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      controller: _durationController,
                      decoration: const InputDecoration(
                        labelText: 'Duration',
                        hintText: '2h 15m',
                        prefixIcon: Icon(Icons.schedule_outlined),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Genre Chips
              const Text(
                'Genre',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFFCBD5E1),
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: selectableGenres.map((genre) {
                  final isSelected = _selectedGenre == genre;
                  return ChoiceChip(
                    label: Text(genre),
                    selected: isSelected,
                    onSelected: (_) => setState(() => _selectedGenre = genre),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),

              // Rating Slider
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Expected / IMDb Rating',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFCBD5E1),
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.star_rounded,
                        size: 18,
                        color: Color(0xFFF5C518),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        _rating.toStringAsFixed(1),
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFFF5C518),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Slider(
                value: _rating,
                min: 1.0,
                max: 10.0,
                divisions: 18,
                activeColor: const Color(0xFFF5C518),
                inactiveColor: const Color(0xFF25324A),
                onChanged: (value) => setState(() => _rating = value),
              ),

              // Optional Notes
              TextFormField(
                controller: _overviewController,
                maxLines: 2,
                decoration: const InputDecoration(
                  labelText: 'Short Synopsis / Notes (optional)',
                  hintText: 'Why do you want to watch this movie?',
                ),
              ),
              const SizedBox(height: 20),

              // Submit Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: FilledButton.icon(
                  onPressed: _submit,
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFFE50914),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  icon: const Icon(Icons.bookmark_add_rounded),
                  label: const Text(
                    'Add to Watchlist',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
