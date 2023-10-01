// ignore_for_file: file_names, must_be_immutable, non_constant_identifier_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/custom-button.dart';
import '../widgets/custom-text-form-feild.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isChecked = false;
  GlobalKey<FormState> formKey = GlobalKey();
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
        )),
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
                      'Welcome !',
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
                    onChanged: (data){
                      email=data;
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
                    onChanged: (data){
                      pass=data;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  //Forget Password Text
                  GestureDetector(
                    onTap: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        Text(
                          'Forget Password?',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // Checkbox
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Checkbox(
                        activeColor: Colors.white,
                        checkColor: Colors.grey,
                        fillColor: MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                          if (states.contains(MaterialState.disabled)) {
                            return Colors.orange.withOpacity(.32);
                          }
                          return Colors.white;
                        }),
                        value: isChecked,
                        onChanged: (value) {
                          setState(() {
                            isChecked = value!;
                          });
                        },
                      ),
                      const Text(
                        'Remember me',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  //Login bottom
                  BuildButton(
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        try {
                          await LoginUser();
                          Navigator.pushNamed(context, 'RegisterScreen');
                        } on FirebaseAuthException catch (e) {
                          print(e);
                          if (e.code == 'user-not-found') {
                            showSnackBar(
                              context,
                              'No user found for that email.',
                            );
                          } else if (e.code == 'wrong-password') {
                            showSnackBar(
                              context,
                              'Wrong password provided for that user.',
                            );
                          }
                        }catch (e){
                          print(e);
                        }
                      }
                    },
                    title: 'LOGIN',
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  //Dont have an account Text
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Don\'t have an Account?',
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
                          Navigator.pushNamed(context, 'RegisterScreen');
                        },
                        child: const Text(
                          'Register',
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
  Future<void> LoginUser() async {
    UserCredential user =
    await FirebaseAuth.instance.signInWithEmailAndPassword(
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
