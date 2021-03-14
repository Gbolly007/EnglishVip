import 'package:dots_indicator/dots_indicator.dart';
import 'package:english_vip/routes/route_names.dart';
import 'package:english_vip/views/secondPage.dart';
import 'package:english_vip/views/thirdPage.dart';
import 'package:flutter/material.dart';
import '../constant.dart';
import 'firstPage.dart';

class OnboardScreen extends StatefulWidget {
  @override
  _OnboardScreenState createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  int currentPageIndex;
  int pageLength;

  @override
  void initState() {
    // TODO: implement initState
    currentPageIndex = 0;
    pageLength = 3;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            PageView(
              physics: BouncingScrollPhysics(),
              children: <Widget>[
                FirstPage(),
                SecondPage(),
                ThirdPage(),
              ],
              onPageChanged: (value) {
                //change value of pageIndex
                setState(() {
                  currentPageIndex = value;
                });
              },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new DotsIndicator(
                        dotsCount: pageLength,
                        position: currentPageIndex.toDouble(),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: InkWell(
                      onTap: () {
                        return Navigator.pushNamedAndRemoveUntil(
                            context, loginRoute, (route) => false);
                      },
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width / 1.5,
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: kDarkBackgroundColor,
                          border: Border.all(
                            color: kDarkBackgroundColor,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Center(
                          child: Text(
                            currentPageIndex.toString() == "2"
                                ? continueText
                                : skipText,
                            style: TextStyle(
                              fontSize: 16,
                              color: kAppColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
