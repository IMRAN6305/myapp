import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/presentation/screens/user_onbording/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domin/app_data.dart';

class HomeScreen extends StatelessWidget {
  FirebaseAuth fireauth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
        ),
        body:  Center(
          child: InkWell(
            onTap: ()async{
              fireauth.signOut();
              final prefs = await SharedPreferences.getInstance();
              prefs.remove(AppData.Login);

              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ));
            },
              child: Text('Home')),
        ),
      ),
    );
  }
}
