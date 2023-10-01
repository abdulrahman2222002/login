// ignore_for_file: file_names, must_be_immutable, non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/custom-button.dart';
import '../widgets/custom-text-form-feild.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  GlobalKey<FormState> formKey = GlobalKey();
  String? name;
  String? email;
  String? pass;
  bool visible = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xffB3D2C0),
              Color(0xff9AC8AE),
              Color(0xff88BFA0),
              Color(0xff78B691),
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
                bottom: 120.0, top: 80, left: 15, right: 15),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //Sign in Text
                  const Center(
                    child: Text(
                      'Register',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  //Email Text
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Text(
                        'Email',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  //Email TextFormFeild
                  BuildTextFormFeild(
                    prfixIcon: Icons.email,
                    keyboardType: TextInputType.emailAddress,
                    isPassword: false,
                    onChanged: (data) {
                      setState(() {
                        email = data;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  //Password Text
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Text(
                        'Password',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  //Password TextFormFeild
                  BuildTextFormFeild(
                    prfixIcon: Icons.lock,
                    suffixIcon: visible? Icons.visibility: Icons.visibility_off , visibilityTaped: (){
                    setState(() {
                      visible=!visible;
                    });
                  },
                    isPassword: visible,
                    keyboardType: TextInputType.visiblePassword,
                    onChanged: (data) {
                     setState(() {
                       pass = data;
                     });
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  //Login bottom
                  BuildButton(
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        try {
                          await RegisterUser();
                          showSnackBar(
                            context,
                            'Done !',
                          );
                          Navigator.pushNamed(context, 'LoginScreen');
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'weak-password') {
                            showSnackBar(
                              context,
                              'The password provided is too weak.',
                            );
                          } else if (e.code == 'email-already-in-use') {
                            showSnackBar(
                              context,
                              'The account already exists for that email.',
                            );
                          }
                        }
                      }
                    },
                    title: 'Sign Up',
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  //Dont have an account Text
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Already A Member?',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Sign In',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> RegisterUser() async {
    UserCredential user =
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email!,
      password: pass!,
    );
  }

  void showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
  }

}



