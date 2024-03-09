import 'package:flutter/material.dart';
import 'package:healthful/View/Screens/AppScreens/home_page.dart';
import 'package:healthful/View/Screens/AuthenticationScreens/login_screen.dart';
import 'package:healthful/View/Screens/AuthenticationScreens/signup_screen.dart';
import 'package:healthful/View/Screens/IntroScreens/splash_page.dart';
import 'package:healthful/View/theme/theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Health Care',
      theme: AppTheme.lightTheme,
      routes: {
        '/welcomeScreen': (context) => const SplashPage(),
        '/home': (context) => const HomePage(),
        '/signIn': (context) => const LoginScreen(),
        '/signUp': (context) => const SignUpScreen(),
      },
      debugShowCheckedModeBanner: false,
      home: const SplashPage(),
    );
  }
}
