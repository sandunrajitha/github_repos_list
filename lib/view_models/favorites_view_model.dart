import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/starred_repo.dart';
import '../services/favorites_storage_service.dart';

part 'favorites_view_model.g.dart';

@Riverpod(keepAlive: true)
class FavoritesViewModel extends _$FavoritesViewModel {
  final _storage = FavoritesStorageService();

  @override
  List<StarredRepo> build() {
    _load();
    return [];
  }

  Future<void> _load() async {
    state = await _storage.load();
  }

  Future<void> toggle(StarredRepo repo) async {
    final exists = state.any((r) => r.id == repo.id);
    if (exists) {
      state = state.where((r) => r.id != repo.id).toList();
    } else {
      state = [...state, repo];
    }
    await _storage.save(state);
  }
}
