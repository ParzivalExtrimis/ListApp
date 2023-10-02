import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping/screens/shopping_list_screen.dart';

void main() {
  runApp(const ProviderScope(child: App()));
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopper',
      theme: ThemeData.dark().copyWith(
        useMaterial3: true,
        snackBarTheme: kSnackBarTheme,
        colorScheme: kColorScheme,
        scaffoldBackgroundColor: const Color.fromARGB(255, 50, 58, 60),
      ),
      home: const ShoppingListScreen(),
    );
  }
}

final SnackBarThemeData kSnackBarTheme = SnackBarThemeData(
  backgroundColor:
      kColorScheme.primary.withOpacity(0.5), // Set teal as the primary color
  contentTextStyle: TextStyle(
    color: kColorScheme.background, // Text color
    fontSize: 16.0, // Text font size
    fontWeight: FontWeight.bold,
  ),
  actionTextColor: Colors.yellow, // Action text color
  elevation: 4.0, // Snackbar elevation
);

final ColorScheme kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 147, 229, 250),
  brightness: Brightness.dark,
  surface: const Color.fromARGB(255, 42, 51, 59),
);
