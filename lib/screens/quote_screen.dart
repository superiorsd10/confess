import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:quotes/quotes.dart';

import '../constants.dart';

class QuoteScreen extends StatefulWidget {
  const QuoteScreen({Key? key}) : super(key: key);

  @override
  State<QuoteScreen> createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {
  @override
  DateTime dateTime = DateTime.now();

  List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  void initState() {
    _refreshDate();
  }

  void _refreshDate() {
    dateTime = DateTime.now();
  }

  Widget build(BuildContext context) {
    final double h = MediaQuery.of(context).size.height;
    final double w = MediaQuery.of(context).size.width;
    int _month_index = dateTime.month;
    return SafeArea(
      child: Scaffold(
        backgroundColor: kWhite,
        body: SingleChildScrollView(
            child: Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, h / 26, 0, 0),
                child: Column(
                  children: [
                    const Text(
                      'Quote',
                      style: TextStyle(
                        fontFamily: 'RobotoBold',
                        color: kPrimary,
                        fontSize: 40,
                      ),
                    ),
                    SizedBox(
                      height: h / 20,
                    ),
                    Text(
                      '${dateTime.day}-${months[_month_index - 1]}-${dateTime.year}',
                      style: const TextStyle(
                        fontFamily: 'RobotoRegular',
                        fontSize: 28,
                        color: kPrimary,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 30,
                        horizontal: 20,
                      ),
                      margin: const EdgeInsets.symmetric(
                        vertical: 50,
                        horizontal: 30,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: kPrimary,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            Quotes.getRandom().content,
                            style: const TextStyle(
                              fontFamily: 'RobotoMedium',
                              fontSize: 22,
                              color: kWhite,
                            ),
                          ),
                          SizedBox(
                            height: h / 10,
                          ),
                          Text(
                            Quotes.getRandom().author,
                            style: const TextStyle(
                              fontFamily: 'RobotoBold',
                              fontSize: 28,
                              color: kWhite,
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
    );
  }
}
