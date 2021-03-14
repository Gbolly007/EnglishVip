import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:english_vip/views/correctVideos.dart';
import 'package:english_vip/views/homePage.dart';
import 'package:english_vip/views/wrongVideos.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constant.dart';
import 'main_drawer.dart';

class BottomNavbar extends StatefulWidget {
  final String data;
  BottomNavbar({this.data});
  @override
  _BottomNavbarState createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  final PageStorageBucket bucket = PageStorageBucket();
  PageController pageController = PageController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    configureRealTimePushNotifcations();
    if (widget.data != null) {
      var one = int.parse(widget.data);

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (pageController.hasClients) {
          pageController.animateToPage(one,
              duration: Duration(milliseconds: 1), curve: Curves.easeInOut);
        }
      });

      _onPageChanged(one);
    }
  }

  configureRealTimePushNotifcations() async {
    final user = Provider.of<User>(context, listen: false);
    if (Platform.isIOS) {
      getIOSPermissions();
    }
    await FirebaseMessaging.instance.getToken().then((token) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update({'androidNotificationToken': token});
    });
  }

  getIOSPermissions() async {
    FirebaseMessaging.instance
        .requestPermission(alert: true, badge: true, sound: true);
  }

  final List<Widget> screens = [
    HomePage(),
    CorrectVideos(),
    WrongVideos(),
  ];

  onItemTapped(int index) {
    pageController.jumpToPage(index);
  }

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        backgroundColor: kDarkBackgroundColor,
        centerTitle: true,
        iconTheme: IconThemeData(color: kAppColor),
        title: Text(
          homeFeedText,
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
      body: PageView(
        controller: pageController,
        onPageChanged: _onPageChanged,
        children: screens,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: _selectedIndex,
        onTap: onItemTapped,
        backgroundColor: kDarkBackgroundColor,
        iconSize: 20,
        activeColor: kAppColor,
        inactiveColor: inactivecolor,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.video_collection_outlined,
              size: 30,
            ),
            label: 'VideoFeed',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.check_circle_outlined,
            ),
            label: 'Correct Videos',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.cancel,
            ),
            label: 'Wrong Videos',
          ),
        ],
      ),
    );
  }
}
