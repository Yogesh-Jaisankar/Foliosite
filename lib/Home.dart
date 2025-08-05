import 'package:flutter/material.dart';

import 'MobileView.dart'; // Import your MobileView widget
import 'TabletView.dart'; // Import your TabletView widget
import 'WebView.dart'; // Import your WebView widget

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          print('Screen width: ${constraints.maxWidth}');
          if (constraints.maxWidth < 600) {
            return const Mobileview();
          } else if (constraints.maxWidth < 1200) {
            return const Tabletview();
          } else {
            return const WebView();
          }
        },
      ),
    );
  }
}
