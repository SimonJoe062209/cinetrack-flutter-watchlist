import 'package:cinetrack_watchlist/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('CineTrack renders watchlist and supports search and tabs', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const CineTrackApp());

    // Header and initial Watchlist movie appear
    expect(find.text('CineTrack'), findsOneWidget);
    expect(find.text('Interstellar'), findsOneWidget);
    expect(find.text('The Dark Knight'), findsNothing);

    // Search filters down to Dune: Part Two
    await tester.enterText(find.byType(TextField), 'Dune');
    await tester.pump();
    expect(find.text('Dune: Part Two'), findsOneWidget);
    expect(find.text('Interstellar'), findsNothing);

    // Clear search and switch to Watched tab
    await tester.enterText(find.byType(TextField), '');
    await tester.pump();
    await tester.tap(find.text('Watched').last);
    await tester.pumpAndSettle();

    expect(find.text('The Dark Knight'), findsOneWidget);
    expect(find.text('Interstellar'), findsNothing);
  });

  testWidgets('User can add a new movie from the Add Movie sheet', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const CineTrackApp());

    await tester.tap(find.text('Add Movie'));
    await tester.pumpAndSettle();

    await tester.enterText(
      find.widgetWithText(TextFormField, 'Movie Title *'),
      'Blade Runner 2049',
    );
    await tester.ensureVisible(find.text('Add to Watchlist'));
    await tester.tap(find.text('Add to Watchlist'));
    await tester.pumpAndSettle();

    expect(find.text('Blade Runner 2049'), findsOneWidget);
  });
}
