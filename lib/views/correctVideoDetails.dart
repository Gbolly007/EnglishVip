import 'package:english_vip/models/correctVideoArg.dart';
import 'package:english_vip/widgets/headerWidget.dart';
import 'package:english_vip/widgets/roundedButtonWidget.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../constant.dart';

class CorrectVideoDetails extends StatefulWidget {
  final CorrectVideoArgs data;
  CorrectVideoDetails({this.data});
  @override
  _CorrectVideoDetailsState createState() => _CorrectVideoDetailsState();
}

class _CorrectVideoDetailsState extends State<CorrectVideoDetails> {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: widget.data.post['videoId'],
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
                            widget.data.post['question'],
                            style: TextStyle(
                              fontSize: 15,
                              color: kLightColor,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        OptionWidget(
                          screenWidth: screenWidth,
                          answer: widget.data.post['answer'] == "optionA"
                              ? true
                              : false,
                          option: widget.data.post['optionA'],
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
                        OptionWidget(
                          screenWidth: screenWidth,
                          answer: widget.data.post['answer'] == "optionB"
                              ? true
                              : false,
                          option: widget.data.post['optionB'],
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
    @required this.answer,
  }) : super(key: key);

  final double screenWidth;
  final String option;
  final bool answer;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(
          answer ? Icons.check_circle_outlined : Icons.circle,
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
