import 'package:english_vip/widgets/roundedButtonWidget.dart';
import 'package:flutter/material.dart';

import '../constant.dart';

class HeaderWidget extends StatelessWidget {
  final Color clrBtn;
  final Color clricn;
  final String headerText;
  final Color txtClr;
  HeaderWidget({this.clrBtn, this.clricn, this.headerText, this.txtClr});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 50,
          height: 50,
          child: RoundedButtonWidget(
            icons: Icons.arrow_back_outlined,
            clrbtn: clrBtn,
            clricn: clricn,
            onPush: () async {
              Navigator.pop(context);
            },
          ),
        ),
        SizedBox(
          width: 15,
        ),
        Text(
          headerText,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: pageHeaderFontSize,
              color: txtClr),
        ),
      ],
    );
  }
}
