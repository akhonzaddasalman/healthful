// handling google sign in
// here if user exist the login other sign up the user;

import 'package:flutter/material.dart';
import 'package:healthful/Controller/Provider/authentication_provider.dart';
import 'package:healthful/Controller/Provider/internet_provider.dart';
import 'package:healthful/View/Utils/next_screen.dart';
import 'package:healthful/View/Utils/snack_bar.dart';
import 'package:healthful/View/theme/light_color.dart';
import 'package:provider/provider.dart';

Future handleSignUp(
  BuildContext context,
  String photoURL,
  String name,
  String phone,
  String email,
  String password,
) async {
  final sp = context.read<AuthProvider>();
  final ip = context.read<InternetProvider>();
  await ip.checkInternetConnection();
  sp.setLoading(true);

  if (!ip.hasInternet) {
    openSnackBar(context, "Check your Internet connection", LightColor.kDanger);
    sp.setLoading(false);
  } else {
    try {
      await sp.signUpWithEmailPassword(
        context,
        photoURL,
        name,
        phone,
        email,
        password,
      );
      sp.setLoading(false);
      if (sp.hasError) {
        openSnackBar(context, sp.errorCode ?? "An error occurred", LightColor.kDanger);
      } else {
        // checking whether user exists or not
        final userExists = await sp.checkUserExists();

        if (userExists) {
          // user exists
          openSnackBar(context, "Please SignIn Already Have Account", LightColor.kDanger);
          Future.delayed(const Duration(milliseconds: 500)).then((value) {
            nextScreenRemoveUntil(context, '/login');
          });
        } else {
          // user does not exist

          await sp.saveDataToFirestore();
          sp.setLoading(false);
        }
      }
    } catch (e) {
      // Handle any exceptions that may occur during the Google sign-in process.
      openSnackBar(context, "$e", LightColor.kDanger);
      sp.setLoading(false);
    }
  }
}
