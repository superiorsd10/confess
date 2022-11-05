import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class InitialMyConfessionScreen extends StatefulWidget {
  const InitialMyConfessionScreen({Key? key}) : super(key: key);

  @override
  State<InitialMyConfessionScreen> createState() =>
      _InitialMyConfessionScreenState();
}

class _InitialMyConfessionScreenState extends State<InitialMyConfessionScreen> {
  int confessions = 0;
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  void isConfession() async {
    try {
      var collection = _firestore.collection('users');
      var docSnapshot = await collection.doc(_auth.currentUser?.email).get();
      if (docSnapshot.exists) {
        Map<String, dynamic>? data = docSnapshot.data();
        setState(() {
          confessions = data!['numberOfConfessions'];
        });
      }
    } catch (e) {
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, h / 3.5, 0, 0),
        child: confessions == 0 ? Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'You haven\'t made any confession',
              style: TextStyle(
                color: kSecondary,
                fontSize: 21,
                fontFamily: 'RobotoRegular',
              ),
            ),
            SizedBox(
              height: h / 70,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'yet. Click on the ',
                  style: TextStyle(
                    color: kSecondary,
                    fontSize: 21,
                    fontFamily: 'RobotoRegular',
                  ),
                ),
                Icon(
                  Icons.add_circle_rounded,
                  color: kSecondary,
                  size: 25,
                ),
                Text(
                  ' to make your',
                  style: TextStyle(
                    color: kSecondary,
                    fontSize: 21,
                    fontFamily: 'RobotoRegular',
                  ),
                ),
              ],
            ),
            SizedBox(
              height: h / 70,
            ),
            const Text(
              'first confession.',
              style: TextStyle(
                color: kSecondary,
                fontSize: 21,
                fontFamily: 'RobotoRegular',
              ),
            ),
          ],
        ) : const CircularProgressIndicator(
          color: kSecondary,
          backgroundColor: kSecondary,
        ),
      ),
    );
  }
}
