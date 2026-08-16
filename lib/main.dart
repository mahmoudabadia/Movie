import 'package:flutter/material.dart';

import 'package:movie_app/ui/home/home_screen.dart';
import 'package:movie_app/utils/app_routes.dart';
import 'l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.LoginRouteName,
      routes: {AppRoutes.homeRouteName: (context) => const HomeScreen()},

      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
