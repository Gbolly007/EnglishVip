import 'package:flutter/material.dart';

import '../constant.dart';

class LoadingButtonWidget extends StatelessWidget {
  const LoadingButtonWidget({
    Key key,
    @required this.screenWidth,
    @required this.circularProgButton,
  }) : super(key: key);

  final double screenWidth;
  final CircularProgressIndicator circularProgButton;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Card(
        elevation: 5,
        color: kDarkBackgroundColor,
        child: Container(
          height: 55,
          width: screenWidth,
          decoration: BoxDecoration(
            color: kDarkBackgroundColor,
            borderRadius: BorderRadius.all(
              Radius.circular(30.0),
            ),
          ),
          child: Center(
            child: circularProgButton,
          ),
        ),
      ),
    );
  }
}
