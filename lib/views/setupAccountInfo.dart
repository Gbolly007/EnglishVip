import 'package:another_flushbar/flushbar.dart';
import 'package:english_vip/functions/authenticationFunction.dart';
import 'package:english_vip/routes/route_names.dart';
import 'package:english_vip/widgets/customTextField.dart';
import 'package:english_vip/widgets/loadingButtonWidget.dart';
import 'package:english_vip/widgets/regularTextWidget.dart';
import 'package:flutter/material.dart';

import '../constant.dart';

class SetupAccountInfo extends StatefulWidget {
  final String country;
  SetupAccountInfo({this.country});
  @override
  _SetupAccountInfoState createState() => _SetupAccountInfoState();
}

class _SetupAccountInfoState extends State<SetupAccountInfo> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  final TextEditingController _occupationTextEditingController =
      TextEditingController();
  final TextEditingController _descTextEditingController =
      TextEditingController();
  final AuthenticationFunction authenticationFunction =
      AuthenticationFunction();
  String dateSelected = "";
  String selectedGender = "";
  String selectedLevel = "";
  bool isLoading = false;

  final List<String> genderType = [
    selectonetext,
    maleText,
    femaleText,
  ];

  final List<String> level = [
    selectlevel,
    zeroText,
    beginnerText,
    intermediateText,
    advancedText,
    staticExamText
  ];

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(1900),
      lastDate: DateTime(selectedDate.year + 1),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        dateSelected =
            selectedDate.toLocal().toString().replaceAll("00:00:00.000", "");
      });
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
                    setupAccountInfo,
                    style: TextStyle(
                      fontSize: pageHeaderFontSize,
                      color: kAppColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Container(
                width: screenWidth,
                height: screenHeight,
                decoration: borderWidget,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            _selectDate(context);
                          },
                          child: ContainerWidget(
                            screenWidth: screenWidth,
                            txt: dateSelected.isEmpty ? dobText : dateSelected,
                            icn: Icons.calendar_today,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        DropdownButtonFormField(
                          validator: (val) =>
                              val.isEmpty ? validationLevel : null,
                          decoration: InputDecoration(
                            enabledBorder: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(15.0),
                              borderSide:
                                  BorderSide(color: kDarkBackgroundColor),
                            ),
                            focusedBorder: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(15.0),
                              borderSide:
                                  BorderSide(color: kDarkBackgroundColor),
                            ),
                          ),
                          value: genderType[0],
                          items: genderType.map((accountType) {
                            return DropdownMenuItem(
                              value: accountType,
                              child: Text(
                                accountType,
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (val) {
                            setState(() {
                              selectedGender = val;
                            });
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomTextField(
                          controller: _occupationTextEditingController,
                          hintText: occupationText,
                          isObscure: false,
                          func: (val) =>
                              val.isEmpty ? validationMsgEmail : null,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        DropdownButtonFormField<String>(
                          validator: (val) =>
                              val == null ? validationLevel : null,
                          decoration: InputDecoration(
                            enabledBorder: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(15.0),
                              borderSide:
                                  BorderSide(color: kDarkBackgroundColor),
                            ),
                            focusedBorder: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(15.0),
                              borderSide:
                                  BorderSide(color: kDarkBackgroundColor),
                            ),
                          ),
                          value: level[0],
                          items: level.map((accountType) {
                            return DropdownMenuItem(
                              value: accountType,
                              child: Text(
                                accountType,
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (val) {
                            setState(() {
                              selectedLevel = val;
                            });
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.multiline,
                          maxLength: 120,
                          controller: _descTextEditingController,
                          maxLines: 5,
                          style: TextStyle(fontSize: 15),
                          decoration: InputDecoration(
                            enabledBorder: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(15.0),
                              borderSide:
                                  BorderSide(color: kDarkBackgroundColor),
                            ),
                            focusedBorder: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(15.0),
                              borderSide:
                                  BorderSide(color: kDarkBackgroundColor),
                            ),
                          ),
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
                                      dynamic result =
                                          await authenticationFunction
                                              .setupAccountInfo(
                                                  selectedGender,
                                                  _occupationTextEditingController
                                                      .text,
                                                  selectedLevel,
                                                  selectedDate,
                                                  _descTextEditingController
                                                      .text);
                                      if (result.toString().length > 0) {
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
                                      } else {
                                        setState(() {
                                          isLoading = false;
                                        });
                                        Navigator.pushReplacementNamed(
                                            context, bottomNavRoute);
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

class ContainerWidget extends StatelessWidget {
  const ContainerWidget({
    Key key,
    @required this.screenWidth,
    @required this.txt,
    @required this.icn,
  }) : super(key: key);

  final double screenWidth;
  final String txt;
  final IconData icn;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: screenWidth,
      decoration: BoxDecoration(
        color: kBackgroundColor,
        border: Border.all(color: kDarkBackgroundColor),
        borderRadius: BorderRadius.all(
          Radius.circular(15.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              txt,
              style: TextStyle(
                fontSize: 15,
                color: kDarkBackgroundColor,
              ),
            ),
            Icon(
              icn,
              color: kDarkBackgroundColor,
            )
          ],
        ),
      ),
    );
  }
}
