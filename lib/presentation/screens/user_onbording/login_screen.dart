import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:myapp/presentation/screens/home_screen.dart';
import 'package:myapp/presentation/screens/user_onbording/signup_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../domin/app_data.dart';
import '../../custom_widgets/eleveated_button.dart';
import '../../custom_widgets/snack_bar.dart';
import '../../custom_widgets/textfiled.dart';

class LoginScreen extends StatelessWidget {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  FirebaseAuth fireauth = FirebaseAuth.instance;
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: const Text('Login'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Image.asset(
                "assets/icons/Icon.png",
                fit: BoxFit.fill,
                height: 200,
                width: 150,
              ),
              const Text(
                "Welcome to TODO",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 10),
              TextFiled(
                controller: email,
                labelText: "Email",
                inputType: TextInputType.emailAddress,
                hintText: "Enter your email",
                preIcon: Icons.email,
              ),
              const SizedBox(height: 10),
              TextFiled(
                controller: password,
                labelText: "Password",
                inputType: TextInputType.visiblePassword,
                hintText: "Enter your password",
                preIcon: Icons.lock,
                checkObscure: true,
              ),
              const SizedBox(
                height: 10.0,
              ),
              AppCustomElevatedBtn(
                mTitle: ' Login',
                onTap: () async {
                  try {
                    final credential = await fireauth
                        .signInWithEmailAndPassword(
                            email: email.text.toString(),
                            password: password.text.toString())
                        .then((value) async {
                      final prefs = await SharedPreferences.getInstance();
                      prefs.setBool(AppData.Login, true);
                      CustomSnackbar.show(
                        context,
                        'Successfully login',
                        backgroundColor: Colors.blue,

                      );
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeScreen(),
                          ));
                    });
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'user-not-found') {
                      CustomSnackbar.show(
                        context,
                        'No user found for that email.',
                        backgroundColor: Colors.red,

                      );
                      print('No user found for that email.');
                    } else if (e.code == 'wrong-password') {
                      CustomSnackbar.show(
                        context,
                        'Wrong password provided for that user.',
                        backgroundColor: Colors.red,

                      );
                      print('Wrong password provided for that user.');
                    }
                  } catch (e) {
                    print("this is wrong data");
                    CustomSnackbar.show(
                      context,
                      'Unknown error',
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      actionColor: Colors.red,
                    );
                    print(e);
                  }
                },
              ),
              const SizedBox(
                height: 10.0,
              ),
              Text.rich(TextSpan(
                children: [
                  const TextSpan(text: "Create an account?"),
                  TextSpan(
                    text: " Sign Up",
                    style: const TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.blue,
                      decorationStyle: TextDecorationStyle.solid,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignupScreen(),
                          ),
                        );
                      },
                  )
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
