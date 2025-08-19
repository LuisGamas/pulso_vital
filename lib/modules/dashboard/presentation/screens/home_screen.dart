import 'package:flutter/material.dart';
import 'package:pulso_vital/config/config.dart';

class HomeScreen extends StatelessWidget {
  static const name = '/home-screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Icon(
          RippleIcons.googleSocialFilled
        )
      ),
    );
  }
}