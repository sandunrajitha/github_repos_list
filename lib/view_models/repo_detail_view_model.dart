import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/repo_detail.dart';
import '../services/github_api_service.dart';

part 'repo_detail_view_model.g.dart';

@riverpod
Future<RepoDetail> repoDetail(Ref ref, String fullName) async {
  final api = GithubApiService();
  return api.getRepoDetail(fullName);
}
