
import 'package:flutter/material.dart';

class LoginPhonePage extends StatelessWidget {
  final TextEditingController userController;
  final TextEditingController passwordController;
  final VoidCallback onLogin;
  final VoidCallback onExit;

  const LoginPhonePage({
    Key? key,
    required this.userController,
    required this.passwordController,
    required this.onLogin,
    required this.onExit,
  }) : super(key: key);

  static const Color darkBackgroundColor = Color.fromARGB(0, 251, 0, 0);
  // static const Color cardBackgroundColor = Color(0xFF2D2F3E); // Not used here, but kept for consistency if needed later
  // static const Color accentColor = Color(0xFF7B5AFF); // Not used here
  // static const Color textColor = Colors.white; // Not used directly, relies on Theme
  // static const Color subTextColor = Colors.white70; // Not used directly, relies on Theme


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double formWidth = screenWidth * 0.9; // Adjusted for smaller screens

    return Scaffold(
      backgroundColor: darkBackgroundColor,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0), // Adjusted padding for phone
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: formWidth,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                // Title
                Text(
                  'Friend',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontSize: 32, // Slightly smaller for phone
                        color: Colors.white,
                      ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Assassination',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontSize: 42, // Slightly smaller for phone
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                // Subtitle
                Text(
                  'How well do you know your friends?',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontSize: 14, // Slightly smaller for phone
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40), // Adjusted spacing

                // Login Form Container
                Container(
                  padding: const EdgeInsets.all(20.0), // Adjusted padding
                  decoration: BoxDecoration(
                    color: Colors.grey[850],
                    borderRadius: BorderRadius.circular(10.0), // Slightly smaller radius
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.7),
                        spreadRadius: 1,
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Welcome Text
                      Text(
                        'Welcome',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontSize: 22, // Slightly smaller
                            ),
                      ),
                      const SizedBox(height: 16),

                      // User TextField
                      TextField(
                        controller: userController,
                        decoration: const InputDecoration(
                          labelText: 'User',
                          prefixIcon: Icon(Icons.person_outline, color: Colors.grey),
                        ),
                        keyboardType: TextInputType.text,
                      ),
                      const SizedBox(height: 16),

                      // Password TextField
                      TextField(
                        controller: passwordController,
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          prefixIcon: Icon(Icons.lock_outline, color: Colors.grey),
                        ),
                        obscureText: true,
                      ),
                      const SizedBox(height: 24),

                      // Buttons Column for phone
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          ElevatedButton(
                            onPressed: onLogin,
                            child: const Text('Log In'),
                          ),
                          const SizedBox(height: 12), // Spacing between buttons
                          ElevatedButton(
                            onPressed: onExit,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey[700],
                            ),
                            child: const Text('Exit'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
