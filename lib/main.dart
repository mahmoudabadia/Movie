import 'package:flutter/material.dart';
import 'package:movie_app/ui/authentication/forget_password_screen/forget_password_screen.dart';
import 'package:movie_app/ui/authentication/login_screen/login.dart';
import 'package:movie_app/ui/authentication/riegister_screen/rigester_screen.dart';
import 'package:movie_app/ui/home/home_screen.dart';
import 'package:movie_app/ui/home/tabs/home_tab/home_tab.dart';
import 'package:movie_app/ui/home/tabs/profile_tab/profile_tab.dart' show ProfileTab;
import 'package:movie_app/ui/home/tabs/prowse_tab/prowse_tab.dart';
import 'package:movie_app/ui/home/tabs/search_tab/search_tab.dart';
import 'package:movie_app/ui/onboarding/onboarding_screen.dart';
import 'package:movie_app/utils/app_routes.dart';
import 'l10n/app_localizations.dart';
import 'ui/authentication/riegister_screen/rigester_screen.dart';


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
      initialRoute: AppRoutes.onboardingRouteName,
      routes: {
        AppRoutes.homeRouteName: (context) => HomeScreen(),
        AppRoutes.homeTabRouteName: (context) => HomeTab(),
        AppRoutes.profileRouteName: (context) => ProfileTab(),
        AppRoutes.prowseRouteName: (context) => ProwseTab(),
        AppRoutes.searchRouteName: (context) => SearchTab(),
        AppRoutes.loginRouteName: (context) => LoginPage(),
        AppRoutes.forgetPassRouteName: (context) => ForgetPasswordScreen(),
        AppRoutes.registerRouteName: (context) => RegisterScreen(),
        AppRoutes.onboardingRouteName: (context) => OnboardingScreen(),
      },

      localizationsDelegates: AppLocalizations.localizationsDelegates,

      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}



