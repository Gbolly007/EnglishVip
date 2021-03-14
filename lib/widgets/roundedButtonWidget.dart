import 'package:flutter/material.dart';

import '../constant.dart';

class RoundedButtonWidget extends StatelessWidget {
  final IconData icons;
  final Color clrbtn;
  final Function onPush;
  final Color clricn;
  RoundedButtonWidget({this.icons, this.onPush, this.clrbtn, this.clricn});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: onPush,
      color: clrbtn,
      shape: CircleBorder(side: BorderSide.none),
      child: Icon(
        icons,
        color: clricn,
      ),
    );
  }
}
