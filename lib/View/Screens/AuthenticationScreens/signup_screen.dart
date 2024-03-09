import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthful/View/Components/build_buttons.dart';
import 'package:healthful/View/Screens/AppScreens/home_page.dart';
import 'package:healthful/View/Utils/next_screen.dart';
import 'package:healthful/View/theme/light_color.dart';
import 'package:healthful/View/widgets/text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool passToggle = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                Image.asset(
                  "assets/signup.png",
                  scale: 5,
                ),
                const RoundedTextField(
                  hint: 'Enter Name',
                  color: Colors.transparent,
                  borderColor: Colors.transparent,
                  pIcon: Icon(Icons.person),
                ),
                const SizedBox(height: 10),
                const RoundedTextField(
                  hint: 'Email Address',
                  color: Colors.transparent,
                  borderColor: Colors.transparent,
                  pIcon: Icon(Icons.email),
                ),
                const SizedBox(height: 10),
                const RoundedTextField(
                  hint: 'Phone Number',
                  color: Colors.transparent,
                  borderColor: Colors.transparent,
                  pIcon: Icon(Icons.phone),
                ),
                const SizedBox(height: 10),
                RoundedTextField(
                  obscureText: passToggle,
                  hint: 'Password',
                  color: Colors.transparent,
                  borderColor: Colors.transparent,
                  pIcon: const Icon(Icons.lock),
                  sIcon: InkWell(
                    onTap: () {
                      if (passToggle == true) {
                        passToggle = false;
                      } else {
                        passToggle = true;
                      }
                      setState(() {});
                    },
                    child: passToggle ? const Icon(CupertinoIcons.eye_slash_fill) : const Icon(CupertinoIcons.eye_fill),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                    height: 60,
                    width: double.infinity,
                    child: buildRegisterButton(() {
                      nextScreen(context, HomePage());
                    }, "Sign Up", textStyle: GoogleFonts.poppins(color: LightColor.white, fontSize: 16, fontWeight: FontWeight.w600))),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Already Have An Account?",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: LightColor.black,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Sign In",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: LightColor.marron,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
