import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20.0),
            Image.asset(
              'assets/logo.png',
              scale: 4,
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Healthful',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10.0),
            const Text(
              'Your Health Companion',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 20.0),
            const Text(
              'About Us:',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10.0),
            const Text(
              'Healthful is a comprehensive healthcare app designed to empower users to take control of their well-being. Our mission is to provide accessible and reliable health information, personalized guidance, and convenient telemedicine services.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Contact Us:',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10.0),
            ListTile(
              leading: const Icon(Icons.email),
              title: const Text('Email: info@healthfulapp.com'),
              onTap: () {
                // Handle email tapping action
              },
            ),
            ListTile(
              leading: const Icon(Icons.phone),
              title: const Text('Phone: +1 (123) 456-7890'),
              onTap: () {
                // Handle phone tapping action
              },
            ),
          ],
        ),
      ),
    );
  }
}
