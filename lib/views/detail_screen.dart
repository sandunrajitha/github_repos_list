import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/starred_repo.dart';
import '../view_models/favorites_view_model.dart';
import '../view_models/repo_detail_view_model.dart';
import '../widgets/star_button.dart';

class DetailScreen extends ConsumerWidget {
  final String fullName;

  const DetailScreen({super.key, required this.fullName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailAsync = ref.watch(repoDetailProvider(fullName));
    final favorites = ref.watch(favoritesViewModelProvider);

    return Scaffold(
      appBar: AppBar(title: Text(fullName.split('/').last)),
      body: detailAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Failed to load repository details'),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () => ref.invalidate(repoDetailProvider(fullName)),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
        data: (detail) {
          final isStarred = favorites.any((s) => s.id == detail.id);
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      StarButton(
                        isStarred: isStarred,
                        onPressed: () {
                          ref
                              .read(favoritesViewModelProvider.notifier)
                              .toggle(
                                StarredRepo(
                                  id: detail.id,
                                  fullName: detail.fullName,
                                  ownerAvatarUrl: detail.ownerAvatarUrl,
                                ),
                              );
                        },
                      ),
                      const Text('Star'),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Text('Owner', style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 8),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundImage: NetworkImage(detail.ownerAvatarUrl),
                    ),
                    const SizedBox(width: 12),
                    Text('name: ${detail.ownerLogin}'),
                  ],
                ),
                const SizedBox(height: 24),
                Text(
                  'Repository URL',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text('url:  ${detail.htmlUrl}'),
                const SizedBox(height: 24),
                Text(
                  'Subscribers',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text('${detail.subscribersCount}'),
                const SizedBox(height: 24),
                Text('License', style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 8),
                Text('name: ${detail.licenseName ?? 'N/A'}'),
                if (detail.licenseUrl != null)
                  Text('url:  ${detail.licenseUrl}'),
              ],
            ),
          );
        },
      ),
    );
  }
}
