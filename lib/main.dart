import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'screens/seed_data_screen.dart';
import 'firebase_options.dart';
import 'screens/main_navigation_screen.dart';
import 'screens/search_screen.dart';
import 'screens/services_screen.dart';
import 'screens/design_process_screen.dart';
import 'state/app_state.dart';
import 'state/favorites_state.dart';
import 'utils/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppState()),
        ChangeNotifierProvider(create: (_) => FavoritesState()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    return MaterialApp(
      title: 'Canvas Interior Studio',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.themeForMood(appState.selectedMood),
      home: const MainNavigationScreen(),

      routes: {
        '/search': (_) => const SearchScreen(),
        '/services': (_) => const ServicesScreen(),
        '/process': (_) => const DesignProcessScreen(),
      },
    );
  }
}