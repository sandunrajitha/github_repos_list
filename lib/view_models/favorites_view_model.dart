import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/starred_repo.dart';

part 'favorites_view_model.g.dart';

const _storageKey = 'starred_repos';

@Riverpod(keepAlive: true)
class FavoritesViewModel extends _$FavoritesViewModel {
  @override
  List<StarredRepo> build() {
    _loadFromPrefs();
    return [];
  }

  Future<void> _loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_storageKey);
    if (raw != null && raw.isNotEmpty) {
      final list = jsonDecode(raw) as List;
      state = list
          .map((e) => StarredRepo.fromJson(e as Map<String, dynamic>))
          .toList();
    }
  }

  Future<void> toggle(StarredRepo repo) async {
    final exists = state.any((r) => r.id == repo.id);
    if (exists) {
      state = state.where((r) => r.id != repo.id).toList();
    } else {
      state = [...state, repo];
    }
    await _persist();
  }

  bool isStarred(int repoId) {
    return state.any((r) => r.id == repoId);
  }

  Future<void> _persist() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(state.map((r) => r.toJson()).toList());
    await prefs.setString(_storageKey, jsonString);
  }
}
