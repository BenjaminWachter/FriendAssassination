import 'package:flutter/material.dart';
import 'package:friend_assassination/home.dart';
import 'package:friend_assassination/domain/handler.dart';
import 'package:friend_assassination/responsive_layout.dart';
import 'package:friend_assassination/login_phone.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  static const Color darkBackgroundColor = Color(0xFF201A30); // Darker purple/blue
  static const Color cardBackgroundColor = Color(0xFF2D2F3E); // Slightly lighter dark shade
  static const Color accentColor = Color(0xFF7B5AFF); // Purple accent
  static const Color textColor = Colors.white;
  static const Color subTextColor = Colors.white70;


  @override
  void dispose() {
    _userController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    // Implement login logic here
    String username = _userController.text;
    String password = _passwordController.text;
    debugPrint('Login attempt with Username: $username');
    if (LoginHander().handleLogin(username, password)) {
      // If login is successful, navigate to the home page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const AssassinationHome(),
        ),
      );
    } else {
      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid username or password')),
      );
    }
  }

  void _exitApp() {
    // In a real app, this might close the app or navigate away.
    // For this example, we'll just print a message.
    debugPrint('Exit button pressed.');
    // SystemNavigator.pop(); // This would close the app on mobile
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Exit requested (Not implemented for web)')),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Define minimum screen size
    const double minWidth = 360;
    const double minHeight = 500;

    // Check if screen size meets the minimum requirements
    if (screenWidth < minWidth || screenHeight < minHeight) {
      return Scaffold(
        body: Center(
          child: Text(
            'Screen size too small. Please use a larger device.',
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    // Calculate form width based on screen size
    double formWidth = screenWidth > 600 ? 400 : screenWidth * 0.85;

    // Web view for the login page
    Widget loginWebView = Scaffold(
      backgroundColor: darkBackgroundColor,
      
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
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
                        fontSize: 36,
                        color: Colors.white,
                      ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Assassination',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontSize: 48,
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
                        fontSize: 16,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 50),

                // Login Form Container
                Container(
                  padding: const EdgeInsets.all(24.0),
                  decoration: BoxDecoration(
                    color: Colors.grey[850],
                    borderRadius: BorderRadius.circular(12.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        spreadRadius: 2,
                        blurRadius: 10,
                        offset: const Offset(0, 5),
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
                              fontSize: 24,
                            ),
                      ),
                      const SizedBox(height: 20),

                      // User TextField
                      TextField(
                        controller: _userController,
                        decoration: const InputDecoration(
                          labelText: 'User',
                          prefixIcon: Icon(Icons.person_outline, color: Colors.grey),
                        ),
                        keyboardType: TextInputType.text,
                      ),
                      const SizedBox(height: 20),

                      // Password TextField
                      TextField(
                        controller: _passwordController,
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          prefixIcon: Icon(Icons.lock_outline, color: Colors.grey),
                        ),
                        obscureText: true,
                      ),
                      const SizedBox(height: 30),

                      // Buttons Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(
                            child: ElevatedButton(
                              onPressed: _login,
                              child: const Text('Log In'),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: _exitApp,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey[700],
                              ),
                              child: const Text('Exit'),
                            ),
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

    return ResponsiveLayout(
      phoneView: LoginPhonePage(
        userController: _userController,
        passwordController: _passwordController,
        onLogin: _login,
        onExit: _exitApp,
      ),
      webView: loginWebView,
    );
  }
}
