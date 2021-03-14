import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:english_vip/models/correctVideoArg.dart';
import 'package:english_vip/routes/route_names.dart';
import 'package:english_vip/widgets/linearProgressWidget.dart';
import 'package:english_vip/widgets/noContentList.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constant.dart';

class CorrectVideos extends StatefulWidget {
  @override
  _CorrectVideosState createState() => _CorrectVideosState();
}

class _CorrectVideosState extends State<CorrectVideos> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<DocumentSnapshot> _videoItem = [];
  bool _loadingvideo = true;
  DocumentSnapshot _lastDocument;
  bool _gettingMoreVideo = false;
  ScrollController _scrollController = ScrollController();
  bool _morePostAvailable = true;

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
    var user = Provider.of<User>(context, listen: false);
    Query q = firestore
        .collection('users')
        .doc(user.uid)
        .collection('correct')
        .orderBy('timePosted', descending: true)
        .limit(perpage);

    if (this.mounted) {
      setState(() {
        _loadingvideo = true;
      });
    }

    QuerySnapshot querySnapshot = await q.get();
    if (querySnapshot.docs.length >= 1) {
      _videoItem = querySnapshot.docs;
      _lastDocument = querySnapshot.docs[querySnapshot.docs.length - 1];
    }
    if (this.mounted) {
      setState(() {
        _loadingvideo = false;
      });
    }
  }

  getMorePost() async {
    if (_morePostAvailable == false) {
      return;
    }
    if (_gettingMoreVideo == true) {
      return;
    }
    _gettingMoreVideo = true;
    var user = Provider.of<User>(context, listen: false);
    Query q = firestore
        .collection('users')
        .doc(user.uid)
        .collection('correct')
        .orderBy('timePosted', descending: true)
        .startAfter([_lastDocument.data()['timePosted']]).limit(perpage);

    QuerySnapshot querySnapshot = await q.get();
    if (querySnapshot.docs.length < perpage) {
      _morePostAvailable = false;
    }
    if (querySnapshot.docs.length >= 1) {
      _lastDocument = querySnapshot.docs[querySnapshot.docs.length - 1];
      _videoItem.addAll(querySnapshot.docs);
    }
    setState(() {});
    _gettingMoreVideo = false;
  }

  navigateToDetailPage(DocumentSnapshot post) {
    CorrectVideoArgs screenArgs = new CorrectVideoArgs();
    screenArgs.post = post;
    Navigator.pushNamed(context, cvDetailsRoute, arguments: screenArgs);
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _loadingvideo
                ? LinearProg()
                : Container(
                    child: _videoItem.length == 0
                        ? NoListContent()
                        : GridView.builder(
                            shrinkWrap: true,
                            controller: _scrollController,
                            physics: ClampingScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.6,
                              mainAxisSpacing: 6.0,
                              crossAxisSpacing: 6.0,
                            ),
                            itemCount: _videoItem.length,
                            itemBuilder: (_, index) {
                              return InkWell(
                                onTap: () {
                                  navigateToDetailPage(_videoItem[index]);
                                },
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: <Widget>[
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: Image.network(
                                        _videoItem[index].data()["thumbnail"],
                                        fit: BoxFit.cover,
                                        color:
                                            Color.fromRGBO(255, 255, 255, 0.5),
                                        colorBlendMode: BlendMode.modulate,
                                        loadingBuilder: (BuildContext context,
                                            Widget child,
                                            ImageChunkEvent loadingProgress) {
                                          if (loadingProgress == null)
                                            return child;
                                          return CircularProgressIndicator(
                                            strokeWidth: 2,
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                    kAppColor),
                                            value: loadingProgress
                                                        .expectedTotalBytes !=
                                                    null
                                                ? loadingProgress
                                                        .cumulativeBytesLoaded /
                                                    loadingProgress
                                                        .expectedTotalBytes
                                                : null,
                                          );
                                        },
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.center,
                                      child: Icon(
                                        Icons.play_circle_outline,
                                        color: Colors.black,
                                        size: 40,
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Container(
                                        padding: EdgeInsets.all(16.0),
                                        color: Colors.black38,
                                        child: Row(
                                          children: <Widget>[
                                            Flexible(
                                              fit: FlexFit.tight,
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    _videoItem[index]
                                                        .data()["name"],
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Text(
                                                    "3200" + " " + "views",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }),
                  )
          ],
        ),
      ),
    );
  }
}
