import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthful/View/Screens/AppScreens/SettingsScreen/edit_profile_screen.dart';
import 'package:healthful/View/Screens/AppScreens/SettingsScreen/healthtips_screen.dart';
import 'package:healthful/View/Screens/AppScreens/SettingsScreen/medication_reminder_screen.dart';
import 'package:healthful/View/Screens/AppScreens/SettingsScreen/symptoms_checker_screen.dart';
import 'package:healthful/View/Utils/next_screen.dart';
import 'package:healthful/View/theme/light_color.dart';
import 'package:healthful/View/widgets/listTile_widget.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Settings",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 20),
            const Align(
              alignment: Alignment.center,
              child: CircleAvatar(
                backgroundColor: LightColor.marron,
                radius: 45,
                child: CircleAvatar(
                  radius: 41,
                  backgroundImage: AssetImage("assets/doctor.png"),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                "Dr. Smith",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 25,
                ),
              ),
            ),
            Align(
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () {
                    nextScreen(context, const EditProfileScreen());
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Edit Profile", style: GoogleFonts.poppins(color: const Color(0xff103BC7))),
                  ),
                )),
            const Divider(height: 30),
            // CustomListTile(
            //     leadingIcon: CupertinoIcons.person,
            //     title: "Profile",
            //     onTap: () {},
            //     trailingIcon: Icons.arrow_forward_ios_rounded,
            //     boxColor: Colors.blue.shade100,
            //     iconColor: Colors.blue),
            // const SizedBox(height: 10),
            CustomListTile(
                leadingIcon: Icons.notifications_none_outlined,
                title: "Medical Reminder",
                onTap: () {
                  nextScreen(context, const MedicationReminderPage());
                },
                trailingIcon: Icons.arrow_forward_ios_rounded,
                boxColor: Colors.deepPurple.shade100,
                iconColor: LightColor.marron),
            const SizedBox(height: 10),
            CustomListTile(
                leadingIcon: Icons.medical_information,
                title: "Symptoms Checker",
                onTap: () {
                  nextScreen(context, const SymptomCheckerScreen());
                },
                trailingIcon: Icons.arrow_forward_ios_rounded,
                boxColor: Colors.cyanAccent.shade100,
                iconColor: Colors.cyan),
            const SizedBox(height: 10),
            CustomListTile(
                leadingIcon: Icons.tips_and_updates,
                title: "Health Tips",
                onTap: () {
                  nextScreen(context, HealthTipsScreen());
                },
                trailingIcon: Icons.arrow_forward_ios_rounded,
                boxColor: Colors.greenAccent.shade100,
                iconColor: Colors.green),
            const SizedBox(height: 10),
            CustomListTile(
                leadingIcon: Icons.settings_suggest_outlined,
                title: "General Settings",
                onTap: () {},
                trailingIcon: Icons.arrow_forward_ios_rounded,
                boxColor: Colors.orange.shade100,
                iconColor: Colors.orange),
            const SizedBox(height: 10),
            CustomListTile(
                leadingIcon: Icons.info_outline_rounded,
                title: "About Us",
                onTap: () {},
                trailingIcon: Icons.arrow_forward_ios_rounded,
                boxColor: Colors.green.shade100,
                iconColor: Colors.green),
            const Divider(height: 20),
            CustomListTile(
                leadingIcon: Icons.logout,
                title: "Log Out",
                onTap: () {},
                trailingIcon: Icons.arrow_forward_ios_rounded,
                boxColor: Colors.redAccent.shade100,
                iconColor: Colors.red),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
