import 'package:flutter/material.dart';

// Define color variables
const darkBackgroundColor = Color(0xFF201A30);
const textColor = Colors.white;
const accentColor = Color(0xFF8F5AFF); // Example purple accent
const cardBackgroundColor = Color(0xFF2D223A); // Example card background
const subTextColor = Color(0xFFB0AEB8); // Example lighter text

final Widget homeMobileView = Scaffold(
  backgroundColor: darkBackgroundColor,
  body: SafeArea(
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'Your Target',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          const SizedBox(height: 25),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            decoration: BoxDecoration(
              color: accentColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              'Persons Name',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: textColor,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: 30),
          Container(
            height: 250,
            width: double.infinity,
            decoration: BoxDecoration(
              color: cardBackgroundColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(
              Icons.person_outline,
              color: textColor.withAlpha(128),
              size: 150,
            ),
          ),
          const SizedBox(height: 30),
          Text(
            'Headline',
            style: TextStyle(
              color: textColor,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
            textAlign: TextAlign.justify,
            style: TextStyle(color: subTextColor, fontSize: 15, height: 1.4),
          ),
          const Spacer(),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: accentColor,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              minimumSize: const Size(double.infinity, 50),
            ),
            onPressed: () {
              debugPrint('Confirm Kill button pressed');
            },
            child: Text(
              'Confirm Kill',
              style: TextStyle(
                fontSize: 18,
                color: textColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    ),
  ),
);

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assassination Home'),
        backgroundColor: const Color(0xFF201A30),
      ),
      body: Center(
        child: Text(
          'Welcome to the Assassination Home Page',
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: const Color(0xFF201A30),
    );
  }
}
