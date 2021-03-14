import 'package:another_flushbar/flushbar.dart';
import 'package:english_vip/functions/services.dart';
import 'package:english_vip/routes/route_names.dart';
import 'package:english_vip/widgets/regularTextWidget.dart';
import 'package:flutter/material.dart';

import '../constant.dart';
import 'main_drawer.dart';

class FaceTest extends StatefulWidget {
  final String data;
  FaceTest({this.data});
  @override
  _FaceTestState createState() => _FaceTestState();
}

class _FaceTestState extends State<FaceTest> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.data != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Flushbar(
                icon: Icon(
                  Icons.verified_outlined,
                  color: Colors.blue,
                ),
                message: widget.data,
                duration: Duration(seconds: 8),
                margin: EdgeInsets.all(8),
                borderRadius: BorderRadius.circular(8),
                flushbarStyle: FlushbarStyle.FLOATING)
            .show(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      drawer: MainDrawer(),
      appBar: AppBar(
        backgroundColor: kDarkBackgroundColor,
        centerTitle: true,
        iconTheme: IconThemeData(color: kAppColor),
        title: Text(
          faceTofaceTest,
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
            height: screenHeight,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 30,
                ),
                Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Neque volutpat ac tincidunt vitae semper",
                  style: TextStyle(fontSize: 15, height: 2),
                ),
                SizedBox(
                  height: 60,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: InkWell(
                    onTap: () async {
                      Navigator.pushNamed(context, cardPaymentRoute);
                    },
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
                          child: RegularTextWidget(
                            text: schedule,
                            clr: kAppColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
