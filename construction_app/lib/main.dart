import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sealtech/Employee/navbarE.dart';
import 'package:sealtech/client/navbar.dart';
import 'package:sealtech/components/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: accent75,
        textSelectionTheme: TextSelectionThemeData(
          selectionHandleColor: accentColor,
          cursorColor: accent75,
        ),
      ),
      debugShowCheckedModeBanner: false,
      // home: FutureBuilder(
      //   initialData: null,
      //   future: getData(),
      //   builder: (context, snapshot) {
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return LoadingPage1();
      //     } else {
      //       return LoadingPage2();
      //     }
      //   },
      // ),
      home: NavbarE(),
    );
  }
}



// Future<String> getData() async {
//   await Future.delayed(Duration(seconds: 2));
//   return 'Data loaded';
// }

