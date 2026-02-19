import 'package:flutter/material.dart';

import '../models/repo.dart';
import 'star_button.dart';

class RepoListTile extends StatelessWidget {
  final String fullName;
  final String avatarUrl;
  final bool isStarred;
  final VoidCallback onTap;
  final VoidCallback onStarToggle;

  const RepoListTile({
    super.key,
    required this.fullName,
    required this.avatarUrl,
    required this.isStarred,
    required this.onTap,
    required this.onStarToggle,
  });

  factory RepoListTile.fromRepo({
    required Repo repo,
    required bool isStarred,
    required VoidCallback onTap,
    required VoidCallback onStarToggle,
  }) {
    return RepoListTile(
      fullName: repo.fullName,
      avatarUrl: repo.ownerAvatarUrl,
      isStarred: isStarred,
      onTap: onTap,
      onStarToggle: onStarToggle,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(backgroundImage: NetworkImage(avatarUrl)),
      title: Text(fullName, maxLines: 1, overflow: TextOverflow.ellipsis),
      trailing: StarButton(isStarred: isStarred, onPressed: onStarToggle),
      onTap: onTap,
    );
  }
}
