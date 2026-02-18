import 'package:flutter/material.dart';

import 'views/main_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GitHub Repos',
      theme: ThemeData(colorSchemeSeed: Colors.blue, useMaterial3: true),
      home: const MainScreen(),
    );
  }
}
