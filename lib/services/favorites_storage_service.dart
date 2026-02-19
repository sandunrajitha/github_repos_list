import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';
import '../models/starred_repo.dart';

class FavoritesStorageService {
  Future<List<StarredRepo>> load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(storageKeyStarredRepos);
    if (raw == null || raw.isEmpty) return [];

    final list = jsonDecode(raw) as List;
    return list
        .map((e) => StarredRepo.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<void> save(List<StarredRepo> repos) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(repos.map((r) => r.toJson()).toList());
    await prefs.setString(storageKeyStarredRepos, jsonString);
  }
}
