import 'package:another_flushbar/flushbar.dart';
import 'package:english_vip/functions/userProfileFunc.dart';
import 'package:english_vip/widgets/roundedButtonWidget.dart';
import 'package:flutter/material.dart';

import '../constant.dart';

class EditDesc extends StatefulWidget {
  final String desc;
  EditDesc({this.desc});
  @override
  _EditDescState createState() => _EditDescState();
}

class _EditDescState extends State<EditDesc> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  final UserProfileFunc userProfileFunc = UserProfileFunc();
  var _notesController;

  String abtMe;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _notesController = new TextEditingController(text: widget.desc);
  }

  @override
  void dispose() {
    super.dispose();
    _notesController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var circularProgButton = CircularProgressIndicator(
      strokeWidth: 2,
      valueColor: AlwaysStoppedAnimation<Color>(kDarkBackgroundColor),
    );
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: screenWidth,
            child: Padding(
              padding: const EdgeInsets.only(top: 30.0, left: 20.0, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        child: RoundedButtonWidget(
                          clrbtn: kDarkBackgroundColor,
                          clricn: kAppColor,
                          icons: Icons.arrow_forward_outlined,
                          onPush: () async {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      isLoading
                          ? circularProgButton
                          : InkWell(
                              onTap: () async {
                                if (_formKey.currentState.validate()) {
                                  setState(() {
                                    isLoading = true;
                                  });

                                  dynamic result = await userProfileFunc
                                      .addDesc(_notesController.text);

                                  if (result.toString().length == 0) {
                                    setState(() {
                                      isLoading = false;
                                    });
                                    Flushbar(
                                            icon: Icon(
                                              Icons.verified_outlined,
                                              color: Colors.blue,
                                            ),
                                            message: descedited,
                                            duration: Duration(seconds: 3),
                                            margin: EdgeInsets.all(8),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            flushbarStyle:
                                                FlushbarStyle.FLOATING)
                                        .show(context);
                                  } else {
                                    setState(() {
                                      isLoading = false;
                                    });
                                    Flushbar(
                                            icon: Icon(
                                              Icons.info_outline,
                                              color: Colors.red,
                                            ),
                                            message: exceptionError,
                                            duration: Duration(seconds: 5),
                                            margin: EdgeInsets.all(8),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            flushbarStyle:
                                                FlushbarStyle.FLOATING)
                                        .show(context);
                                  }
                                }
                              },
                              child: Text(
                                submit,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: kDarkBackgroundColor),
                              ),
                            )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Form(
                    key: _formKey,
                    child: TextFormField(
                      controller: _notesController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                      autofocus: true,
                      validator: (val) => val.isEmpty ? descempty : null,
                      maxLines: 10,
                      maxLength: 120,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
