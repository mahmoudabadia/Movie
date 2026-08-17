import 'package:flutter/material.dart';
import 'package:movie_app/ui/home/home_screen.dart';
import 'package:movie_app/utils/app_routes.dart';

import 'l10n/app_localizations.dart';
import 'ui/home/home_screen.dart';
import 'utils/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie App',
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.homeRouteName,
      routes: {AppRoutes.homeRouteName: (context) => HomeScreen()},

      localizationsDelegates: AppLocalizations.localizationsDelegates,

      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale('en'),
    );
  }
}

