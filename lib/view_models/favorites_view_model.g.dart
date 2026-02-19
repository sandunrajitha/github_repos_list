// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorites_view_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(FavoritesViewModel)
final favoritesViewModelProvider = FavoritesViewModelProvider._();

final class FavoritesViewModelProvider
    extends $NotifierProvider<FavoritesViewModel, List<StarredRepo>> {
  FavoritesViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'favoritesViewModelProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$favoritesViewModelHash();

  @$internal
  @override
  FavoritesViewModel create() => FavoritesViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<StarredRepo> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<StarredRepo>>(value),
    );
  }
}

String _$favoritesViewModelHash() =>
    r'63f5e98a29ae38d816dcf5330d09317ee4408da9';

abstract class _$FavoritesViewModel extends $Notifier<List<StarredRepo>> {
  List<StarredRepo> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<List<StarredRepo>, List<StarredRepo>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<StarredRepo>, List<StarredRepo>>,
              List<StarredRepo>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
