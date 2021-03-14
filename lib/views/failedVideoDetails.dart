import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:english_vip/models/blankPageArgs.dart';
import 'package:english_vip/models/screenArguments.dart';
import 'package:english_vip/routes/route_names.dart';
import 'package:english_vip/widgets/headerWidget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../constant.dart';

class FailedVideoDetails extends StatefulWidget {
  final ScreenArgs data;
  FailedVideoDetails({this.data});
  @override
  _FailedVideoDetailsState createState() => _FailedVideoDetailsState();
}

class _FailedVideoDetailsState extends State<FailedVideoDetails> {
  addQuestion(bool isPassed) async {
    var user = Provider.of<User>(context, listen: false);

    if (isPassed) {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .collection("failed")
          .doc(widget.data.postId)
          .delete()
          .then((value) {
        FirebaseFirestore.instance
            .collection("users")
            .doc(user.uid)
            .update({"learningPoint": FieldValue.increment(1)});
      });
    } else {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .collection("correct")
          .add({
        "answer": widget.data.answer,
        "name": widget.data.name,
        "optionA": widget.data.optionA,
        "optionB": widget.data.optionB,
        "optionC": widget.data.optionC,
        "thumbnail": widget.data.thumbnail,
        "videoId": widget.data.videoId,
        "question": widget.data.question,
        "timePosted": Timestamp.now()
      }).then((value) {
        FirebaseFirestore.instance
            .collection("users")
            .doc(user.uid)
            .collection("failed")
            .doc(widget.data.postId)
            .delete();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: widget.data.videoId,
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: true,
      ),
    );
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: screenWidth,
                  color: kBackgroundColor,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25.0,
                      vertical: 25,
                    ),
                    child: Column(
                      children: [
                        HeaderWidget(
                          clricn: kAppColor,
                          clrBtn: kDarkBackgroundColor,
                          headerText: "Question&Answer",
                          txtClr: kDarkBackgroundColor,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: kDarkBackgroundColor),
                            borderRadius: BorderRadius.all(
                              Radius.circular(15.0),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: YoutubePlayer(
                              controller: _controller,
                              showVideoProgressIndicator: true,
                              progressIndicatorColor: kAppColor,
                              progressColors: ProgressBarColors(
                                playedColor: kAppColor,
                                handleColor: kLightAppColor,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.access_time_outlined,
                              color: kAppColor,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "January 09, 23:09",
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.visibility,
                              color: kAppColor,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "3200" + " views",
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: screenHeight * 0.5,
                  decoration: BoxDecoration(
                    color: kDarkBackgroundColor,
                    border: Border.all(color: kDarkBackgroundColor),
                    borderRadius: BorderRadius.all(
                      Radius.circular(15.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Question",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: kAppColor,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Directionality(
                          textDirection: TextDirection.ltr,
                          child: Text(
                            widget.data.question,
                            style: TextStyle(
                              fontSize: 15,
                              color: kLightColor,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () {
                            if (widget.data.answer == "optionA") {
                              addQuestion(true);
                              BlankPageArgs screenArgs = new BlankPageArgs();
                              screenArgs.result = "success";
                              screenArgs.page = "2";
                              screenArgs.feedback = correctAnswer;
                              Navigator.pushReplacementNamed(
                                  context, blankRoute,
                                  arguments: screenArgs);
                            } else {
                              addQuestion(false);
                              BlankPageArgs screenArgs = new BlankPageArgs();
                              screenArgs.result = "error";
                              screenArgs.page = "2";
                              screenArgs.feedback =
                                  wrongattemptAnswer +" "+ widget.data.answer;
                              Navigator.pushReplacementNamed(
                                  context, blankRoute,
                                  arguments: screenArgs);
                            }
                          },
                          child: OptionWidget(
                              screenWidth: screenWidth,
                              option: widget.data.optionA),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Divider(
                          height: 1,
                          color: kLightColor,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () {
                            if (widget.data.answer == "optionB") {
                              addQuestion(true);
                              BlankPageArgs screenArgs = new BlankPageArgs();
                              screenArgs.result = "success";
                              screenArgs.page = "2";
                              screenArgs.feedback = correctAnswer;
                              Navigator.pushReplacementNamed(
                                  context, blankRoute,
                                  arguments: screenArgs);
                            } else {
                              addQuestion(false);
                              BlankPageArgs screenArgs = new BlankPageArgs();
                              screenArgs.result = "error";
                              screenArgs.page = "2";
                              screenArgs.feedback =
                                  wrongattemptAnswer +" "+ widget.data.answer;
                              Navigator.pushReplacementNamed(
                                  context, blankRoute,
                                  arguments: screenArgs);
                            }
                          },
                          child: OptionWidget(
                              screenWidth: screenWidth,
                              option: widget.data.optionB),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OptionWidget extends StatelessWidget {
  const OptionWidget({
    Key key,
    @required this.screenWidth,
    @required this.option,
  }) : super(key: key);

  final double screenWidth;
  final String option;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(
          Icons.circle,
          color: kLightColor,
          size: 35,
        ),
        SizedBox(
          width: 15,
        ),
        Text(
          option,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: kAppColor,
            fontSize: 15,
          ),
        ),
      ],
    );
  }
}
