import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../services/github_api_service.dart';
import 'search_state.dart';

part 'search_view_model.g.dart';

@Riverpod(keepAlive: true)
class SearchViewModel extends _$SearchViewModel {
  final _api = GithubApiService();

  @override
  SearchState build() => const SearchState();

  Future<void> search(String query) async {
    if (query.trim().isEmpty) {
      state = const SearchState();
      return;
    }

    state = SearchState(query: query, isLoading: true);

    try {
      final result = await _api.searchRepos(query, page: 1);
      state = state.copyWith(
        repos: result.items,
        isLoading: false,
        currentPage: 1,
        hasMore: result.items.length >= 20,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: 'Failed to search repositories',
      );
    }
  }

  Future<void> loadNextPage() async {
    if (state.isLoading || !state.hasMore) return;

    state = state.copyWith(isLoading: true);
    final nextPage = state.currentPage + 1;

    try {
      final result = await _api.searchRepos(state.query, page: nextPage);
      state = state.copyWith(
        repos: [...state.repos, ...result.items],
        isLoading: false,
        currentPage: nextPage,
        hasMore: result.items.length >= 20,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }
}
