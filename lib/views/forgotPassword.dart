import 'package:another_flushbar/flushbar.dart';
import 'package:english_vip/functions/authenticationFunction.dart';
import 'package:english_vip/routes/route_names.dart';
import 'package:english_vip/widgets/customTextField.dart';
import 'package:english_vip/widgets/headerWidget.dart';
import 'package:english_vip/widgets/loadingButtonWidget.dart';
import 'package:english_vip/widgets/regularTextWidget.dart';
import 'package:english_vip/widgets/roundedButtonWidget.dart';
import 'package:flutter/material.dart';

import '../constant.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController _emailTextEditingController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  final AuthenticationFunction authenticationFunction =
      AuthenticationFunction();

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    var circularProgButton = CircularProgressIndicator(
      strokeWidth: 2,
      valueColor: AlwaysStoppedAnimation<Color>(kAppColor),
    );
    return Scaffold(
      backgroundColor: kDarkBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: screenHeight * 0.15,
                width: screenWidth,
                color: kDarkBackgroundColor,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25.0,
                    vertical: 25,
                  ),
                  child: HeaderWidget(
                    clricn: kAppColor,
                    clrBtn: kBackgroundColor,
                    headerText: forgotPassword,
                    txtClr: kAppColor,
                  ),
                ),
              ),
              Container(
                height: screenHeight * 0.85,
                width: screenWidth,
                decoration: borderWidget,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          forgotPasswordDesc,
                          style: TextStyle(
                              fontSize: 15,
                              color: kDarkBackgroundColor,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        CustomTextField(
                          controller: _emailTextEditingController,
                          data: Icons.alternate_email_outlined,
                          hintText: emailText,
                          isObscure: false,
                          func: (val) =>
                              val.isEmpty ? validationMsgEmail : null,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        isLoading
                            ? LoadingButtonWidget(
                                screenWidth: screenWidth,
                                circularProgButton: circularProgButton,
                              )
                            : Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: InkWell(
                                  onTap: () async {
                                    if (_formKey.currentState.validate()) {
                                      setState(() {
                                        isLoading = true;
                                      });
                                      String confirm =
                                          await authenticationFunction
                                              .sendPasswordResetEmail(
                                                  _emailTextEditingController
                                                      .text);
                                      if (confirm ==
                                          "Reset Link has been sent") {
                                        setState(() {
                                          isLoading = false;
                                        });
                                        Navigator.pushNamed(
                                          context,
                                          loginRoute,
                                          arguments: resetsent,
                                        );
                                      } else {
                                        setState(() {
                                          isLoading = false;
                                        });
                                        Flushbar(
                                                icon: Icon(
                                                  Icons.info_outline,
                                                  color: Colors.red,
                                                ),
                                                message: errorforgotpassword,
                                                duration: Duration(seconds: 3),
                                                margin: EdgeInsets.all(8),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                flushbarStyle:
                                                    FlushbarStyle.FLOATING)
                                            .show(context);
                                      }
                                    }
                                  },
                                  child: Card(
                                    elevation: 5,
                                    color: kDarkBackgroundColor,
                                    child: Container(
                                      height: 55,
                                      width: screenWidth,
                                      decoration: BoxDecoration(
                                        color: kDarkBackgroundColor,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(30.0),
                                        ),
                                      ),
                                      child: Center(
                                        child: RegularTextWidget(
                                          text: submitText,
                                          clr: kAppColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                      ],
                    ),
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
