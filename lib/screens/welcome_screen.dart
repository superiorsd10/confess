import 'package:confess/constants.dart';
import 'package:confess/auth/main_page.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:slide_to_act/slide_to_act.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    final double h = MediaQuery.of(context).size.height;
    final double w = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: h / 3.20,
              ),
              Center(
                child: Image.asset(
                  'assets/images/confess-splash-screen.png',
                  width: h/3.2,
                  height: h/3.2,
                ),
              ),
              SizedBox(
                height: h / 10,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: w / 20),
                child: SlideAction(
                  onSubmit: () => Navigator.pushReplacement(
                    context,
                    PageTransition(
                        child: MainPage(), type: PageTransitionType.fade),
                  ),
                  borderRadius: 5,
                  elevation: 0,
                  innerColor: kWhite,
                  outerColor: kPrimary,
                  sliderButtonIcon: const Icon(
                    Icons.lock,
                    color: kSecondary,
                  ),
                  text: '     Slide to confess',
                  textStyle: const TextStyle(
                    fontSize: 23,
                    fontFamily: 'RobotoMedium',
                    color: kWhite,
                  ),
                  sliderRotate: false,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
