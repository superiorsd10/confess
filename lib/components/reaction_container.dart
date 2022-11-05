import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
late String selectedEmoji;

class ReactionContainer extends StatefulWidget {
  ReactionContainer({Key? key, required this.isVisible}) : super(key: key);
  late bool isVisible;

  @override
  State<ReactionContainer> createState() => _ReactionContainerState();
}

class _ReactionContainerState extends State<ReactionContainer> {
  @override

  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  // }
  // void dispose() {
  //   // TODO: implement dispose
  //   super.dispose();
  // }
  int tap=0;
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  // void addReaction() async{
  //   try{
  //     var collection = _firestore.collection('users');
  //     var docSnapshot = await collection.doc(_auth.currentUser?.email).collection('confessions').doc()
  //   }
  // }

  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return Visibility(
      visible: widget.isVisible==true && tap==0 ? true : widget.isVisible==true && tap>0 ? false : false,
      child: Container(
        height: 50,
        width: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            EmojiTap(
              emoji: 'like',
            ),
            EmojiTap(
              emoji: 'heart',
            ),
            EmojiTap(
              emoji: 'laugh',
            ),
            EmojiTap(
              emoji: 'surprised',
            ),
            EmojiTap(
              emoji: 'sad',
            ),
          ],
        ),
      ),
    );
  }

  Widget EmojiTap({required String emoji}){
    return GestureDetector(
        child: Image.asset(
          'assets/images/$emoji.png',
          height: 35,
          width: 35,
        ),
        onTap: () {
          tap++;
          setState(() {
            selectedEmoji = emoji;
            widget.isVisible=false;
          });
          print(selectedEmoji);
          print(widget.isVisible);

        });
  }
}