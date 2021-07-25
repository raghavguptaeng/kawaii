import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'admin_login_textfield.dart';
import 'homeScreen.dart';

class LoginAdmin extends StatefulWidget {
  static const String id = 'loginAdmin';

  @override
  _LoginAdminState createState() => _LoginAdminState();
}

class _LoginAdminState extends State<LoginAdmin> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late String _userEmail;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  RegExp regex = new RegExp(
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
  void showSnackbar(String message) {
    final snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _signInWithEmailAndPassword() async {
    try {
      final User? user = (await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      )).user;
      setState(() {
        Navigator.pushReplacementNamed(context, HomeScreen.id);
      });
    } catch (e) {
      showSnackbar(e.toString());
    }
  }

  late String email, password;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Image.asset('assets/Images/comfortlooms_Logo.png'),
                  ),
                  Text(
                    "Login",
                    style: TextStyle(fontSize: 50),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  AdminLoginTextField(
                    isObscure: false,
                    onChanged: (value) {
                      email = value;
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter email address';
                      } else if (!value.contains('@')) {
                        return 'Email address must contain @';
                      }
                      return null;
                    },
                    type: TextInputType.emailAddress,
                    labelText: 'Email',
                    controller: _emailController,
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  AdminLoginTextField(
                    isObscure: true,
                    type: TextInputType.visiblePassword,
                    onChanged: (value) {
                      password = value;
                    },
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Please enter password';
                      } else if (!regex.hasMatch(value)) {
                        return 'Enter valid passowrd';
                      }
                      return null;
                    },
                    labelText: 'Password',
                    controller: _passwordController,
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Center(
                    child: ConstrainedBox(
                      constraints:
                          BoxConstraints.tightFor(width: 250, height: 50),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          //primary: kAdminPrimaryColor,
                          elevation: 5,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          textStyle: TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.w500,
                              fontSize: 20),
                        ),
                        onPressed: ()  {
                          if (_formKey.currentState!.validate()) {
                            _signInWithEmailAndPassword();
                          }
                        },
                        child: Text(
                          "Log In",
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                      //height: 0.66 * SizeConfig.heightMultiplier,
                      ),
                  TextButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account? ",
                          style: TextStyle(color: Colors.black54),
                        ),
                        Text(
                          "Sign Up ",
                          //style: TextStyle(color: kPrimaryColor),
                        ),
                      ],
                    ),
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => RegistrationAdmin()),
                      // );
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
