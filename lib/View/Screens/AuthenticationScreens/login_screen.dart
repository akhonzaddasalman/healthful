import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthful/View/Components/build_buttons.dart';
import 'package:healthful/View/Screens/AppScreens/home_page.dart';
import 'package:healthful/View/Screens/AuthenticationScreens/signup_screen.dart';
import 'package:healthful/View/Utils/next_screen.dart';
import 'package:healthful/View/theme/light_color.dart';
import 'package:healthful/View/widgets/text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _passwordVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Image.asset("assets/login.png"),
                ),
                const RoundedTextField(
                  hint: 'Enter Name',
                  color: Colors.transparent,
                  borderColor: Colors.transparent,
                  pIcon: Icon(Icons.person),
                ),
                const SizedBox(height: 20),
                RoundedTextField(
                  obscureText: _passwordVisible,
                  hint: 'Password',
                  color: Colors.transparent,
                  borderColor: Colors.transparent,
                  pIcon: const Icon(Icons.lock),
                  sIcon: IconButton(
                    icon: Icon(
                      _passwordVisible ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                    height: 60,
                    width: double.infinity,
                    child: buildRegisterButton(() {
                      nextScreen(context, const HomePage());
                    }, "Login", textStyle: GoogleFonts.poppins(color: LightColor.white, fontSize: 16, fontWeight: FontWeight.w600))),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't Have An Account?",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: LightColor.black,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUpScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        "Sign Up",
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
