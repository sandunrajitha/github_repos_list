class StarredRepo {
  final int id;
  final String fullName;
  final String ownerAvatarUrl;

  StarredRepo({
    required this.id,
    required this.fullName,
    required this.ownerAvatarUrl,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'full_name': fullName,
    'owner_avatar_url': ownerAvatarUrl,
  };

  factory StarredRepo.fromJson(Map<String, dynamic> json) {
    return StarredRepo(
      id: json['id'] as int,
      fullName: json['full_name'] as String,
      ownerAvatarUrl: json['owner_avatar_url'] as String,
    );
  }
}
