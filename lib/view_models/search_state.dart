import '../models/repo.dart';

class SearchState {
  final List<Repo> repos;
  final bool isLoading;
  final String? error;
  final int currentPage;
  final bool hasMore;
  final String query;

  const SearchState({
    this.repos = const [],
    this.isLoading = false,
    this.error,
    this.currentPage = 1,
    this.hasMore = true,
    this.query = '',
  });

  SearchState copyWith({
    List<Repo>? repos,
    bool? isLoading,
    String? error,
    int? currentPage,
    bool? hasMore,
    String? query,
  }) {
    return SearchState(
      repos: repos ?? this.repos,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      currentPage: currentPage ?? this.currentPage,
      hasMore: hasMore ?? this.hasMore,
      query: query ?? this.query,
    );
  }
}
