import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget phoneView;
  final Widget webView;
  final double breakpoint;

  const ResponsiveLayout({
    Key? key,
    required this.phoneView,
    required this.webView,
    this.breakpoint = 800.0, // Default breakpoint for typical phone/tablet split
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < breakpoint) {
          return phoneView;
        } else {
          return webView;
        }
      },
    );
  }
}
