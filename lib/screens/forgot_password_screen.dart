import 'package:confess/utils/show_snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:confess/constants.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {

  final _emailController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    super.dispose();
  }

  Future passwordReset() async{
    try{
      await _auth.sendPasswordResetEmail(email: _emailController.text);
      showSnackBar(context, 'Password Reset Link sent! Check your email!');
    } on FirebaseAuthException catch(e){
      showSnackBar(context, e.message!);
    }
  }

  @override
  Widget build(BuildContext context) {
    final double h = MediaQuery.of(context).size.height;
    final double w = MediaQuery.of(context).size.width;
    return SafeArea(
      child: KeyboardDismisser(
        child: Scaffold(
          backgroundColor: kWhite,
          appBar: AppBar(
            backgroundColor: kWhite,
            elevation: 0,
            leading: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Icon(
                Icons.arrow_back_ios_outlined,
                color: kSecondary,
                size: 30,
              ),
            ),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Enter your email to receive a\npassword reset link',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'RobotoRegular',
                  color: kSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: h / 25,
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
                height: h / 35,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: kPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onPressed: passwordReset,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: h / 70, horizontal: w / 40),
                  child: const Text(
                    'Reset Password',
                    style: TextStyle(
                      color: kWhite,
                      fontSize: 14,
                      fontFamily: 'RobotoBold',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
