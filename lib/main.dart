import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:healthful/Controller/Provider/appointment_provider.dart';
import 'package:healthful/Controller/Provider/authentication_provider.dart';
import 'package:healthful/Controller/Provider/calender_provider.dart';
import 'package:healthful/Controller/Provider/chat_provider.dart';
import 'package:healthful/Controller/Provider/doctor_provider.dart';
import 'package:healthful/Controller/Provider/edit_profile_provider.dart';
import 'package:healthful/Controller/Provider/home_screen_provider.dart';
import 'package:healthful/Controller/Provider/internet_provider.dart';
import 'package:healthful/Controller/Provider/medication_provider.dart';
import 'package:healthful/Controller/Provider/symptoms_provider.dart';
import 'package:healthful/View/Screens/AppScreens/home_screen.dart';
import 'package:healthful/View/Screens/AuthenticationScreens/login_screen.dart';
import 'package:healthful/View/Screens/AuthenticationScreens/questionare_screen.dart';
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
        ChangeNotifierProvider(create: ((context) => AuthProvider())),
        ChangeNotifierProvider(create: ((context) => InternetProvider())),
        ChangeNotifierProvider(create: ((context) => EditProfileProvider())),
        ChangeNotifierProvider(create: ((context) => AppointmentProvider())),
        ChangeNotifierProvider(create: ((context) => DoctorProvider())),
        ChangeNotifierProvider(create: ((context) => ChatProvider())),
        ChangeNotifierProvider(create: ((context) => MedicationProvider())),
        ChangeNotifierProvider(create: ((context) => CalendarProvider())),
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
            '/questionnaire': (context) =>  QuestionnairePage(),
          },
          debugShowCheckedModeBanner: false,
          home: const SplashPage(),
        );
      }),
    );
  }
}
