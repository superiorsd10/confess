import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:confess/auth/auth_page.dart';
import 'package:confess/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:page_transition/page_transition.dart';


class LoginOptions extends StatefulWidget {
  const LoginOptions({Key? key}) : super(key: key);

  @override
  State<LoginOptions> createState() => _LoginOptionsState();
}

class _LoginOptionsState extends State<LoginOptions> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

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
  Widget build(BuildContext context) {
    final double h = MediaQuery.of(context).size.height;
    final double w = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: kWhite,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: h / 4,
              ),
              Center(
                child: Image.asset(
                  'assets/images/confess-splash-screen.png',
                  width: h / 3.2,
                  height: h / 3.2,
                ),
              ),
              SizedBox(
                height: h / 10,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: w / 10,
                ),
                child: ElevatedButton(
                  onPressed: () => Navigator.push(
                    context,
                    PageTransition(
                        child: AuthPage(), type: PageTransitionType.fade),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimary,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        Icon(
                          Icons.alternate_email_rounded,
                          color: kWhite,
                          size: 24,
                        ),
                        Text(
                          'Login with Email',
                          style: TextStyle(
                            color: kWhite,
                            fontFamily: 'RobotoMedium',
                            fontSize: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: h / 30,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: w / 10,
                ),
                child: OutlinedButton(
                  onPressed: signInWithGoogle,
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                      width: 3,
                      color: kPrimary,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset(
                          'assets/images/google.png',
                          width: 24,
                          height: 24,
                        ),
                        const Text(
                          'Login with Google',
                          style: TextStyle(
                            color: kPrimary,
                            fontFamily: 'RobotoMedium',
                            fontSize: 24,
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
    );
  }
}
