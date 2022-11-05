
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:confess/screens/forgot_password_screen.dart';
import 'package:confess/screens/login_screen.dart';
import 'package:confess/screens/my_confession_screen.dart';
import 'package:confess/screens/register_screen.dart';
import 'package:confess/screens/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:new_version/new_version.dart';
import 'package:page_transition/page_transition.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.white, // navigation bar color
    statusBarColor: Colors.white, // status bar color
    statusBarIconBrightness: Brightness.dark, // status bar icons' color
    systemNavigationBarIconBrightness: Brightness.dark,
  ));
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _checkVersion();
  }

  // Future<void> _checkVersion() async {
  //   final newVersion = NewVersion(
  //     androidId: "com.example.confess",
  //   );
  //   final status = await newVersion.getVersionStatus();
  //   newVersion.showUpdateDialog(
  //     context: this.context,
  //     versionStatus: status!,
  //     dialogTitle: 'Update Available!',
  //     dismissButtonText: 'Close',
  //     dialogText: 'To access the latest features, update the app from ' + '${status.localVersion}' + " to "+ "${status.storeVersion}",
  //     dismissAction: (){
  //       SystemNavigator.pop();
  //     },
  //     updateButtonText: 'Update',
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'confess',
      home: SafeArea(
        child: AnimatedSplashScreen(
          backgroundColor: Colors.white,
          splash: 'assets/images/confess-splash-screen.png',
          splashIconSize: 250,
          centered: true,
          nextScreen: WelcomeScreen(),
          duration: 3000,
          splashTransition: SplashTransition.fadeTransition,
          pageTransitionType: PageTransitionType.fade,
        ),
      ),
    );
  }
}
