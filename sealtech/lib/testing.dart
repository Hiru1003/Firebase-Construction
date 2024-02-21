import 'package:flutter/material.dart';
import 'package:sealtech/components/button.dart';

class CustomPage extends StatelessWidget {
  final String title;
  final String bodyText;
  final Color buttonColor; // Add this line to add a buttonColor parameter

  CustomPage({required this.title, required this.bodyText, this.buttonColor = Colors.blue});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              bodyText,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Button(
              buttonText: 'Press Me',
              enableIcon: true,
              onPressed: () {
                print('Button pressed!');
              },
              color: 'black',
              isStroked: false,
            )
          ],
        ),
      ),
    );
  }
}