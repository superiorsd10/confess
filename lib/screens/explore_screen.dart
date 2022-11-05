import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:radio_group_v2/radio_group_v2.dart' as rg;
import 'package:radio_group_v2/radio_group_v2.dart';
import 'package:rive/rive.dart';

import '../components/confession.dart';
import '../constants.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  final _offsetToArmed = 220.0;

  rg.RadioGroupController myController = rg.RadioGroupController();

  final List<String> _reportList = [
    'It\'s spam',
    'Hate speech or symbols',
    'False Information',
    'Bullying or harassement',
    'Violence or dangerous',
    'Hurting someone\'s feelings',
    'Something else',
  ];

  void showReport(List reportUsers, var postId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Align(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: AlertDialog(
              title: const Text(
                'Why are you reporting this confession?',
                style: TextStyle(
                  fontFamily: 'RobotoBold',
                  fontSize: 18,
                  color: kPrimary,
                ),
              ),
              content: SingleChildScrollView(
                child: rg.RadioGroup(
                  controller: myController,
                  values: _reportList,
                  indexOfDefault: 0,
                  orientation: RadioGroupOrientation.Vertical,
                  decoration: const RadioGroupDecoration(
                    spacing: 10.0,
                    labelStyle: TextStyle(
                      color: kSecondary,
                    ),
                    activeColor: kPrimary,
                  ),
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
                  onPressed: () async {
                    if(!reportUsers.contains(_auth.currentUser!.email)){
                      reportUsers.add(_auth.currentUser!.email);
                    }
                    await _firestore.collection('confessions').doc(postId).update({
                      'reportUsers': reportUsers,
                    });
                    print(reportUsers);
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Submit',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'RobotoBold',
                      color: kPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final double h = MediaQuery.of(context).size.height;
    final double w = MediaQuery.of(context).size.width;
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
                        'Explore',
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
                                return Slidable(
                                  startActionPane: ActionPane(
                                    motion: const StretchMotion(),
                                    children: [
                                      SlidableAction(
                                        onPressed: (context) {
                                          showReport(
                                            confessionMap['reportUsers'],
                                            snapshot.data!.docs[index].id,
                                          );
                                        },
                                        icon:
                                            Icons.report_gmailerrorred_rounded,
                                        backgroundColor: Colors.red,
                                        label: 'Report',
                                      ),
                                    ],
                                  ),
                                  endActionPane: ActionPane(
                                    motion: const StretchMotion(),
                                    children: [
                                      SlidableAction(
                                        onPressed: (context) {
                                          showReport(
                                            confessionMap['reportUsers'],
                                            snapshot.data!.docs[index].id,
                                          );
                                        },
                                        icon:
                                            Icons.report_gmailerrorred_rounded,
                                        backgroundColor: Colors.red,
                                        label: 'Report',
                                      ),
                                    ],
                                  ),
                                  child: Confession(
                                    text: confessionMap['confession'],
                                    color: list[confessionMap['color']],
                                  ),
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
