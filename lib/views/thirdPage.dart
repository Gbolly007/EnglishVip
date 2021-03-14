import 'package:flutter/material.dart';

import '../constant.dart';

class ThirdPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          flex: 4,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Image.asset(
              'images/Onboard3rdImage.png',
            ),
          ),
        ),
        Flexible(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Text(
                  onboardThirdText,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: fontSizeOnBoarding,
                      height: 1.5,
                      color: kDarkBackgroundColor),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
