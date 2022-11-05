import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants.dart';

class ContactMe extends StatefulWidget {
  const ContactMe({Key? key}) : super(key: key);

  @override
  State<ContactMe> createState() => _ContactMeState();
}

final Uri urlMail = Uri.parse('mailto:sachindapkara6@gmail.com');
final Uri urlInstagram = Uri.parse('https://www.instagram.com/superior_sd10/');
final Uri urlLinkedin = Uri.parse('https://www.linkedin.com/in/sachin-dapkara');
final Uri urlGithub = Uri.parse('https://github.com/superiorsd10');

class _ContactMeState extends State<ContactMe> {
  RiveAnimationController? _controller;
  Artboard? _riveArtBoard;

  Future<void> _launchUrl(Uri url) async {
    if (!await launchUrl(url)) {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    rootBundle.load('assets/images/spring_demo.riv').then(
      (data) async {
        // Load the RiveFile from the binary data.
        final file = RiveFile.import(data);
        final artboard = file.mainArtboard;
        // ignore: cascade_invocations
        artboard.addController(_controller = SimpleAnimation('butterfly'));
        setState(() => _riveArtBoard = artboard);
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(3),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
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
              Container(
                width: h / 2.5,
                height: h / 2.5,
                child: _riveArtBoard == null
                    ? const SizedBox()
                    : Rive(
                        artboard: _riveArtBoard!,
                        fit: BoxFit.cover,
                      ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'hope you\'re feeling light now :)',
                    style: TextStyle(
                      fontFamily: 'RobotoBold',
                      fontSize: 20,
                      color: kSecondary,
                    ),
                  ),
                  // const Divider(
                  //   height: 10,
                  //   thickness: 1,
                  //   color: kPrimary,
                  // ),
                  SizedBox(
                    height: h / 15,
                  ),
                  const Text(
                    'Designed & Developed By :-',
                    style: TextStyle(
                      fontFamily: 'RobotoMedium',
                      fontSize: 18,
                      color: kSecondary,
                    ),
                  ),
                  SizedBox(
                    height: h / 40,
                  ),
                  const Text(
                    'Sachin Dapkara',
                    style: TextStyle(
                      fontFamily: 'RobotoBold',
                      fontSize: 20,
                      color: kPrimary,
                    ),
                  ),
                  SizedBox(
                    height: h / 15,
                  ),
                  const Text(
                    'Connect with Me',
                    style: TextStyle(
                      fontFamily: 'RobotoMedium',
                      fontSize: 18,
                      color: kSecondary,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: h / 40,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(6, 0, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _launchUrl(urlMail);
                      },
                      child: Image.asset(
                        'assets/images/gmail-icon.png',
                        height: 32,
                        width: 32,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _launchUrl(urlInstagram);
                      },
                      child: Image.asset(
                        'assets/images/ig-instagram-icon.png',
                        height: 32,
                        width: 32,
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        _launchUrl(urlLinkedin);
                      },
                      child: Image.asset(
                        'assets/images/linkedin-app-icon.png',
                        height: 32,
                        width: 32,
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        _launchUrl(urlGithub);
                      },
                      child: Image.asset(
                        'assets/images/github-icon.png',
                        height: 32,
                        width: 32,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: h/20,
              ),
              const Text(
                'Report if you find any bug, appreciate if you like it :)',
                style: TextStyle(
                  fontSize: 13,
                  fontFamily: 'RobotoRegular',
                  color: kSecondary
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
