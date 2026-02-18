class GithubApiException implements Exception {
  final int statusCode;
  final String body;

  GithubApiException(this.statusCode, this.body);

  @override
  String toString() => 'GitHub API error $statusCode';
}
