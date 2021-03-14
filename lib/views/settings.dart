import 'package:english_vip/routes/route_names.dart';
import 'package:flutter/material.dart';

import '../constant.dart';
import 'main_drawer.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
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
          settings,
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: screenHeight,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, changePasswordRoute);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        changePassword,
                        style: settingsStyle,
                      ),
                      BackButton()
                    ],
                  ),
                ),
                Box(),
                Seperator(),
                Box(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      privacyPolicy,
                      style: settingsStyle,
                    ),
                    BackButton()
                  ],
                ),
                Box(),
                Seperator(),
                Box(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      tandc,
                      style: settingsStyle,
                    ),
                    BackButton()
                  ],
                ),
                Box(),
                Seperator(),
                Box(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      requestInfo,
                      style: settingsStyle,
                    ),
                    BackButton()
                  ],
                ),
                Box(),
                Seperator(),
                Box(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      contactUs,
                      style: settingsStyle,
                    ),
                    BackButton()
                  ],
                ),
                Box(),
                Seperator(),
                Box(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BackButton extends StatelessWidget {
  const BackButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.arrow_left_outlined,
      color: kDarkBackgroundColor,
    );
  }
}

class Box extends StatelessWidget {
  const Box({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
    );
  }
}

class Seperator extends StatelessWidget {
  const Seperator({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: Colors.black,
      thickness: 1,
    );
  }
}
