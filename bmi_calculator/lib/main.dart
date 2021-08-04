import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'screens/welcome_screen.dart';
import 'screens/login_screen.dart';
import 'screens/registration_screen.dart';
import 'screens/startpage.dart';
import 'screens/input_page.dart';
import 'screens/results_page.dart';
import 'screens/view_bmi.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(BMICalculator());
}

class BMICalculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        StartPage.id: (context) => StartPage(),
        InputPage.id: (context) => InputPage(),
        ResultsPage.id: (context) => ResultsPage(),
        ViewBmi.id: (context) => ViewBmi(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
