import 'package:confess/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

final Uri urlPrivacy = Uri.parse('https://github.com/superiorsd10/confess-privacy-policy/tree/main');

class _ProfileScreenState extends State<ProfileScreen> {
  final _email = FirebaseAuth.instance.currentUser!.email;
  final _auth = FirebaseAuth.instance;

  Future signOut() async {
    await _auth.signOut();
    Navigator.pop(context);
  }

  Future<void> _launchUrl(Uri url) async {
    if (!await launchUrl(url)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final double h = MediaQuery.of(context).size.height;
    final double w = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: kWhite,
        body: SingleChildScrollView(
            child: Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, h / 26, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Profile',
                      style: TextStyle(
                        fontFamily: 'RobotoBold',
                        color: kPrimary,
                        fontSize: 40,
                      ),
                    ),
                    SizedBox(
                      height: h / 20,
                    ),
                    Lottie.asset(
                      'assets/images/profile-animation.json',
                      fit: BoxFit.fill,
                      width: h / 5,
                      height: h / 5,
                    ),
                    SizedBox(
                      height: h / 20,
                    ),
                    Text(
                      'Email:- $_email',
                      style: const TextStyle(
                        fontFamily: 'RobotoRegular',
                        fontSize: 20,
                        color: kPrimary,
                      ),
                    ),
                    SizedBox(
                      height: h / 20,
                    ),
                    SizedBox(
                      width: w / 2,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text(
                                'Confirm Logout',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontFamily: 'RobotoBold',
                                  color: kPrimary,
                                ),
                              ),
                              content: const Text(
                                'Do you want to Logout?',
                                style: TextStyle(
                                  fontFamily: 'RobotoMedium',
                                  fontSize: 18,
                                  color: kSecondary,
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text(
                                    'Cancel',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: 'RobotoBold',
                                      color: kPrimary,
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: signOut,
                                  child: const Text(
                                    'OK',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontFamily: 'RobotoBold',
                                      color: kPrimary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          primary: kPrimary,
                        ),
                        child: const Text(
                          'Log Out',
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'RobotoBold',
                            color: kWhite,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: h / 10,
                    ),
                    const Text(
                      'Thank you for using confess!\n\nDesigned and Developed by Sachin Dapkara',
                      style: TextStyle(
                        color: kSecondary,
                        fontFamily: 'RobotoRegular',
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: h / 15,
                    ),
                    GestureDetector(
                      onTap: (){
                        launchUrl(urlPrivacy);
                      },
                      child: const Text(
                        'Privacy Policy',
                        style: TextStyle(
                          color: kSecondary,
                          fontFamily: 'RobotoRegular',
                          fontSize: 14,
                          decoration: TextDecoration.underline,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
    );
  }
}
