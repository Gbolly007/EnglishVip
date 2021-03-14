import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:english_vip/constant.dart';
import 'package:english_vip/widgets/linearProgressWidget.dart';
import 'package:english_vip/widgets/noContentList.dart';
import 'package:flutter/material.dart';

import 'main_drawer.dart';

class ViewLeaderboard extends StatefulWidget {
  @override
  _ViewLeaderboardState createState() => _ViewLeaderboardState();
}

class _ViewLeaderboardState extends State<ViewLeaderboard> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<DocumentSnapshot> _leaderItem = [];

  bool _loadingLeader = true;

  bool _gettingMoreLeaders = false;
  bool _moreLeadersAvailable = true;
  ScrollController _scrollController = ScrollController();

  DocumentSnapshot _lastDocument;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPosts();

    _scrollController.addListener(() {
      double maxScroll = _scrollController.position.maxScrollExtent;
      double currentScroll = _scrollController.position.pixels;
      double delta = MediaQuery.of(context).size.height * 0.75;
      if (maxScroll - currentScroll <= delta) {
        getMorePost();
      }
    });
  }

  Future getPosts() async {
    Query q = firestore
        .collection('users')
        .orderBy('learningPoint', descending: true)
        .limit(10);

    if (this.mounted) {
      setState(() {
        _loadingLeader = true;
      });
    }

    QuerySnapshot querySnapshot = await q.get();
    if (querySnapshot.docs.length >= 1) {
      _leaderItem = querySnapshot.docs;
      _lastDocument = querySnapshot.docs[querySnapshot.docs.length - 1];
    }
    if (this.mounted) {
      setState(() {
        _loadingLeader = false;
      });
    }
  }

  getMorePost() async {
    if (_moreLeadersAvailable == false) {
      return;
    }
    if (_gettingMoreLeaders == true) {
      return;
    }
    _gettingMoreLeaders = true;
    Query q = firestore
        .collection('users')
        .orderBy('learningPoint', descending: true)
        .startAfter([_lastDocument.data()['learningPoint']]).limit(10);

    QuerySnapshot querySnapshot = await q.get();
    if (querySnapshot.docs.length < 10) {
      _moreLeadersAvailable = false;
    }
    if (querySnapshot.docs.length >= 1) {
      _lastDocument = querySnapshot.docs[querySnapshot.docs.length - 1];
      _leaderItem.addAll(querySnapshot.docs);
    }
    setState(() {});
    _gettingMoreLeaders = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      drawer: MainDrawer(),
      appBar: AppBar(
        backgroundColor: kDarkBackgroundColor,
        centerTitle: true,
        iconTheme: IconThemeData(color: kAppColor),
        title: Text(
          leaderBoard,
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Flexible(
                child: _loadingLeader == true
                    ? LinearProg()
                    : Container(
                        margin: EdgeInsets.only(right: 10, left: 10),
                        child: _leaderItem.length == 0
                            ? NoListContent()
                            : ListView.builder(
                                itemCount: _leaderItem.length,
                                controller: _scrollController,
                                itemBuilder: (_, index) {
                                  return Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    elevation: 2,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12.0),
                                      child: Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Expanded(
                                              flex: 1,
                                              child: Row(
                                                children: <Widget>[
                                                  Expanded(
                                                    flex: 1,
                                                    child: Container(
                                                      width: 50,
                                                      height: 50,
                                                      margin: EdgeInsets.only(
                                                          top: 20, bottom: 10),
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
                                                            offset: Offset(2.0,
                                                                2.0), // shadow direction: bottom right
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Text(
                                                      _leaderItem[index]
                                                          .data()['fullName'],
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Text(
                                              _leaderItem[index]
                                                  .data()['learningPoint']
                                                  .toString(),
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: kAppColor,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
