import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movie_app/ui/authentication/forget_password_screen/forget_password_screen.dart';
import 'package:movie_app/ui/authentication/login_screen/login.dart';
import 'package:movie_app/ui/authentication/riegister_screen/rigester_screen.dart';
import 'package:movie_app/ui/cubit/cubit_language.dart';
import 'package:movie_app/ui/home/home_screen.dart';
import 'package:movie_app/ui/home/tabs/home_tab/home_tab.dart';
import 'package:movie_app/ui/home/tabs/profile_tab/profile_tab.dart';
import 'package:movie_app/ui/home/tabs/profile_tab/update_profile/create_update_profile.dart';
import 'package:movie_app/ui/home/tabs/prowse_tab/prowse_tab.dart';
import 'package:movie_app/ui/home/tabs/search_tab/search_tab.dart';
import 'package:movie_app/ui/onboarding/onboarding_screen.dart';
import 'package:movie_app/ui/splash/splash_screen.dart';
import 'package:movie_app/utils/app_routes.dart';
import 'firebase_options.dart';
import 'l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseAuth.instance.setSettings(
    appVerificationDisabledForTesting: true,
  );
  await GoogleSignIn.instance.initialize(
    serverClientId: '523636065584-a3j3hqb92da10jakql7n8avf0mmndjrg.apps.googleusercontent.com',
  );

  runApp(
    BlocProvider(create: (context) => LanguageCubit(), child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, Locale>(
      builder: (context, currentLocale) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,

          initialRoute: AppRoutes.splashRouteName,
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
            AppRoutes.splashRouteName: (context) => SplashScreen(),
            AppRoutes.createUpdateRouteName: (context) => CreateUpdate(),
          },
          locale: currentLocale,

          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        );
      },
    );
  }
}
