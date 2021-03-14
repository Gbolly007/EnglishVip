import 'package:another_flushbar/flushbar.dart';
import 'package:english_vip/functions/authenticationFunction.dart';
import 'package:english_vip/widgets/customTextField.dart';
import 'package:english_vip/widgets/headerWidget.dart';
import 'package:english_vip/widgets/loadingButtonWidget.dart';
import 'package:english_vip/widgets/regularTextWidget.dart';
import 'package:english_vip/widgets/roundedButtonWidget.dart';
import 'package:flutter/material.dart';
import '../constant.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final TextEditingController _currentpasswordTextEditingController =
      TextEditingController();
  final TextEditingController _newpasswordTextEditingController =
      TextEditingController();
  final TextEditingController _confirmpasswordTextEditingController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool checkCurrentPasswordValid = true;

  bool _isHidden = true;

  void toggleVisibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _currentpasswordTextEditingController.dispose();
    _confirmpasswordTextEditingController.dispose();
    _newpasswordTextEditingController.dispose();
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
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: screenHeight * 0.15,
                width: screenWidth,
                color: kBackgroundColor,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25.0,
                    vertical: 25,
                  ),
                  child: HeaderWidget(
                    clricn: kAppColor,
                    clrBtn: kDarkBackgroundColor,
                    headerText: changePassword,
                    txtClr: kDarkBackgroundColor,
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                width: screenWidth,
                color: kBackgroundColor,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.info_outline,
                              color: Colors.black,
                            ),
                            Expanded(
                              child: Text(
                                changePasswordDesc,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          controller: _currentpasswordTextEditingController,
                          obscureText: _isHidden,
                          validator: (val) =>
                              val.isEmpty ? fieldnotempty : null,
                          style: TextStyle(
                            color: kDarkBackgroundColor,
                            fontSize: 15,
                          ),
                          decoration: new InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(15.0),
                              borderSide:
                                  BorderSide(color: kDarkBackgroundColor),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(15.0),
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(15.0),
                              borderSide:
                                  BorderSide(color: kDarkBackgroundColor),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(15.0),
                              borderSide:
                                  BorderSide(color: kDarkBackgroundColor),
                            ),
                            hintText: "Current Password",
                            labelText: "Current Password",
                            hintStyle: TextStyle(
                              color: kDarkBackgroundColor,
                              fontSize: 15,
                            ),
                            labelStyle: TextStyle(
                              color: kDarkBackgroundColor,
                              fontSize: 15,
                            ),
                            errorText: checkCurrentPasswordValid
                                ? null
                                : passwordnotmatchexistingpassword,
                            prefixIcon: IconButton(
                              icon: Icon(
                                Icons.vpn_key_outlined,
                                color: kAppColor,
                              ),
                            ),
                            suffixIcon: IconButton(
                              icon: _isHidden
                                  ? Icon(Icons.visibility_off)
                                  : Icon(Icons.visibility),
                              onPressed: toggleVisibility,
                              color: kAppColor,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        CustomTextField(
                          controller: _newpasswordTextEditingController,
                          data: Icons.vpn_key_outlined,
                          hintText: newPassword,
                          isObscure: true,
                          func: (val) => val.length < 6 ? passwordLength : null,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        CustomTextField(
                          controller: _confirmpasswordTextEditingController,
                          data: Icons.vpn_key_outlined,
                          hintText: confirmPassword,
                          isObscure: true,
                          func: (val) =>
                              val != _newpasswordTextEditingController.text
                                  ? passwordDoNotMatch
                                  : null,
                        ),
                        SizedBox(
                          height: 40,
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
                                      checkCurrentPasswordValid =
                                          await checkCurrentPassword(
                                              _currentpasswordTextEditingController
                                                  .text);
                                      setState(() {});
                                      if (checkCurrentPasswordValid) {
                                        updateUserPassword(
                                            _newpasswordTextEditingController
                                                .text);
                                        setState(() {
                                          isLoading = false;
                                        });
                                        Flushbar(
                                                icon: Icon(
                                                  Icons.info_outline,
                                                  size: 28.0,
                                                  color: Colors.blue,
                                                ),
                                                message: passwordchanged,
                                                duration: Duration(seconds: 5),
                                                margin: EdgeInsets.all(8),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                flushbarStyle:
                                                    FlushbarStyle.FLOATING)
                                            .show(context);
                                        _currentpasswordTextEditingController
                                            .clear();
                                        _newpasswordTextEditingController
                                            .clear();
                                        _confirmpasswordTextEditingController
                                            .clear();
                                      } else {
                                        setState(() {
                                          isLoading = false;
                                        });
                                        Flushbar(
                                                icon: Icon(
                                                  Icons.info_outline,
                                                  size: 28.0,
                                                  color: Colors.red,
                                                ),
                                                message: exceptionError,
                                                duration: Duration(seconds: 8),
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
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> checkCurrentPassword(String cpassword) async {
    return await AuthenticationFunction().validatePassword(cpassword);
  }

  void updateUserPassword(String password) {
    AuthenticationFunction().updatePassword(password);
  }
}
