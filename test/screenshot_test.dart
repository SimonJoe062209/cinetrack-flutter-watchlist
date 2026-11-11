import 'dart:io';

import 'package:cinetrack_watchlist/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> _loadFlutterFonts() async {
  const fontsDir =
      '/opt/homebrew/share/flutter/bin/cache/artifacts/material_fonts';

  for (final family in [
    'Roboto',
    '.AppleSystemUIFont',
    'CupertinoSystemText',
    'CupertinoSystemDisplay',
    '.SF Pro Text',
    '.SF Pro Display',
  ]) {
    final loader = FontLoader(family);
    for (final name in [
      'Roboto-Regular.ttf',
      'Roboto-Medium.ttf',
      'Roboto-Bold.ttf',
      'Roboto-Black.ttf',
    ]) {
      final file = File('$fontsDir/$name');
      if (file.existsSync()) {
        final bytes = file.readAsBytesSync();
        loader.addFont(Future.value(ByteData.sublistView(bytes)));
      }
    }
    await loader.load();
  }

  final iconsFile = File('$fontsDir/MaterialIcons-Regular.otf');
  if (iconsFile.existsSync()) {
    final bytes = iconsFile.readAsBytesSync();
    final iconLoader = FontLoader('MaterialIcons')
      ..addFont(Future.value(ByteData.sublistView(bytes)));
    await iconLoader.load();
  }
}

void main() {
  testWidgets('Capture app screenshots for report', (
    WidgetTester tester,
  ) async {
    await tester.runAsync(() => _loadFlutterFonts());

    tester.view.physicalSize = const Size(824, 1720);
    tester.view.devicePixelRatio = 2.0;
    addTearDown(() {
      tester.view.resetPhysicalSize();
      tester.view.resetDevicePixelRatio();
    });

    await tester.pumpWidget(const CineTrackApp());
    await tester.pumpAndSettle();

    await expectLater(
      find.byType(MaterialApp),
      matchesGoldenFile('../screenshots/home_watchlist.png'),
    );

    // Open Movie Detail screen for Interstellar
    await tester.tap(find.text('Interstellar'));
    await tester.pumpAndSettle();

    await expectLater(
      find.byType(MaterialApp),
      matchesGoldenFile('../screenshots/movie_details.png'),
    );

    // Go back and open Add Movie sheet
    await tester.pageBack();
    await tester.pumpAndSettle();
    await tester.tap(find.text('Add Movie'));
    await tester.pumpAndSettle();

    await expectLater(
      find.byType(MaterialApp),
      matchesGoldenFile('../screenshots/add_movie_sheet.png'),
    );
  });
}
