import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:confess/utils/show_snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

import '../constants.dart';

class RegisterScreen extends StatefulWidget {
  final VoidCallback showLoginPage;
  const RegisterScreen({Key? key, required this.showLoginPage})
      : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  bool _isHidden = true;
  bool _isHidden2 = true;

  bool passwordConfirmed() {
    if (_passwordController.text == _confirmPasswordController.text) {
      return true;
    } else {
      return false;
    }
  }

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  void _toggleConfirmPasswordView() {
    setState(() {
      _isHidden2 = !_isHidden2;
    });
  }

  void signUp() async {
    try {
      if (passwordConfirmed()) {
        await _auth.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
        await _firestore.collection('users').doc(_auth.currentUser?.email).set({
          'email': _emailController.text,
          'uid': _auth.currentUser?.uid,
          'numberOfConfessions': 0,
        });
        await _firestore
            .collection('users')
            .doc(_auth.currentUser?.email)
            .collection('confessions')
            .add({
          'email': _auth.currentUser?.email,
          'confession':
              'Welcome to confess! Feel free to make your first confession by clicking on the Add Symbol.\nHappy Confessing :)',
          'createdAt': FieldValue.serverTimestamp(),
          'color': list.indexOf(kLavender),
        });
        // Navigator.pushReplacement(
        //   context,
        //   PageTransition(
        //       child: Home(),
        //       type: PageTransitionType.fade),
        // );
      } else {
        showSnackBar(context, 'Password and Confirmed Password do not match!');
      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double h = MediaQuery.of(context).size.height;
    final double w = MediaQuery.of(context).size.width;
    return SafeArea(
      child: KeyboardDismisser(
        child: Scaffold(
          backgroundColor: kWhite,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: h / 1000,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: w / 4),
                  child: Image.asset(
                    'assets/images/confess-splash-screen.png',
                    width: w / 2.3,
                    height: h / 3,
                  ),
                ),
                // const Text(
                //   'confess',
                //   style: TextStyle(
                //     fontSize: 35,
                //     fontFamily: 'RobotoBold',
                //     color: kSecondary,
                //   ),
                // ),
                SizedBox(
                  height: h / 1000,
                ),
                const Text(
                  'Hello there!',
                  style: TextStyle(
                    color: kPrimary,
                    fontFamily: 'RobotoBold',
                    fontSize: 43,
                  ),
                ),
                SizedBox(
                  height: h / 20,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: w / 9),
                  child: TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: kSecondary,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: kPrimary,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      hintText: 'Email',
                      hintStyle: const TextStyle(
                        color: kSecondary,
                        fontFamily: 'RobotoRegular',
                        fontSize: 22,
                      ),
                    ),
                    style: const TextStyle(
                      color: kSecondary,
                      fontFamily: 'RobotoRegular',
                      fontSize: 22,
                    ),
                  ),
                ),
                SizedBox(
                  height: h / 50,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: w / 9),
                  child: TextField(
                    controller: _passwordController,
                    obscureText: _isHidden,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      suffixIcon: InkWell(
                        onTap: _togglePasswordView,
                        child: Icon(
                          _isHidden ? Icons.visibility : Icons.visibility_off,
                          color: kSecondary,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: kSecondary,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: kPrimary,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      hintText: 'Password',
                      hintStyle: const TextStyle(
                        color: kSecondary,
                        fontFamily: 'RobotoRegular',
                        fontSize: 22,
                      ),
                    ),
                    style: const TextStyle(
                      color: kSecondary,
                      fontFamily: 'RobotoRegular',
                      fontSize: 22,
                    ),
                  ),
                ),
                SizedBox(
                  height: h / 50,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: w / 9),
                  child: TextField(
                    controller: _confirmPasswordController,
                    obscureText: _isHidden2,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      suffixIcon: InkWell(
                        onTap: _toggleConfirmPasswordView,
                        child: Icon(
                          _isHidden2 ? Icons.visibility : Icons.visibility_off,
                          color: kSecondary,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: kSecondary,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: kPrimary,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      hintText: 'Confirm Password',
                      hintStyle: const TextStyle(
                        color: kSecondary,
                        fontFamily: 'RobotoRegular',
                        fontSize: 22,
                      ),
                    ),
                    style: const TextStyle(
                      color: kSecondary,
                      fontFamily: 'RobotoRegular',
                      fontSize: 22,
                    ),
                  ),
                ),
                SizedBox(
                  height: h / 50,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: kPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  onPressed: signUp,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: h / 50, horizontal: w / 4.05),
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        color: kWhite,
                        fontSize: 22,
                        fontFamily: 'RobotoBold',
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: h / 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "I'm a member! ",
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'RobotoMedium',
                        color: kSecondary,
                      ),
                    ),
                    GestureDetector(
                      onTap: widget.showLoginPage,
                      child: const Text(
                        'Login Now',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'RobotoBold',
                          color: kPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
