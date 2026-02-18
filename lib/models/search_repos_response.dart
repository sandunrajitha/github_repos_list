import 'repo.dart';

class SearchReposResponse {
  final List<Repo> items;
  final int totalCount;

  SearchReposResponse({required this.items, required this.totalCount});

  factory SearchReposResponse.fromJson(Map<String, dynamic> json) {
    return SearchReposResponse(
      items: (json['items'] as List)
          .map((e) => Repo.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalCount: json['total_count'] as int,
    );
  }
}
