import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:english_vip/bloc/videoBloc.dart';
import 'package:english_vip/constant.dart';
import 'package:english_vip/models/screenArguments.dart';
import 'package:english_vip/routes/route_names.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  final String data;
  HomePage({this.data});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  VideoListBloc movieListBloc;

  ScrollController controller = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var user = Provider.of<User>(context, listen: false);
    movieListBloc = VideoListBloc();
    movieListBloc.fetchFirstList(user.uid);
    controller.addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: screenHeight,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: StreamBuilder<List<DocumentSnapshot>>(
                stream: movieListBloc.movieStream,
                builder: (context, snapshot) {
                  if (snapshot.data != null) {
                    return GridView.builder(
                      shrinkWrap: true,
                      controller: controller,
                      physics: ClampingScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.6,
                        mainAxisSpacing: 6.0,
                        crossAxisSpacing: 6.0,
                      ),
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            ScreenArgs screenArgs = new ScreenArgs();
                            screenArgs.answer = snapshot.data[index]["answer"];
                            screenArgs.videoId =
                                snapshot.data[index]["videoId"];
                            screenArgs.optionA =
                                snapshot.data[index]["optionA"];
                            screenArgs.optionB =
                                snapshot.data[index]["optionB"];
                            screenArgs.optionC =
                                snapshot.data[index]["optionC"];
                            screenArgs.question =
                                snapshot.data[index]["question"];
                            screenArgs.views =
                                snapshot.data[index]["views"].toString();
                            screenArgs.thumbnail =
                                snapshot.data[index]["thumbnail"];
                            screenArgs.name = snapshot.data[index]["name"];
                            screenArgs.postId = snapshot.data[index].id;
                            Navigator.pushNamed(context, videoDetailsRoute,
                                arguments: screenArgs);
                          },
                          child: Stack(
                            fit: StackFit.expand,
                            children: <Widget>[
                              ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.network(
                                  snapshot.data[index]["thumbnail"],
                                  fit: BoxFit.cover,
                                  color: Color.fromRGBO(255, 255, 255, 0.5),
                                  colorBlendMode: BlendMode.modulate,
                                  loadingBuilder: (BuildContext context,
                                      Widget child,
                                      ImageChunkEvent loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          kAppColor),
                                      value: loadingProgress
                                                  .expectedTotalBytes !=
                                              null
                                          ? loadingProgress
                                                  .cumulativeBytesLoaded /
                                              loadingProgress.expectedTotalBytes
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
                                              snapshot.data[index]["name"],
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            Text(
                                              snapshot.data[index]["views"]
                                                      .toString() +
                                                  " " +
                                                  "views",
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
                      },
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  void _scrollListener() {
    var user = Provider.of<User>(context, listen: false);
    if (controller.offset >= controller.position.maxScrollExtent &&
        !controller.position.outOfRange) {
      print("at the end of list");
      movieListBloc.fetchNextMovies(user.uid);
    }
  }
}
