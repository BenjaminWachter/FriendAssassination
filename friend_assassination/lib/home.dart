// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:friend_assassination/domain/responsive_layout.dart';


class AssassinationHome extends StatefulWidget {
  const AssassinationHome({super.key});

  @override
  State<AssassinationHome> createState() => _AssassinationHomeState();
}

class _AssassinationHomeState extends State<AssassinationHome> {

  static const Color darkBackgroundColor = Color(0xFF201A30); // Darker purple/blue
  static const Color cardBackgroundColor = Color(0xFF2D2F3E); // Slightly lighter dark shade
  static const Color accentColor = Color(0xFF7B5AFF); // Purple accent
  static const Color textColor = Colors.white;
  static const Color subTextColor = Colors.white70;

@override
  Widget build(BuildContext context) {
    Widget homeWebView = Scaffold(
      // Setting the background color of the scaffold
      backgroundColor: darkBackgroundColor,
      // Using SafeArea to avoid intrusions by system UI (status bar, notch)
      body: SafeArea(
        // Adding padding around the main content
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          // Main column to arrange widgets vertically
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch, // Stretch children horizontally
            children: <Widget>[
              // "Your Target" Title
              const Text(
                'Your Target',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 25),

              // "Persons Name" Container
              Container(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                decoration: BoxDecoration(
                  color: accentColor, // Purple accent background
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
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

              // Profile Image/Avatar Placeholder
              Container(
                height: 250, // Define a fixed height for the placeholder
                width: double.infinity, // Take full width
                decoration: BoxDecoration(
                  color: cardBackgroundColor, // Background for the placeholder area
                  borderRadius: BorderRadius.circular(20), // Rounded corners
                ),
                // Placeholder icon
                child: Icon(
                  Icons.person_outline, // Generic person icon
                  color: textColor.withAlpha(128), // Semi-transparent white // Replaced withOpacity
                  size: 150, // Large icon size
                ),
              ),
              const SizedBox(height: 30),

              // "Headline" Text
              const Text(
                'Headline',
                style: TextStyle(
                  color: textColor,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),

              // "Lorem ipsum" Description Text
              const Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
                textAlign: TextAlign.justify, // Justified text alignment
                style: TextStyle(
                  color: subTextColor, // Lighter text color for description
                  fontSize: 15,
                  height: 1.4, // Line height
                ),
              ),
              // Spacer to push the button to the bottom if there's extra space
              const Spacer(), 
              const SizedBox(height: 20), // Some space before the button

              // "Confirm Kill" Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: accentColor, // Purple accent background
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // Rounded corners for the button
                  ),
                  // Minimum size for the button to ensure it's prominent
                  minimumSize: const Size(double.infinity, 50), 
                ),
                onPressed: () {
                  // Action to perform when the button is pressed
                  // For example, show a confirmation dialog or navigate
                  debugPrint('Confirm Kill button pressed');
                  // You could show the dialog from the Figma design here
                  // showDialog(context: context, builder: (context) => ...);
                },
                child: const Text(
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

    return ResponsiveLayout(phoneView: homeWebView, webView: homeWebView);
  }
}