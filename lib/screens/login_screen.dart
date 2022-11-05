import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:confess/constants.dart';
import 'package:confess/screens/forgot_password_screen.dart';
import 'package:confess/utils/show_snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:page_transition/page_transition.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key, required this.showRegisterPage})
      : super(key: key);

  final VoidCallback showRegisterPage;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  bool _isHidden = true;
  final _firestore = FirebaseFirestore.instance;

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  Future signIn() async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      // Navigator.pushReplacement(
      //   context,
      //   PageTransition(
      //       child: Home(),
      //       type: PageTransitionType.fade),
      // );
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  }

  int confessions = 0;

  void isConfession(String email) async {
    try {
      var collection = _firestore.collection('users');
      var docSnapshot = await collection.doc(email).get();
      print(docSnapshot);
      if (docSnapshot.exists) {
        Map<String, dynamic>? data = docSnapshot.data();
        print('Hai bhai apna email');
        setState(() {
          confessions = data!['numberOfConfessions'];
        });

      } else if(!docSnapshot.exists){
        print('Naya bna aaya hai');
        confessions=-1;
      }
    } catch (e) {
      print(e);
    }
  }

  signInWithGoogle() async{
    final GoogleSignInAccount? googleUser = await GoogleSignIn(
        scopes: <String>['email']
    ).signIn();

    final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    print(confessions);
    print(googleUser.email);

    await FirebaseAuth.instance.signInWithCredential(credential).then((credential) async {
      var collection = _firestore.collection('users');
      var docSnapshot = await collection.doc(credential.user?.email).get();
      if(!docSnapshot.exists){
        await _firestore.collection('users').doc(credential.user?.email).set({
          'email': credential.user?.email,
          'uid': credential.user?.uid,
          'numberOfConfessions': 0,
        });
        await _firestore.collection('users').doc(credential.user?.email).collection('confessions').add({
          'email': credential.user?.email,
          'confession': 'Welcome to confess! Feel free to make your first confession by clicking on the Add Symbol.\nHappy Confessing :)',
          'createdAt': FieldValue.serverTimestamp(),
          'color': list.indexOf(kLavender),
        });
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _passwordController.dispose();
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
                SizedBox(
                  height: h / 1000,
                ),
                const Text(
                  'Welcome back!',
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
                  padding: EdgeInsets.fromLTRB(w / 2, 0, 0, 0),
                  child: GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      PageTransition(
                        child: ForgotPasswordScreen(),
                        type: PageTransitionType.fade,
                      ),
                    ),
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'RobotoBold',
                        color: kPrimary,
                      ),
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
                  onPressed: signIn,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: h / 50, horizontal: w / 3.85),
                    child: const Text(
                      'Sign In',
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
                      'Not a member? ',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'RobotoMedium',
                        color: kSecondary,
                      ),
                    ),
                    GestureDetector(
                      onTap: widget.showRegisterPage,
                      child: const Text(
                        'Register Now',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'RobotoBold',
                          color: kPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: w / 6,
                    vertical: h/30
                  ),
                  child: OutlinedButton(
                    onPressed: signInWithGoogle,
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                        width: 1.5,
                        color: kPrimary,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset(
                            'assets/images/google.png',
                            width: 24,
                            height: 24,
                          ),
                          const Text(
                            'Sign In with Google',
                            style: TextStyle(
                              color: kPrimary,
                              fontFamily: 'RobotoMedium',
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
