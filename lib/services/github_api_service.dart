import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/repo_detail.dart';
import '../models/search_repos_response.dart';
import 'github_api_exception.dart';

class GithubApiService {
  static const _baseUrl = 'https://api.github.com';
  final http.Client _client;

  GithubApiService({http.Client? client}) : _client = client ?? http.Client();

  Future<SearchReposResponse> searchRepos(
    String query, {
    int page = 1,
    int perPage = 20,
  }) async {
    final uri = Uri.parse('$_baseUrl/search/repositories').replace(
      queryParameters: {'q': query, 'page': '$page', 'per_page': '$perPage'},
    );

    final response = await _client.get(uri);
    if (response.statusCode != 200) {
      throw GithubApiException(response.statusCode, response.body);
    }

    return SearchReposResponse.fromJson(
      jsonDecode(response.body) as Map<String, dynamic>,
    );
  }

  Future<RepoDetail> getRepoDetail(String fullName) async {
    final uri = Uri.parse('$_baseUrl/repos/$fullName');

    final response = await _client.get(uri);
    if (response.statusCode != 200) {
      throw GithubApiException(response.statusCode, response.body);
    }

    return RepoDetail.fromJson(
      jsonDecode(response.body) as Map<String, dynamic>,
    );
  }
}
