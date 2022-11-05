import 'package:confess/screens/add_confession.dart';
import 'package:confess/screens/contact_me.dart';
import 'package:confess/screens/profile_screen.dart';
import 'package:confess/screens/quote_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:page_transition/page_transition.dart';

import '../constants.dart';
import 'explore_screen.dart';
import 'instructions.dart';
import 'my_confession_screen.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentTab = 0;
  final List<Widget> screens = [
    MyConfessionScreen(),
    ExploreScreen(),
    AddConfessionScreen(),
    QuoteScreen(),
    ProfileScreen(),
  ];

  final PageStorageBucket pageStorageBucket = PageStorageBucket();
  Widget currentScreen = MyConfessionScreen();

  final iconList = <IconData>[
    Icons.home_rounded,
    Icons.explore_rounded,
    Icons.add_circle_rounded,
    Icons.format_quote_rounded,
    Icons.person_rounded,
  ];

  void _navigateBottomBar(int index) {
    setState(() {
      currentTab = index;
    });
  }

  late ScrollController _scrollController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: kWhite,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            'confess',
            style: TextStyle(
              color: kSecondary,
              fontSize: 40,
              fontFamily: 'RobotoBold',
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                PageTransition(
                  child: ContactMe(),
                  type: PageTransitionType.fade,
                ),
              );
            },
            icon: const Icon(
              Icons.integration_instructions_outlined,
              size: 35,
              color: kSecondary,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.info_outline_rounded,
                size: 35,
                color: kSecondary,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  PageTransition(
                    child: Instructions(),
                    type: PageTransitionType.fade,
                  ),
                );
              },
            ),
          ],
        ),
        body: screens[currentTab],
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () => Navigator.push(
        //     context,
        //     PageTransition(
        //       child: AddConfessionScreen(),
        //       type: PageTransitionType.fade,
        //     ),
        //   ),
        //   elevation: 0,
        //   backgroundColor: kSecondary,
        //   child: const Icon(
        //     Icons.add,
        //     color: kWhite,
        //     size: 30,
        //   ),
        // ),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: Container(
          color: kWhite,
          padding: const EdgeInsets.all(8),
          child: GNav(
            selectedIndex: currentTab,
            onTabChange: _navigateBottomBar,
            backgroundColor: kWhite,
            color: kSecondary,
            activeColor: kWhite,
            tabBackgroundColor: kSecondary,
            padding: const EdgeInsets.all(16),
            gap: 8,
            tabs: const [
              GButton(
                icon: Icons.home_rounded,
                text: 'Home',
              ),
              GButton(
                icon: Icons.explore_rounded,
                text: 'Explore',
              ),
              GButton(
                icon: Icons.add_circle_rounded,
                text: 'Add',
              ),
              GButton(
                icon: Icons.format_quote_rounded,
                text: 'Quote',
              ),
              GButton(
                icon: Icons.person_rounded,
                text: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// BottomAppBar(
// color: kSecondary,
// elevation: 0,
// shape: CircularNotchedRectangle(),
// notchMargin: 10,
// child: Container(
// height: 70,
// child: Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: <Widget>[
// Row(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Stack(
// alignment: Alignment.center,
// children: [
// currentTab == 0
// ? Container(
// height: 55,
// width: 60,
// color: kSecondary,
// )
// : Container(),
// MaterialButton(
// onPressed: () {
// setState(() {
// currentScreen = MyConfessionScreen();
// currentTab = 0;
// });
// },
// minWidth: 40,
// child: Column(
// mainAxisAlignment: MainAxisAlignment.center,
// children: const [
// Icon(
// Icons.home_rounded,
// color: kWhite,
// ),
// Text(
// 'Home',
// style: TextStyle(
// color: kWhite,
// fontFamily: 'RobotoMedium',
// fontSize: 15,
// ),
// ),
// ],
// ),
// ),
// ],
// ),
// Stack(
// alignment: Alignment.center,
// children: [
// currentTab == 1
// ? Container(
// height: 55,
// width: 60,
// color: kSecondary,
// )
//     : Container(),
// MaterialButton(
// onPressed: () {
// setState(() {
// currentScreen = ExploreScreen();
// currentTab = 1;
// });
// },
// minWidth: 40,
// child: Column(
// mainAxisAlignment: MainAxisAlignment.center,
// children: const [
// Icon(
// Icons.explore_rounded,
// color: kWhite,
// ),
// Text(
// 'Explore',
// style: TextStyle(
// color: kWhite,
// fontFamily: 'RobotoMedium',
// fontSize: 15,
// ),
// ),
// ],
// ),
// ),
// ],
// ),
// ],
// ),
// Row(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Stack(
// alignment: Alignment.center,
// children: [
// currentTab == 2
// ? Container(
// height: 55,
// width: 60,
// color: kSecondary,
// )
//     : Container(),
// MaterialButton(
// onPressed: () {
// setState(() {
// currentScreen = QuoteScreen();
// currentTab = 2;
// });
// },
// minWidth: 40,
// child: Column(
// mainAxisAlignment: MainAxisAlignment.center,
// children: const [
// Icon(
// Icons.format_quote_rounded,
// color: kWhite,
// ),
// Text(
// 'Quote',
// style: TextStyle(
// color: kWhite,
// fontFamily: 'RobotoMedium',
// fontSize: 15,
// ),
// ),
// ],
// ),
// ),
// ],
// ),
// Stack(
// alignment: Alignment.center,
// children: [
// currentTab == 3
// ? Container(
// height: 55,
// width: 60,
// color: kSecondary,
// )
//     : Container(),
// MaterialButton(
// onPressed: () {
// setState(() {
// currentScreen = ProfileScreen();
// currentTab = 3;
// });
// },
// minWidth: 40,
// child: Column(
// mainAxisAlignment: MainAxisAlignment.center,
// children: const [
// Icon(
// Icons.person_rounded,
// color: kWhite,
// ),
// Text(
// 'Profile',
// style: TextStyle(
// color: kWhite,
// fontFamily: 'RobotoMedium',
// fontSize: 15,
// ),
// ),
// ],
// ),
// ),
// ],
// ),
// ],
// )
// ],
// ),
// ),
// ),
