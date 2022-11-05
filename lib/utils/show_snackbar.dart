import 'package:confess/constants.dart';
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        text,
        style: const TextStyle(color: kWhite, fontFamily: 'RobotoMedium'),
      ),
      backgroundColor: kSecondary,
      padding: EdgeInsets.all(20),
    ),
  );
}
