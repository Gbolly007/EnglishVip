import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:english_vip/functions/authenticationFunction.dart';
import 'package:english_vip/routes/route_names.dart';
import 'package:english_vip/widgets/regularTextWidget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constant.dart';
import 'custom_icons.dart';

class MainDrawer extends StatefulWidget {
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  final AuthenticationFunction authenticationFunction =
      AuthenticationFunction();
  @override
  void initState() {
    super.initState();
    updateUI();
  }

  DocumentSnapshot variable;
  String userName = "";
  int learningPoint = 0;

  void updateUI() async {
    var user = Provider.of<User>(context, listen: false);
    variable = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();
    setState(() {
      userName = variable.data()["fullName"];
      learningPoint = variable.data()["learningPoint"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: kBackgroundColor,
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              color: kDarkBackgroundColor,
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          width: 100,
                          height: 100,
                          margin: EdgeInsets.only(top: 20, bottom: 10),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage(
                                  'https://images.pexels.com/photos/3819797/pexels-photo-3819797.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Text(
                            userName,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Learning points",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: LinearProgressIndicator(
                            minHeight: 2,
                            value: 3000 / 5000,
                            backgroundColor: kLightAppColor,
                            valueColor: new AlwaysStoppedAnimation<Color>(
                                kAlternateAppColor),
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: Text(
                            learningPoint.toString(),
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.home_outlined,
                color: kAppColor,
              ),
              title: Text(
                homeFeedText,
                style: drawerFontSize,
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, bottomNavRoute);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.portrait,
                color: kAppColor,
              ),
              title: Text(
                userProfile,
                style: drawerFontSize,
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, userProfileRoute);
              },
            ),
            ListTile(
              leading: Icon(
                Custom.safety_divider_24px,
                color: kAppColor,
              ),
              title: Text(
                faceTofaceTest,
                style: drawerFontSize,
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, faceTestRoute);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.emoji_events_outlined,
                color: kAppColor,
              ),
              title: Text(
                leaderBoard,
                style: drawerFontSize,
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, viewLeaderBoardRoute);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.settings_outlined,
                color: kAppColor,
              ),
              title: Text(
                settings,
                style: drawerFontSize,
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, settingsRoute);
              },
            ),
            Expanded(
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 10,
                  ),
                  child: InkWell(
                    onTap: () async {
                      authenticationFunction.signOut().then((value) {
                        Navigator.pushNamedAndRemoveUntil(
                            context, loginRoute, (route) => false);
                      });
                    },
                    child: Container(
                      height: 55,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: kDarkBackgroundColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(30.0),
                        ),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.exit_to_app_outlined,
                              color: kAppColor,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            RegularTextWidget(
                              text: logout,
                              clr: kAppColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
