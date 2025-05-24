import 'package:flutter/material.dart';

// Define color variables
const darkBackgroundColor = Color(0xFF201A30);
const textColor = Colors.white;
const accentColor = Color(0xFF8F5AFF); // Example purple accent
const cardBackgroundColor = Color(0xFF2D223A); // Example card background
const subTextColor = Color(0xFFB0AEB8); // Example lighter text

final Widget homeWebView = Scaffold(
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
            'Your headline goes here. This is a brief description of the target.',
            style: TextStyle(color: subTextColor, fontSize: 16),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          // "Description" Text
          Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
            'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
            style: TextStyle(color: subTextColor, fontSize: 16),
            textAlign: TextAlign.center,
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
            ),
            onPressed: () {
              // Handle button press
            },
            child: const Text(
              'Start Assassination',
              style: TextStyle(
                color: textColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    ),
  ),
);
