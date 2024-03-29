import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:healthful/Controller/Provider/home_screen_provider.dart';
import 'package:healthful/Controller/Provider/symptoms_provider.dart';
import 'package:healthful/View/Screens/AppScreens/home_screen.dart';
import 'package:healthful/View/Screens/AuthenticationScreens/login_screen.dart';
import 'package:healthful/View/Screens/AuthenticationScreens/signup_screen.dart';
import 'package:healthful/View/Screens/IntroScreens/splash_page.dart';
import 'package:healthful/View/theme/theme.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ((context) => HomeScreenProvider())),
        ChangeNotifierProvider(create: ((context) => SymptomProvider())),
      ],
      child: Builder(builder: (context) {
        return MaterialApp(
          title: 'Health Care',
          theme: AppTheme.lightTheme,
          routes: {
            '/welcomeScreen': (context) => const SplashPage(),
            '/home': (context) => const HomeScreen(),
            '/signIn': (context) => const LoginScreen(),
            '/signUp': (context) => const SignUpScreen(),
          },
          debugShowCheckedModeBanner: false,
          home: const SplashPage(),
        );
      }),
    );
  }
}
