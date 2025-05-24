// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:friend_assassination/domain/responsive_layout.dart';
import 'package:friend_assassination/mobile/home_mobile.dart';
import 'package:friend_assassination/desktop/home_web.dart';

class AssassinationHome extends StatefulWidget {
  const AssassinationHome({super.key});

  @override
  State<AssassinationHome> createState() => _AssassinationHomeState();
}

class _AssassinationHomeState extends State<AssassinationHome> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(phoneView: homeMobileView, webView: homeWebView);
  }
}
