import 'package:cool_alert/cool_alert.dart';
import 'package:english_vip/constant.dart';
import 'package:english_vip/models/blankPageArgs.dart';
import 'package:english_vip/routes/route_names.dart';
import 'package:flutter/material.dart';

class BlankPage extends StatefulWidget {
  final BlankPageArgs data;
  BlankPage({this.data});
  @override
  _BlankPageState createState() => _BlankPageState();
}

class _BlankPageState extends State<BlankPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.data != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (widget.data.result == "success") {
          CoolAlert.show(
              context: context,
              type: CoolAlertType.success,
              text: widget.data.feedback,
              barrierDismissible: false,
              onConfirmBtnTap: () {
                Navigator.pushReplacementNamed(context, bottomNavRoute,
                    arguments: widget.data.page);
              });
        } else {
          CoolAlert.show(
              context: context,
              type: CoolAlertType.error,
              text: widget.data.feedback,
              barrierDismissible: false,
              onConfirmBtnTap: () {
                Navigator.pushReplacementNamed(context, bottomNavRoute,
                    arguments: widget.data.page);
              });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kBackgroundColor,
    );
  }
}
