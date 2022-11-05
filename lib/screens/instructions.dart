import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:confess/constants.dart';
import 'package:flutter/material.dart';

class Instructions extends StatefulWidget {
  const Instructions({Key? key}) : super(key: key);

  @override
  State<Instructions> createState() => _InstructionsState();
}

class _InstructionsState extends State<Instructions> {
  @override
  Widget build(BuildContext context) {
    final double h = MediaQuery.of(context).size.height;
    final double w = MediaQuery.of(context).size.width;
    final Size s = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: kWhite,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios_rounded,
                      color: kSecondary,
                      size: 35,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                SizedBox(
                  height: h / 100,
                ),
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    'confess',
                    style: TextStyle(
                      color: kSecondary,
                      fontSize: 50,
                      fontFamily: 'RobotoBold',
                    ),
                  ),
                ),
                SizedBox(
                  height: h / 30,
                ),
                textContent(
                  s,
                  'My Confessions',
                  'Here you can see all your confessions.',
                ),
                textContent(
                  s,
                  'Explore',
                  'Here you can see confessions of all the users without knowing their identity. You can slide the confession left or right to report it.',
                ),
                textContent(
                  s,
                  'Add',
                  'Here you can add your confession, don’t worry your identity won’t be revealed ;)',
                ),
                textContent(
                  s,
                  'Quote',
                  'Here you’ll be able to read quotes. Don’t forget to take some inspiration :)',
                ),
                textContent(
                  s,
                  'Profile',
                  'Here it’s you i.e. your profile. But you wouldn’t like to spend your time here. Isn’t it?',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget textContent(Size s, String heading, String description) {
    List<MaterialColor> colorizeList = <MaterialColor>[
      kLavender,
      kRed,
      kGreen,
      kIndigo,
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
    const headingStyle = TextStyle(
      fontSize: 22,
      fontFamily: 'RobotoBold',
    );

    const descriptionStyle = TextStyle(
      fontSize: 16,
      fontFamily: 'RobotoRegular',
      color: kPrimary,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: s.height/30,
          ),
          AnimatedTextKit(
            isRepeatingAnimation: true,
            pause: const Duration(milliseconds: 300),
            animatedTexts: [
              ColorizeAnimatedText(
                heading,
                textStyle: headingStyle,
                colors: colorizeList,
                speed: const Duration(
                  seconds: 2,
                ),
              ),
            ],
          ),
          SizedBox(
            height: s.height / 100,
          ),
          Text(
            description,
            style: descriptionStyle,
          ),
          const Divider(
            color: kSecondary,
            height: 10,
            thickness: 1,
          )
        ],
      ),
    );
  }
}
