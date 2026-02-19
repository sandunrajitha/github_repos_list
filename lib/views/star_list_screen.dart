import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../view_models/favorites_view_model.dart';
import '../widgets/repo_list_tile.dart';

class StarListScreen extends ConsumerWidget {
  const StarListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoritesViewModelProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Favorites')),
      body: favorites.isEmpty
          ? const Center(child: Text('No favorites yet'))
          : ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final starred = favorites[index];
                return RepoListTile(
                  fullName: starred.fullName,
                  avatarUrl: starred.ownerAvatarUrl,
                  isStarred: true,
                  onTap: () {},
                  onStarToggle: () {
                    ref
                        .read(favoritesViewModelProvider.notifier)
                        .toggle(starred);
                  },
                );
              },
            ),
    );
  }
}
