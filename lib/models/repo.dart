class Repo {
  final int id;
  final String fullName;
  final String ownerAvatarUrl;
  final String? language;
  final int stargazersCount;

  Repo({
    required this.id,
    required this.fullName,
    required this.ownerAvatarUrl,
    this.language,
    required this.stargazersCount,
  });

  factory Repo.fromJson(Map<String, dynamic> json) {
    return Repo(
      id: json['id'] as int,
      fullName: json['full_name'] as String,
      ownerAvatarUrl: json['owner']['avatar_url'] as String,
      language: json['language'] as String?,
      stargazersCount: json['stargazers_count'] as int? ?? 0,
    );
  }
}
