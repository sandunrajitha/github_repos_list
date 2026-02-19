# GitHub Repos List

A Flutter app that searches GitHub repositories via the REST API and manages local favorites with offline persistence.

## Setup

```bash
flutter pub get
dart run build_runner build
flutter run
```

## Architecture

The app follows **MVVM** with Riverpod for state management:

```
lib/
  models/         → Data classes (Repo, RepoDetail, StarredRepo)
  services/       → API client, local storage
  view_models/    → Riverpod Notifiers, business logic
  views/          → Screens (Search, Detail, Favorites)
  widgets/        → Reusable UI components
```

- **Views** observe ViewModels via `ref.watch()` and never call APIs directly
- **ViewModels** use `@riverpod` codegen and delegate data access to Services
- **Services** handle HTTP requests and shared_preferences I/O

## Key Implementation Details

**Star sync across screens** : `FavoritesViewModel` is a global `@Riverpod(keepAlive: true)` notifier. All screens watch the same provider, so starring from search, detail, or favorites updates everywhere instantly through Riverpod's reactive rebuilds.

**Persistence** : Favorites are serialized as JSON and stored via `shared_preferences`. Every toggle writes the updated list immediately, and the list is loaded on app startup.

**Infinite scroll** : The search screen uses a `ScrollController` that triggers `loadNextPage()` when within 200px of the bottom. Pagination errors are silently handled to avoid clearing existing results.

**Nested navigators** : Each tab has its own `Navigator` inside an `IndexedStack`, so the bottom navigation bar stays visible when pushing the detail screen.

## Tests

```bash
flutter test
```

- **Unit tests** (`test/unit/favorites_test.dart`) FavoritesViewModel toggle behavior : adding, removing, and independent toggling of multiple repos
- **Widget tests** (`test/widget/search_screen_test.dart`) SearchScreen rendering states : home prompt, loading indicator, error with retry, empty results

## Demo

### iOS

<video src="https://github.com/sandunrajitha/github_repos_list/raw/main/github_repos_list_iOS.mp4" controls width="400"></video>

### Android

<video src="https://github.com/sandunrajitha/github_repos_list/raw/main/github_repos_list_Android.webm" controls width="400"></video>
