import 'package:flutter/material.dart';
import 'package:hart/core/constants/style.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Auth Screen',
          style: headingText,
        ),
      ),
    );
  }
}
