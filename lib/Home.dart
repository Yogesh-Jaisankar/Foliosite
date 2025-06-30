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
          // Select view based on screen width
          if (constraints.maxWidth < 600) {
            // Mobile layout
            return const Mobileview();
          } else if (constraints.maxWidth < 1200) {
            // Tablet layout
            return const Tabletview();
          } else {
            // Web/Desktop layout
            return const WebView();
          }
        },
      ),
    );
  }
}
