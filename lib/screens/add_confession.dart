import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:confess/constants.dart';
import 'package:confess/screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:uuid/uuid.dart';

List<MaterialColor> list2 = <MaterialColor>[
  kIndigo,
  kRed,
  kGreen,
  kLavender,
  kBlack,
  kYellow,
  kYellow2,
  kPink,
  kCyan,
  kSky,
  kTurquiose,
  kBlood,
  kPink2,
  kLeaf,
  kLeaf2
];

class AddConfessionScreen extends StatefulWidget {
  const AddConfessionScreen({Key? key}) : super(key: key);

  @override
  State<AddConfessionScreen> createState() => _AddConfessionScreenState();
}

class _AddConfessionScreenState extends State<AddConfessionScreen> {
  final _formkey = GlobalKey<FormState>();
  late String confession;
  final confessionController = TextEditingController();

  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  List reportUsers = [];

  // var postId = const Uuid().v4();

  void AddConfession() async {
    Map<String, dynamic> confessionData = {
      'email': _auth.currentUser?.email,
      'confession': confession,
      'createdAt': FieldValue.serverTimestamp(),
      'color': list2.indexOf(_tempMainColor as MaterialColor),
    };

    Map<String, dynamic> confessionData1 = {
      'confession': confession,
      'createdAt': FieldValue.serverTimestamp(),
      'color': list2.indexOf(_tempMainColor as MaterialColor),
      'reportUsers': reportUsers,
      // 'postId': postId,
    };
    var collection = _firestore.collection('users');
    var docSnapshot = await collection.doc(_auth.currentUser?.email).get();
    Map<String, dynamic>? confessionMap = docSnapshot.data();
    int numberOfConfession = confessionMap!['numberOfConfessions'];
    await _firestore
        .collection('users')
        .doc(_auth.currentUser?.email)
        .collection('confessions')
        .add(confessionData);
    await _firestore.collection('confessions').add(confessionData1);
    // await _firestore.collection('users').doc(_auth.currentUser?.email).update({
    //   'numberOfConfessions': ++numberOfConfession,
    // });
  }

  @override
  void dispose() {
    confessionController.dispose();
    super.dispose();
  }

  clearText() {
    confessionController.clear();
  }

  ColorSwatch? _tempMainColor = list2[0] as ColorSwatch?;
  ColorSwatch? _mainColor = list2.first as ColorSwatch?;

  void _openDialog(String title, Widget content) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(6.0),
          title: Text(title),
          content: content,
          actions: [
            TextButton(
              child: Text('CANCEL'),
              onPressed: Navigator.of(context).pop,
            ),
            TextButton(
              child: Text('SUBMIT'),
              onPressed: () {
                Navigator.of(context).pop();
                // FocusScopeNode currentFocus = FocusScope.of(context);
                //
                // if (!currentFocus.hasPrimaryFocus) {
                //   currentFocus.unfocus();
                // }
                setState(() => _mainColor = _tempMainColor);
              },
            ),
          ],
        );
      },
    );
  }

  void _openMainColorPicker() async {
    _openDialog(
      'Pick a color',
      MaterialColorPicker(
        selectedColor: _mainColor,
        allowShades: false,
        onMainColorChange: (color) => setState(() => _tempMainColor = color),
        colors: list2,
        elevation: 0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double h = MediaQuery.of(context).size.height;
    final double w = MediaQuery.of(context).size.width;
    return SafeArea(
      child: KeyboardDismisser(
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: kWhite,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    // GestureDetector(
                    //   onTap: () => Navigator.pop(context),
                    //   child: const Align(
                    //     alignment: Alignment.topLeft,
                    //     child: Text(
                    //       'Cancel',
                    //       style: TextStyle(
                    //         fontSize: 20,
                    //         fontFamily: 'RobotoMedium',
                    //         color: kSecondary,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    Form(
                      key: _formkey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // SizedBox(
                          //   height: h / 20,
                          // ),
                          Container(
                            width: w / 1.1,
                            height: h / 2.5,
                            child: TextFormField(
                              style: const TextStyle(
                                color: kPrimary,
                                fontSize: 20,
                                fontFamily: 'RobotoRegular',
                                height: 1.4,
                              ),
                              maxLines: 7,
                              minLines: 1,
                              autofocus: false,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Make Confession...',
                                hintStyle: TextStyle(
                                  fontFamily: 'RobotoMedium',
                                  fontSize: 24,
                                  color: kGrey,
                                ),
                                errorStyle: TextStyle(
                                  color: Colors.redAccent,
                                  fontSize: 15,
                                ),
                              ),
                              controller: confessionController,
                              onChanged: (value) {
                                confession = value;
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Enter Confession!';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(
                            height: h / 20,
                          ),
                          Row(
                            children: [
                              const Text(
                                'Choose a color:-',
                                style: TextStyle(
                                  fontFamily: 'RobotoMedium',
                                  fontSize: 24,
                                  color: kSecondary,
                                ),
                              ),
                              SizedBox(
                                width: w / 10,
                              ),
                              OutlinedButton(
                                onPressed: _openMainColorPicker,
                                child: Text('Pick'),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: _tempMainColor,
                                  side: BorderSide(
                                    color: _tempMainColor as Color,
                                    width: 2,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: h / 12,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if (_formkey.currentState!.validate()) {
                                setState(() {
                                  // confession = confessionController.text;
                                  print(confession);
                                  print(list2.indexOf(
                                      _tempMainColor as MaterialColor));
                                  // clearText();
                                });
                                AddConfession();
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder: (_) => Home()));
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: kPrimary,
                            ),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 12,
                                horizontal: 24,
                              ),
                              child: Text(
                                'Confess',
                                style: TextStyle(
                                  fontFamily: 'RobotoBold',
                                  fontSize: 22,
                                  color: kWhite,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Container(
// color: kPrimary,
// width: 100,
// height: 100,
// child: TextFormField(
// autofocus: false,
// decoration: const InputDecoration(
// labelText: 'Make Confession...',
// labelStyle: TextStyle(
// fontFamily: 'RobotoMedium',
// fontSize: 24,
// color: kGrey,
// ),
// border: OutlineInputBorder(),
// errorStyle: TextStyle(
// color: Colors.redAccent, fontSize: 15),
// ),
// controller: confessionController,
// validator: (value) {
// if (value == null || value.isEmpty) {
// return 'Please Enter Confession!';
// }
// return null;
// },
// ),
// ),
