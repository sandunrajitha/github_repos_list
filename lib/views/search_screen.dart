import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:github_repos_list/view_models/search_state.dart';

import '../view_models/search_view_model.dart';
import '../widgets/repo_list_tile.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final _searchController = TextEditingController();
  final _scrollController = ScrollController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      ref.read(searchViewModelProvider.notifier).loadNextPage();
    }
  }

  void _onSearchChanged(String query) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      ref.read(searchViewModelProvider.notifier).search(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    final searchState = ref.watch(searchViewModelProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Search')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search repositories...',
                prefixIcon: const Icon(Icons.search),
                border: const OutlineInputBorder(),
                suffixIcon: searchState.query.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          ref.read(searchViewModelProvider.notifier).search('');
                        },
                      )
                    : null,
              ),
              onChanged: _onSearchChanged,
            ),
          ),
          Expanded(child: _buildBody(searchState)),
        ],
      ),
    );
  }

  Widget _buildBody(SearchState searchState) {
    if (searchState.query.isEmpty) {
      return const Center(child: Text('Search GitHub repositories'));
    }
    if (searchState.isLoading && searchState.repos.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    if (searchState.error != null && searchState.repos.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(searchState.error!),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () => ref
                  .read(searchViewModelProvider.notifier)
                  .search(searchState.query),
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }
    if (searchState.repos.isEmpty) {
      return const Center(child: Text('No repositories found'));
    }

    return ListView.builder(
      controller: _scrollController,
      itemCount: searchState.repos.length + (searchState.hasMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == searchState.repos.length) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: CircularProgressIndicator(),
            ),
          );
        }
        final repo = searchState.repos[index];
        return RepoListTile.fromRepo(
          repo: repo,
          isStarred: false,
          onTap: () {},
          onStarToggle: () {},
        );
      },
    );
  }
}
