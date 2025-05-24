import 'package:flutter/material.dart';

// Placeholder for actual icons you might use

void main() {
  runApp(
    const MaterialApp( // Added MaterialApp
      home: Scaffold( // Added Scaffold
        body: HomeWebPageContent(),
      ),
      debugShowCheckedModeBanner: false, // Optional: to remove the debug banner
    )
  );
}

class HomeWebPageContent extends StatefulWidget {
  const HomeWebPageContent({super.key});

  @override
  State<HomeWebPageContent> createState() => _HomeWebPageContentState();
}

class _HomeWebPageContentState extends State<HomeWebPageContent> {
  int _selectedIndex = 0; // To track the selected nav item

  // Define Colors based on the image
  static const Color darkScaffoldBackground = Color(0xFF1A1A1F); // Deepest background
  static const Color mainPanelBackground = Color(0xFF25252B); // Background for the main content panel
  static const Color sidebarBackground = Color(0xFF1E1E24); // Slightly different if needed, or same as scaffold
  static const Color navItemSelectedBg = Color(0xFFA082D8);
  static const Color navItemIconColor = Colors.white70;
  static const Color navItemSelectedIconColor = Colors.white;
  static const Color navItemTextColor = Colors.white70;
  static const Color navItemSelectedTextColor = Colors.white;

  static const Color contentCardBackground = Color(0xFFFFFFFF); // Lighter card for content
  static const Color imagePlaceholderBg = Color(0xFFE0E0E5); // Background for the placeholder image area
  static const Color shapePlaceholderColor = Color(0xFFB0B0B5); // Color for geometric shapes

  static const Color buttonColor = Color(0xFF8A6FBF);
  static const Color textOnDarkBg = Colors.white;
  static const Color headlineOnDarkBg = Colors.white;
  static const Color paragraphOnDarkBg = Color(0xB3FFFFFF); // White with some transparency

  static const Color textOnLightBg = Color(0xFF333333);
  static const Color headlineOnLightBg = Color(0xFF333333);
  static const Color paragraphOnLightBg = Color(0xFF555555);


  Widget _buildNavItem(IconData icon, String title, int index) {
    bool isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
        decoration: BoxDecoration(
          color: isSelected ? navItemSelectedBg : Colors.transparent,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(icon, color: isSelected ? navItemSelectedIconColor : navItemIconColor, size: 24),
            const SizedBox(width: 16),
            Text(
              title,
              style: TextStyle(
                color: isSelected ? navItemSelectedTextColor : navItemTextColor,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // This container would be the direct child of Scaffold's body
    // It sets the overall background color for the "page" content area
    return Container(
      color: mainPanelBackground, // Background of the entire area holding sidebar + content
      padding: const EdgeInsets.all(16.0), // Overall padding for the page content
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Sidebar Navigation
          Container(
            width: 230, // Fixed width for the sidebar
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
            decoration: BoxDecoration(
              color: sidebarBackground, // sidebar's own background
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildNavItem(Icons.person, 'Your Target', 0),
                _buildNavItem(Icons.person, 'Leader-board', 1),
                _buildNavItem(Icons.person, 'Kill List', 2),
                _buildNavItem(Icons.person, 'Rules', 3),
                const Spacer(), // Pushes profile to the bottom
                _buildNavItem(Icons.person, 'Profile', 4),
              ],
            ),
          ),

          const SizedBox(width: 24), // Spacing between sidebar and content

          // Main Content Area
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                color: contentCardBackground,
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 0,
                    blurRadius: 10,
                    offset: const Offset(0,4),
                  )
                ]
              ),
              child: SingleChildScrollView( // In case content overflows
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image Placeholder
                    Container(
                      height: 250, // Adjust height as needed
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: imagePlaceholderBg,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Placeholder Geometric Shapes
                          _buildGeometricShape(ShapeType.triangle),
                          _buildGeometricShape(ShapeType.square),
                          _buildGeometricShape(ShapeType.circle),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Text Content
                    Text(
                      'Your Target', // This seems to be on the dark background in the image, not the card.
                                      // If it should be on the card, change color and context.
                                      // For this example, I'll assume it's part of the card content.
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: textOnLightBg,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Persons Name',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: headlineOnLightBg,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Headline',
                      style: TextStyle(
                        fontSize: 18,
                        color: headlineOnLightBg.withOpacity(0.8),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
                      style: TextStyle(
                        fontSize: 14,
                        color: paragraphOnLightBg,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Duis aute irure dolor in reprehenderit in voluptate v...',
                      style: TextStyle(
                        fontSize: 14,
                        color: paragraphOnLightBg,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Confirm Kill Button
                    SizedBox(
                      width: double.infinity, // Make button full width of its parent column
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: buttonColor,
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () {
                          // Handle confirm kill action
                        },
                        child: const Text('Confirm Kill', style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper for placeholder geometric shapes
  Widget _buildGeometricShape(ShapeType type) {
    double size = 60.0;
    Widget shapeWidget;

    switch (type) {
      case ShapeType.triangle:
        shapeWidget = ClipPath(
          clipper: _TriangleClipper(),
          child: Container(width: size, height: size, color: shapePlaceholderColor),
        );
        break;
      case ShapeType.square:
        shapeWidget = Container(width: size, height: size, color: shapePlaceholderColor);
        break;
      case ShapeType.circle:
        shapeWidget = Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: shapePlaceholderColor,
            shape: BoxShape.circle,
          ),
        );
        break;
    }
    return shapeWidget;
  }
}

enum ShapeType { triangle, square, circle }

// Custom Clipper for Triangle
class _TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(size.width / 2, 0); // Top point
    path.lineTo(size.width, size.height); // Bottom-right
    path.lineTo(0, size.height); // Bottom-left
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

// How to use this in your main.dart or a page:
/*
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Web Page Demo',
      theme: ThemeData(
        brightness: Brightness.dark, // Or configure for your needs
        primarySwatch: Colors.deepPurple,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar( // Optional AppBar
      //   title: Text('Dashboard'),
      //   backgroundColor: _HomeWebPageContentState.mainPanelBackground, // Match theme
      // ),
      backgroundColor: _HomeWebPageContentState.darkScaffoldBackground, // Set the darkest background for Scaffold
      body: const HomeWebPageContent(), // Your widget goes here!
    );
  }
}
*/