import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthful/Controller/Functions/sign_up_function.dart';
import 'package:healthful/Controller/Provider/authentication_provider.dart';
import 'package:healthful/View/Components/build_buttons.dart';
import 'package:healthful/View/theme/light_color.dart';
import 'package:healthful/View/widgets/text_field.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool passToggle = true;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authProvider = context.read<AuthProvider>();
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
                RoundedTextField(
                  controller: nameController,
                  hint: 'Enter Name',
                  color: Colors.transparent,
                  borderColor: Colors.transparent,
                  pIcon: Icon(Icons.person),
                ),
                const SizedBox(height: 10),
                RoundedTextField(
                  controller: emailController,
                  hint: 'Email Address',
                  color: Colors.transparent,
                  borderColor: Colors.transparent,
                  pIcon: Icon(Icons.email),
                ),
                const SizedBox(height: 10),
                RoundedTextField(
                  controller: phoneController,
                  hint: 'Phone Number',
                  color: Colors.transparent,
                  borderColor: Colors.transparent,
                  pIcon: Icon(Icons.phone),
                ),
                const SizedBox(height: 10),
                RoundedTextField(
                  controller: passwordController,
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
                    child: buildRegisterButton(() async {
                      authProvider.setLoading(true);
                      await handleSignUp(context, "", nameController.text, phoneController.text, emailController.text, passwordController.text);
                      authProvider.setLoading(false);
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
