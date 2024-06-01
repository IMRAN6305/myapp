import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/presentation/screens/user_onbording/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../domin/app_data.dart';
class UserScreen extends StatelessWidget {

  FirebaseAuth fireauth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("User Profile"),
      // ),
      body: Center(
        child: ElevatedButton(
          onPressed: ()async{
            fireauth.signOut();
            final prefs = await SharedPreferences.getInstance();
            prefs.remove(AppData.Login);

            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginScreen(),
                ));
          },
          child: Text("Log Out"),
        ),
      ),
    );
  }
}
