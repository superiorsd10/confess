import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:confess/components/confession.dart';
import 'package:confess/constants.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class MyConfessionScreen extends StatefulWidget {
  const MyConfessionScreen({Key? key}) : super(key: key);

  @override
  State<MyConfessionScreen> createState() => _MyConfessionScreenState();
}

class _MyConfessionScreenState extends State<MyConfessionScreen> {
  // final user = FirebaseAuth.instance.currentUser!;
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  Future signOut() async {
    await _auth.signOut();
  }

  int confessions = 0;

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

  // int numberOfConfession(){
  //   String s = isConfession() as String;
  //   int count = int.parse(s);
  //   return count;
  // }

  final _offsetToArmed = 220.0;

  // late ScrollController _scrollController;
  //
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   _scrollController = ScrollController();
  // }
  //
  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   super.dispose();
  //   _scrollController.dispose();
  // }

  // Stream<QuerySnapshot<Map<String, dynamic>>> getConfessions() async*{
  //   yield _firestore
  //       .collection('users')
  //       .doc(_auth.currentUser?.email)
  //       .collection('confessions')
  //       .orderBy(
  //     'createdAt',
  //     descending: true,
  //   )
  //       .snapshots();
  //
  // }
  //
  // late Stream<QuerySnapshot<Map<String,dynamic>>> confessionStream;
  //
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   confessionStream = getConfessions();
  // }

  @override
  Widget build(BuildContext context) {
    final double h = MediaQuery.of(context).size.height;
    final double w = MediaQuery.of(context).size.width;
    // isConfession();
    return SafeArea(
      child: Scaffold(
        backgroundColor: kWhite,
        body: CustomRefreshIndicator(
          onRefresh: () => Future.delayed(
            const Duration(seconds: 3),
          ),
          offsetToArmed: _offsetToArmed,
          builder: (context, child, controller) => AnimatedBuilder(
            animation: controller,
            child: child,
            builder: (context, child) {
              return Stack(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: _offsetToArmed * controller.value,
                    child: const RiveAnimation.asset(
                      'assets/images/3d_raster_test.riv',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(
                      0.0,
                      _offsetToArmed * controller.value,
                    ),
                    child: controller.isLoading ? child : child,
                  ),
                ],
              );
            },
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              child: Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, h / 26, 0, 0),
                  child: Column(
                    children: [
                      const Text(
                        'My Confessions',
                        style: TextStyle(
                          fontFamily: 'RobotoBold',
                          color: kPrimary,
                          fontSize: 40,
                        ),
                      ),
                      Container(
                        color: kWhite,
                        height: h / 1.4,
                        width: w,
                        child: StreamBuilder<QuerySnapshot>(
                          stream: _firestore
                              .collection('users')
                              .doc(_auth.currentUser?.email)
                              .collection('confessions')
                              .orderBy(
                                'createdAt',
                                descending: true,
                              )
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return const Center(
                                child: CircularProgressIndicator(
                                  color: kSecondary,
                                  backgroundColor: kSecondary,
                                ),
                              );
                            }
                            // print(snapshot.data!.docs.length);
                            return ListView.builder(
                              reverse: true,
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                Map<String, dynamic> confessionMap =
                                    snapshot.data!.docs[index].data()
                                        as Map<String, dynamic>;
                                // print(confessionMap);
                                return Confession(
                                  text: confessionMap['confession'],
                                  color: list[confessionMap['color']],
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Align(
// alignment: Alignment.center,
// child: Padding(
// padding: EdgeInsets.fromLTRB(0, h / 18, 0, 0),
// child: Column(
// children: [
// const Text(
// 'My Confessions',
// style: TextStyle(
// fontFamily: 'RobotoBold',
// color: kPrimary,
// fontSize: 40,
// ),
// ),
// SizedBox(
// height: h / 20,
// ),
// ],
// ),
// ),
// ),

// Align(
// alignment: Alignment.center,
// child: Padding(
// padding: EdgeInsets.fromLTRB(0, h / 3, 0, 0),
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.center,
// children: [
// const Text(
// 'My Confessions',
// style: TextStyle(
// fontFamily: 'RobotoBold',
// color: kPrimary,
// fontSize: 40,
// ),
// ),
// const Text(
// 'You haven\'t made any confession',
// style: TextStyle(
// color: kSecondary,
// fontSize: 21,
// fontFamily: 'RobotoRegular',
// ),
// ),
// SizedBox(
// height: h / 70,
// ),
// Row(
// mainAxisAlignment: MainAxisAlignment.center,
// children: const [
// Text(
// 'yet. Click on the ',
// style: TextStyle(
// color: kSecondary,
// fontSize: 21,
// fontFamily: 'RobotoRegular',
// ),
// ),
// Icon(
// Icons.add_circle_rounded,
// color: kSecondary,
// size: 25,
// ),
// Text(
// ' to make your',
// style: TextStyle(
// color: kSecondary,
// fontSize: 21,
// fontFamily: 'RobotoRegular',
// ),
// ),
// ],
// ),
// SizedBox(
// height: h / 70,
// ),
// const Text(
// 'first confession.',
// style: TextStyle(
// color: kSecondary,
// fontSize: 21,
// fontFamily: 'RobotoRegular',
// ),
// ),
// ],
// ),
// ),
// ),
