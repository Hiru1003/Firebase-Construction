import 'package:flutter/material.dart';
import 'package:sealtech/components/theme.dart';
import 'package:sealtech/signin.dart';
import 'package:sealtech/signup.dart'; // Import SignInPage

class LoadingPage2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: GestureDetector(
        onTap: () {
          // Navigate to SignInPage when tapped
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SignUpPage()),
          );
        },
        child: Center(
          child: Image.asset(
            'lib/images/logo-word-no-background.png',
            width: 160,
          ),
        ),
      ),
    );
  }
}
