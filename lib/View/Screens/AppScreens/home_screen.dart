import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthful/Controller/Provider/home_screen_provider.dart';
import 'package:healthful/View/Screens/AppScreens/SettingsScreen/settings_screen.dart';
import 'package:healthful/View/Screens/AppScreens/main_screen.dart';
import 'package:healthful/View/Screens/AppScreens/messages_screen.dart';
import 'package:healthful/View/Screens/AppScreens/schedule_screen.dart';
import 'package:healthful/View/theme/light_color.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeScreenProvider>(
      builder: (context, model, _) {
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: _buildPage(model.currentTab),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: LightColor.marron,
            //fixedColor: LightColor.marron,
            selectedItemColor: LightColor.marron,
            unselectedItemColor: LightColor.marron,
            currentIndex: model.currentTab,
            onTap: (index) => model.changeTab(index),
            items: [
              BottomNavigationBarItem(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                icon: const Icon(Icons.home_filled),
                label: "Home",
              ),
              const BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.chat_bubble_text_fill),
                label: "Messages",
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.calendar_month),
                label: "Schedule",
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: "Settings",
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPage(int index) {
    switch (index) {
      case 0:
        return const MainScreen();
      case 1:
        return const MessagesScreen();
      case 2:
        return const ScheduleScreen(); // Adjust these as needed
      case 3:
        return SettingsScreen();
      default:
        return const MainScreen();
    }
  }
}
