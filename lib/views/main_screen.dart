import 'package:flutter/material.dart';

import 'search_screen.dart';
import 'star_list_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          Navigator(
            key: _navigatorKeys[0],
            onGenerateRoute: (_) =>
                MaterialPageRoute(builder: (_) => const SearchScreen()),
          ),
          Navigator(
            key: _navigatorKeys[1],
            onGenerateRoute: (_) =>
                MaterialPageRoute(builder: (_) => const StarListScreen()),
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (i) => setState(() => _currentIndex = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.search), label: 'Search'),
          NavigationDestination(icon: Icon(Icons.star), label: 'Favorites'),
        ],
      ),
    );
  }
}
