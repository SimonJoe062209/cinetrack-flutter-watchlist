import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const CineTrackApp());
}

/// Root widget of the CineTrack Movie Watchlist application.
class CineTrackApp extends StatelessWidget {
  const CineTrackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CineTrack - Movie Watchlist',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0B0F17),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFE50914),
          secondary: Color(0xFFF5C518),
          surface: Color(0xFF141B29),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0B0F17),
          elevation: 0,
          centerTitle: false,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFF141B29),
          hintStyle: const TextStyle(color: Color(0xFF64748B)),
          prefixIconColor: const Color(0xFF94A3B8),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFF232D42)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFF232D42)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFE50914), width: 1.5),
          ),
        ),
        chipTheme: ChipThemeData(
          backgroundColor: const Color(0xFF141B29),
          selectedColor: const Color(0xFFE50914).withValues(alpha: 0.22),
          checkmarkColor: const Color(0xFFFF6B76),
          side: const BorderSide(color: Color(0xFF232D42)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          labelStyle: const TextStyle(
            fontFamily: 'Roboto',
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Color(0xFFCBD5E1),
          ),
          secondaryLabelStyle: const TextStyle(
            fontFamily: 'Roboto',
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: Color(0xFFF8FAFC),
          ),
        ),
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: const Color(0xFF101622),
          indicatorColor: const Color(0xFFE50914).withValues(alpha: 0.24),
          iconTheme: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return const IconThemeData(color: Color(0xFFFF5A67), size: 24);
            }
            return const IconThemeData(color: Color(0xFF94A3B8), size: 24);
          }),
          labelTextStyle: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Color(0xFFF8FAFC),
              );
            }
            return const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Color(0xFF94A3B8),
            );
          }),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
