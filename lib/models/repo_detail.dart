class RepoDetail {
  final int id;
  final String fullName;
  final String ownerAvatarUrl;
  final String? description;
  final String? language;
  final int stargazersCount;
  final int watchersCount;
  final int forksCount;
  final int openIssuesCount;
  final int subscribersCount;
  final String htmlUrl;

  RepoDetail({
    required this.id,
    required this.fullName,
    required this.ownerAvatarUrl,
    this.description,
    this.language,
    required this.stargazersCount,
    required this.watchersCount,
    required this.forksCount,
    required this.openIssuesCount,
    required this.subscribersCount,
    required this.htmlUrl,
  });

  factory RepoDetail.fromJson(Map<String, dynamic> json) {
    return RepoDetail(
      id: json['id'] as int,
      fullName: json['full_name'] as String,
      ownerAvatarUrl: json['owner']['avatar_url'] as String,
      description: json['description'] as String?,
      language: json['language'] as String?,
      stargazersCount: json['stargazers_count'] as int? ?? 0,
      watchersCount: json['watchers_count'] as int? ?? 0,
      forksCount: json['forks_count'] as int? ?? 0,
      openIssuesCount: json['open_issues_count'] as int? ?? 0,
      subscribersCount: json['subscribers_count'] as int? ?? 0,
      htmlUrl: json['html_url'] as String,
    );
  }
}
