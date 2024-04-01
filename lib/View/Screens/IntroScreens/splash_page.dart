import 'dart:async';

import 'package:flutter/material.dart';
import 'package:healthful/Controller/Provider/authentication_provider.dart';
import 'package:healthful/View/Utils/next_screen.dart';
import 'package:healthful/View/theme/extention.dart';
import 'package:healthful/View/theme/light_color.dart';
import 'package:healthful/View/theme/text_styles.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    final authProvider = context.read<AuthProvider>();
    authProvider.getDataFromSharedPreferences();
    Timer(const Duration(seconds: 3), () {
      authProvider.isSignedIn ? nextScreenRemoveUntil(context, "/home") : nextScreenRemoveUntil(context, "/signIn");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  "assets/doctor_face.png",
                ),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Positioned.fill(
            child: Opacity(
              opacity: .6,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [LightColor.marronExtraLight, LightColor.marron],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      tileMode: TileMode.mirror,
                      stops: [.5, 6]),
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                "assets/logo.png",
                //color: Colors.white,
                scale: 3,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  "Time To HealthFul",
                  style: TextStyles.h1Style.black,
                ),
              ),
              Text(
                "Empowering Health, One Tap at a Time",
                style: TextStyles.bodySm.black.bold,
              ),
            ],
          ).alignTopCenter,
        ],
      ),
    );
  }
}
