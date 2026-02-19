// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repo_detail_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(repoDetail)
final repoDetailProvider = RepoDetailFamily._();

final class RepoDetailProvider
    extends
        $FunctionalProvider<
          AsyncValue<RepoDetail>,
          RepoDetail,
          FutureOr<RepoDetail>
        >
    with $FutureModifier<RepoDetail>, $FutureProvider<RepoDetail> {
  RepoDetailProvider._({
    required RepoDetailFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'repoDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$repoDetailHash();

  @override
  String toString() {
    return r'repoDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<RepoDetail> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<RepoDetail> create(Ref ref) {
    final argument = this.argument as String;
    return repoDetail(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is RepoDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$repoDetailHash() => r'9e40cfec77dcdb94e322d70124815be7e0c2c7d7';

final class RepoDetailFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<RepoDetail>, String> {
  RepoDetailFamily._()
    : super(
        retry: null,
        name: r'repoDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  RepoDetailProvider call(String fullName) =>
      RepoDetailProvider._(argument: fullName, from: this);

  @override
  String toString() => r'repoDetailProvider';
}
