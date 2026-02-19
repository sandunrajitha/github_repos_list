import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_repos_list/view_models/favorites_view_model.dart';
import 'package:github_repos_list/view_models/search_state.dart';
import 'package:github_repos_list/view_models/search_view_model.dart';
import 'package:github_repos_list/views/search_screen.dart';

Widget buildSearchScreen({SearchState searchState = const SearchState()}) {
  return ProviderScope(
    overrides: [
      searchViewModelProvider.overrideWithValue(searchState),
      favoritesViewModelProvider.overrideWithValue([]),
    ],
    child: const MaterialApp(home: SearchScreen()),
  );
}

void main() {
  group('SearchScreen', () {
    testWidgets('shows prompt text when query is empty', (tester) async {
      await tester.pumpWidget(buildSearchScreen());

      expect(find.text('Search GitHub repositories'), findsOneWidget);
    });

    testWidgets('shows loading indicator while searching', (tester) async {
      await tester.pumpWidget(
        buildSearchScreen(
          searchState: const SearchState(query: 'flutter', isLoading: true),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('shows error message with retry button', (tester) async {
      await tester.pumpWidget(
        buildSearchScreen(
          searchState: const SearchState(
            query: 'flutter',
            error: 'Failed to search repositories',
          ),
        ),
      );

      expect(find.text('Failed to search repositories'), findsOneWidget);
      expect(find.widgetWithText(ElevatedButton, 'Retry'), findsOneWidget);
    });

    testWidgets('shows empty state when no results found', (tester) async {
      await tester.pumpWidget(
        buildSearchScreen(
          searchState: const SearchState(query: 'xyznonexistent'),
        ),
      );

      expect(find.text('No repositories found'), findsOneWidget);
    });
  });
}
