import 'package:another_flushbar/flushbar.dart';
import 'package:english_vip/functions/authenticationFunction.dart';
import 'package:english_vip/routes/route_names.dart';
import 'package:english_vip/widgets/customTextField.dart';
import 'package:english_vip/widgets/headerWidget.dart';
import 'package:english_vip/widgets/loadingButtonWidget.dart';
import 'package:english_vip/widgets/regularTextWidget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../constant.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final AuthenticationFunction authenticationFunction =
      AuthenticationFunction();
  TapGestureRecognizer navToReg;
  final TextEditingController _emailTextEditingController =
      TextEditingController();
  final TextEditingController _fullNameTextEditingController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordTextEditingController =
      TextEditingController();
  final TextEditingController _cpasswordTextEditingController =
      TextEditingController();
  final TextEditingController _phoneTextEditingController =
      TextEditingController();
  bool isLoading = false;
  String country = "";
  String countryCode = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    navToReg = TapGestureRecognizer()
      ..onTap = () {
        Navigator.pushReplacementNamed(context, loginRoute);
      };
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailTextEditingController.dispose();
    _fullNameTextEditingController.dispose();
    _passwordTextEditingController.dispose();
    _cpasswordTextEditingController.dispose();
    _phoneTextEditingController.dispose();
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
                  child: HeaderWidget(
                    clricn: kAppColor,
                    clrBtn: kBackgroundColor,
                    headerText: signupText,
                    txtClr: kAppColor,
                  ),
                ),
              ),
              Container(
                height: screenHeight,
                width: screenWidth,
                decoration: BoxDecoration(
                  color: kBackgroundColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                ),
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
                          controller: _fullNameTextEditingController,
                          data: Icons.account_circle_outlined,
                          hintText: nameText,
                          isObscure: false,
                          func: (val) =>
                              val.isEmpty ? validationMsgEmail : null,
                        ),
                        SizedBox(
                          height: 20,
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
                        IntlPhoneField(
                          controller: _phoneTextEditingController,
                          validator: (val) => val == null ? validPhone : null,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(15.0),
                              borderSide: BorderSide(
                                color: kDarkBackgroundColor,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(15.0),
                              borderSide:
                                  BorderSide(color: kDarkBackgroundColor),
                            ),
                            hintText: phone,
                            labelText: phone,
                            errorBorder: OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(15.0),
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(15.0),
                              borderSide:
                                  BorderSide(color: kDarkBackgroundColor),
                            ),
                            hintStyle: TextStyle(
                              color: kDarkBackgroundColor,
                              fontSize: 15,
                            ),
                            labelStyle: TextStyle(
                              color: kDarkBackgroundColor,
                              fontSize: 15,
                            ),
                            prefixIcon: IconButton(
                              icon: Icon(
                                Icons.phone,
                                color: kAppColor,
                              ),
                            ),
                          ),
                          initialCountryCode: 'SA',
                          onChanged: (phone) {
                            country = phone.country;
                            countryCode = phone.countryCode;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomTextField(
                          controller: _passwordTextEditingController,
                          data: Icons.vpn_key_outlined,
                          hintText: passwordText,
                          isObscure: true,
                          func: (val) => val.length < 6 ? passwordLength : null,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomTextField(
                          controller: _cpasswordTextEditingController,
                          data: Icons.vpn_key_outlined,
                          hintText: cpasswordText,
                          isObscure: true,
                          func: (val) =>
                              val != _passwordTextEditingController.text
                                  ? passwordDoNotMatch
                                  : null,
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
                                      countryCode = countryCode +
                                          "" +
                                          _phoneTextEditingController.text;
                                      dynamic result =
                                          await authenticationFunction
                                              .registerUser(
                                                  _emailTextEditingController
                                                      .text
                                                      .trim(),
                                                  _passwordTextEditingController
                                                      .text,
                                                  _fullNameTextEditingController
                                                      .text,
                                            countryCode,country,
                                                  );
                                      if (result.toString().length > 0) {
                                        setState(() {
                                          isLoading = false;
                                        });
                                        Flushbar(
                                                icon: Icon(
                                                  Icons.info_outline,
                                                  color: Colors.red,
                                                ),
                                                message: accountCreationError,
                                                duration: Duration(seconds: 8),
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
                                        Navigator.pushNamed(
                                          context,
                                          loginRoute,
                                          arguments: accountCreationSuccessful,
                                        );
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
                                          text: reisterText,
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
                                text: alreadyhaveanaccount,
                                style: TextStyle(
                                  color: kDarkBackgroundColor,
                                ),
                              ),
                              TextSpan(
                                recognizer: navToReg,
                                text: loginhere,
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
