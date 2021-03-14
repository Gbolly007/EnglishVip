import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:countup/countup.dart';
import 'package:english_vip/routes/route_names.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:ui' as ui show  ImageFilter;
import '../constant.dart';
import 'main_drawer.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  DocumentSnapshot variable;
  String name = "";
  int learningPoint = 0;
  String desc = "";

  void updateUI() async {
    var user = Provider.of<User>(context, listen: false);
    variable = await FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid)
        .get();
    setState(() {
      name = variable.data()["fullName"];
      learningPoint = variable.data()["learningPoint"];
      desc = variable.data()["description"];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateUI();
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
          userProfile,
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: screenWidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    name,
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        letterSpacing: 5,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: <Widget>[
                      Container(
                        width: 120,
                        height: 120,
                        margin: EdgeInsets.only(top: 20, bottom: 10),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,

                          image: DecorationImage(

                            image: NetworkImage(
                                'https://images.pexels.com/photos/3819797/pexels-photo-3819797.jpeg?auto=compress&cs=tinysrgb&dpr=2&w=500'),
                            fit: BoxFit.cover,

                          ),

                          boxShadow: [
                            BoxShadow(
                              color: Colors.black,
                              blurRadius: 1.0,
                              spreadRadius: 0.0,
                              offset: Offset(
                                  2.0, 2.0), // shadow direction: bottom right
                            )
                          ],

                        ),

                      ),
                      ClipOval(
                        child: Material(
                          color: Colors.black, // button color
                          child: InkWell(
                             // inkwell color
                            child: SizedBox(width: 50, height: 50, child: Icon(Icons.camera_alt_outlined,color: kAppColor,),),
                            onTap: () {},
                          ),
                        ),
                      )

                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Countup(
                    begin: 0,
                    end: learningPoint.toDouble(),
                    duration: Duration(seconds: 3),
                    separator: ',',
                    style: TextStyle(
                      fontSize: 25,
                      color: kAppColor,
                    ),
                  ),
                  Text(
                    learningPoints,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(),
                      SizedBox(),
                      Padding(
                        padding: const EdgeInsets.only(left: 30.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, editDescRoute,
                                arguments: desc);
                          },
                          child: Icon(
                            Icons.edit_outlined,
                            color: kAppColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: screenWidth,
                    height: 150,
                    margin: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      border: Border.all(color: kDarkBackgroundColor),
                      borderRadius: BorderRadius.all(
                        Radius.circular(15.0),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        desc == null ? "" : desc,
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
