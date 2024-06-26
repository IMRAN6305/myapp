import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:myapp/data/models/user_model.dart';
import 'package:myapp/presentation/custom_widgets/textfiled.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../custom_widgets/eleveated_button.dart';
import '../../custom_widgets/snack_bar.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController userName = TextEditingController();

  final TextEditingController email = TextEditingController();

  final TextEditingController phoneNumber = TextEditingController();

  final TextEditingController password = TextEditingController();

  final TextEditingController confirmPassword = TextEditingController();

  String? selectedGender;

  FirebaseAuth fireauth = FirebaseAuth.instance;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: const Text('Sign Up'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 10.0,
                ),
                TextFiled(
                  controller: userName,
                  labelText: "User Name",
                  inputType: TextInputType.text,
                  hintText: "Enter your name",
                  preIcon: Icons.person,
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
                  controller: phoneNumber,
                  labelText: "Phone Number",
                  inputType: TextInputType.phone,
                  hintText: "Enter your phone number",
                  preIcon: Icons.phone,
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  value: selectedGender,
                  hint: const Text('Select Gender'),
                  items: ['Male', 'Female'].map((String gender) {
                    return DropdownMenuItem<String>(
                      value: gender,
                      child: Text(gender),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      selectedGender = newValue;
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        color: Colors.black,
                      ),
                    ),
                    prefixIcon: const Icon(Icons.person),
                  ),
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
                const SizedBox(height: 10),
                TextFiled(
                  controller: confirmPassword,
                  labelText: "Confirm Password",
                  inputType: TextInputType.visiblePassword,
                  hintText: "Confirm your password",
                  preIcon: Icons.lock,
                  checkObscure: true,
                ),
                const SizedBox(height: 20),
                AppCustomElevatedBtn(
                  mTitle: 'Sign Up',
                  onTap: () async {
                    try {
                      var crad = await fireauth.createUserWithEmailAndPassword(
                        email: email.text.toString(),
                        password: password.text.toString(),
                      );
                      print(crad.user!.uid);

                      UserModel newUser = UserModel(
                          userName: userName.text.toString(),
                          email: email.text.toString(),
                          gender: selectedGender.toString(),
                          phoneNumber: phoneNumber.text.toString(),
                          password: password.text.toString());
                          firebaseFirestore.collection("users").doc(crad.user!.uid).set(newUser.toDoc()).then((value){
                        CustomSnackbar.show(
                          context,
                          'Successfully Register',
                          backgroundColor: Colors.blue,

                        );
                        Navigator.pop(context);
                      });
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        CustomSnackbar.show(
                          context,
                          'The password provided is too weak.',
                          backgroundColor: Colors.red,

                        );
                        print('The password provided is too weak.');
                      } else if (e.code == 'email-already-in-use') {
                        CustomSnackbar.show(
                          context,
                          'The account already exists for that email.',
                          backgroundColor: Colors.red,

                        );
                        print('The account already exists for that email.');
                      }
                    } catch (e) {
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
                    const TextSpan(text: "Already have an account?"),
                    TextSpan(
                      text: " Login",
                      style: const TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.blue,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pop(context);
                        },
                    )
                  ],
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
