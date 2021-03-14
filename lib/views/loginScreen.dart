import 'package:another_flushbar/flushbar.dart';
import 'package:english_vip/functions/authenticationFunction.dart';
import 'package:english_vip/routes/route_names.dart';
import 'package:english_vip/widgets/customTextField.dart';
import 'package:english_vip/widgets/loadingButtonWidget.dart';
import 'package:english_vip/widgets/regularTextWidget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../constant.dart';

class LoginScreen extends StatefulWidget {
  final String data;
  LoginScreen({this.data});
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TapGestureRecognizer navToReg;
  final TextEditingController _emailTextEditingController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordTextEditingController =
      TextEditingController();
  bool isLoading = false;
  final AuthenticationFunction authenticationFunction =
      AuthenticationFunction();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    navToReg = TapGestureRecognizer()
      ..onTap = () {
        Navigator.pushNamed(context, registerRoute);
      };

    if (widget.data != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Flushbar(
                icon: Icon(
                  Icons.verified_outlined,
                  color: Colors.blue,
                ),
                message: widget.data,
                duration: Duration(seconds: 8),
                margin: EdgeInsets.all(8),
                borderRadius: BorderRadius.circular(8),
                flushbarStyle: FlushbarStyle.FLOATING)
            .show(context);
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailTextEditingController.dispose();
    _passwordTextEditingController.dispose();
  }

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
                  child: Text(
                    signinText,
                    style: TextStyle(
                      fontSize: pageHeaderFontSize,
                      fontWeight: FontWeight.bold,
                      color: kAppColor,
                    ),
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
                        CustomTextField(
                          controller: _emailTextEditingController,
                          data: Icons.alternate_email_outlined,
                          hintText: emailText,
                          isObscure: false,
                          func: (val) =>
                              val.isEmpty ? validationMsgEmail : null,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        CustomTextField(
                          controller: _passwordTextEditingController,
                          data: Icons.vpn_key_outlined,
                          hintText: passwordText,
                          isObscure: true,
                          func: (val) => val.length < 6 ? passwordLength : null,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            SizedBox(),
                            SizedBox(),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, forgotPasswordRoute);
                              },
                              child: Text(
                                forgotPasswordques,
                                style: TextStyle(
                                    fontSize: 15,
                                    color: kDarkBackgroundColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
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
                                    Navigator.pushNamed(
                                        context, setupAccountRoute);
                                    try {
                                      if (_formKey.currentState.validate()) {
                                        setState(() {
                                          isLoading = true;
                                        });

                                        dynamic result =
                                            await authenticationFunction.signIn(
                                                _emailTextEditingController.text
                                                    .trim(),
                                                _passwordTextEditingController
                                                    .text
                                                    .trim());

                                        if (result.toString().length > 0) {
                                          setState(() {
                                            isLoading = false;
                                          });
                                          Flushbar(
                                                  icon: Icon(
                                                    Icons.info_outline,
                                                    color: Colors.red,
                                                  ),
                                                  message: loginError,
                                                  duration:
                                                      Duration(seconds: 5),
                                                  margin: EdgeInsets.all(8),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  flushbarStyle:
                                                      FlushbarStyle.FLOATING)
                                              .show(context);
                                        } else {
                                          dynamic result =
                                              await authenticationFunction
                                                  .setUpAccount();
                                          setState(() {
                                            isLoading = false;
                                          });
                                          if (result == true) {
                                            Navigator.pushReplacementNamed(
                                                context, bottomNavRoute);
                                          } else {
                                            Navigator.pushReplacementNamed(
                                                context, setupAccountRoute);
                                          }
                                        }
                                      }
                                    } catch (e) {
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
                                          text: loginText,
                                          clr: kAppColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                        SizedBox(
                          height: 40,
                        ),
                        RichText(
                          text: TextSpan(
                            style: TextStyle(fontSize: 15),
                            children: <TextSpan>[
                              TextSpan(
                                text: donthaveanaccount,
                                style: TextStyle(
                                  color: kDarkBackgroundColor,
                                ),
                              ),
                              TextSpan(
                                recognizer: navToReg,
                                text: createOne,
                                style: TextStyle(
                                  color: kAppColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
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
