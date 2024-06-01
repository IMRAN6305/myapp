import 'dart:async';

import 'package:flutter/material.dart';
import 'package:myapp/domin/app_data.dart';
import 'package:myapp/presentation/screens/home_screen.dart';
import 'package:myapp/presentation/screens/todo_screens/todo_screen.dart';
import 'package:myapp/presentation/screens/user_onbording/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () async {
      var prefs = await SharedPreferences.getInstance();
      bool? check = prefs.getBool(AppData.Login);
      if (check != null && check) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) =>  HomeScreen()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      }


    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/icons/Icon.png",
              fit: BoxFit.fill,
              height: 100,
              width: 100,
            ),
            const Text(
              "Welcome to TODO",
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
