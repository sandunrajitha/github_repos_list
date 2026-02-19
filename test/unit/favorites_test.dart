import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:github_repos_list/models/starred_repo.dart';
import 'package:github_repos_list/view_models/favorites_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('FavoritesViewModel', () {
    late ProviderContainer container;

    setUp(() {
      SharedPreferences.setMockInitialValues({});
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test('initial state is empty', () {
      final state = container.read(favoritesViewModelProvider);
      expect(state, isEmpty);
    });

    test('toggle adds a repo to favorites', () async {
      container.read(favoritesViewModelProvider);
      await Future.delayed(Duration.zero);

      final notifier = container.read(favoritesViewModelProvider.notifier);
      final repo = StarredRepo(
        id: 1,
        fullName: 'flutter/flutter',
        ownerAvatarUrl: 'https://example.com/avatar.png',
      );

      await notifier.toggle(repo);

      final state = container.read(favoritesViewModelProvider);
      expect(state.length, 1);
      expect(state.first.id, 1);
      expect(state.first.fullName, 'flutter/flutter');
    });

    test('toggle removes a repo when already favorited', () async {
      container.read(favoritesViewModelProvider);
      await Future.delayed(Duration.zero);

      final notifier = container.read(favoritesViewModelProvider.notifier);
      final repo = StarredRepo(
        id: 1,
        fullName: 'flutter/flutter',
        ownerAvatarUrl: 'https://example.com/avatar.png',
      );

      await notifier.toggle(repo);
      await notifier.toggle(repo);

      final state = container.read(favoritesViewModelProvider);
      expect(state, isEmpty);
    });

    test('toggling one repo does not affect others', () async {
      container.read(favoritesViewModelProvider);
      await Future.delayed(Duration.zero);

      final notifier = container.read(favoritesViewModelProvider.notifier);
      final repo1 = StarredRepo(
        id: 1,
        fullName: 'flutter/flutter',
        ownerAvatarUrl: 'https://example.com/a.png',
      );
      final repo2 = StarredRepo(
        id: 2,
        fullName: 'dart-lang/sdk',
        ownerAvatarUrl: 'https://example.com/b.png',
      );

      await notifier.toggle(repo1);
      await notifier.toggle(repo2);

      expect(container.read(favoritesViewModelProvider).length, 2);

      await notifier.toggle(repo1);

      final state = container.read(favoritesViewModelProvider);
      expect(state.length, 1);
      expect(state.first.id, 2);
    });
  });
}
