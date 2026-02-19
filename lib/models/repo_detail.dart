class RepoDetail {
  final int id;
  final String fullName;
  final String ownerLogin;
  final String ownerAvatarUrl;
  final int subscribersCount;
  final String htmlUrl;
  final String? licenseName;
  final String? licenseUrl;

  RepoDetail({
    required this.id,
    required this.fullName,
    required this.ownerLogin,
    required this.ownerAvatarUrl,
    required this.subscribersCount,
    required this.htmlUrl,
    this.licenseName,
    this.licenseUrl,
  });

  factory RepoDetail.fromJson(Map<String, dynamic> json) {
    final license = json['license'] as Map<String, dynamic>?;
    return RepoDetail(
      id: json['id'] as int,
      fullName: json['full_name'] as String,
      ownerLogin: json['owner']['login'] as String,
      ownerAvatarUrl: json['owner']['avatar_url'] as String,
      subscribersCount: json['subscribers_count'] as int? ?? 0,
      htmlUrl: json['html_url'] as String,
      licenseName: license?['name'] as String?,
      licenseUrl: license?['url'] as String?,
    );
  }
}
