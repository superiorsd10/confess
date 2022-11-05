import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:confess/components/reaction_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class Confession extends StatefulWidget {
  const Confession({Key? key, required this.text, required this.color})
      : super(key: key);

  final String text;
  final Color color;
  // final Map<String, dynamic> reaction;

  @override
  State<Confession> createState() => _ConfessionState();
}

class _ConfessionState extends State<Confession> {
  bool isVisible = false;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }


  Widget build(BuildContext context) {
    final double w = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: w / 1.2,
          padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
          margin: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 30,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            color: widget.color,
          ),
          child: Text(
            widget.text,
            style: const TextStyle(
              height: 1.3,
              fontSize: 17,
              color: Colors.white,
              fontFamily: 'RobotoMedium',
            ),
            textAlign: TextAlign.start,
          ),
        ),
        // widget.reaction.isEmpty
        //     ? const SizedBox()
        //     : Align(
        //   alignment: Alignment.bottomRight,
        //   child: Opacity(
        //     opacity: 0.90,
        //     child: Container(
        //       transform: Matrix4.translationValues(0, -55, 0),
        //       padding: const EdgeInsets.all(2),
        //       margin: const EdgeInsets.only(right: 34),
        //       height: 20,
        //       width: 80,
        //       decoration: BoxDecoration(
        //         color: Colors.orange,
        //         borderRadius: BorderRadius.circular(25),
        //       ),
        //       child: widget.reaction.length > 2
        //           ? Text(
        //         '${widget.reaction.values.elementAt(0)} ${widget.reaction.values.elementAt(1)} ${widget.reaction.values.elementAt(2)} ${widget.reaction.length}',
        //         style: const TextStyle(
        //           color: Colors.white,
        //           fontWeight: FontWeight.bold,
        //         ),
        //       )
        //           : widget.reaction.length == 2
        //           ? Text(
        //           '${widget.reaction.values.elementAt(0)} ${widget.reaction.values.elementAt(1)} ${widget.reaction.length}')
        //           : Text(
        //           '${widget.reaction.values.elementAt(0)} ${widget.reaction.length}'),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}

// widget.reaction.isEmpty
// ? const SizedBox()
// : Container(
// padding: const EdgeInsets.all(2),
// height: 20,
// width: 80,
// decoration: BoxDecoration(
// color: Colors.white,
// borderRadius: BorderRadius.circular(25),
// ),
// child: widget.reaction.length > 2
// ? Text(
// '${widget.reaction.values.elementAt(0)} ${widget.reaction.values.elementAt(1)} ${widget.reaction.values.elementAt(2)} ${widget.reaction.length}')
// : widget.reaction.length == 2
// ? Text(
// '${widget.reaction.values.elementAt(0)} ${widget.reaction.values.elementAt(1)} ${widget.reaction.length}')
// : Text(
// '${widget.reaction.values.elementAt(0)} ${widget.reaction.length}'),
// ),
