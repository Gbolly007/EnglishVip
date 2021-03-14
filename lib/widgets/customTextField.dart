import 'package:english_vip/constant.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final IconData data;
  final String hintText;
  final Function func;
  bool isObscure = true;

  CustomTextField(
      {this.controller, this.data, this.hintText, this.isObscure, this.func});
  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isHidden = true;

  void toggleVisibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return !widget.isObscure
        ? TextFormField(
            style: TextStyle(
              color: kDarkBackgroundColor,
              fontSize: 15,
            ),
            keyboardType: widget.data == Icons.phone
                ? TextInputType.phone
                : TextInputType.emailAddress,
            controller: widget.controller,
            validator: widget.func,
            decoration: new InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderRadius: new BorderRadius.circular(15.0),
                borderSide: BorderSide(
                  color: kDarkBackgroundColor,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: new BorderRadius.circular(15.0),
                borderSide: BorderSide(color: kDarkBackgroundColor),
              ),
              hintText: widget.hintText,
              labelText: widget.hintText,
              errorBorder: OutlineInputBorder(
                borderRadius: new BorderRadius.circular(15.0),
                borderSide: BorderSide(color: Colors.red),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: new BorderRadius.circular(15.0),
                borderSide: BorderSide(color: kDarkBackgroundColor),
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
                  widget.data,
                  color: kAppColor,
                ),
              ),
            ),
          )
        : TextFormField(
            controller: widget.controller,
            obscureText: _isHidden,
            validator: widget.func,
            style: TextStyle(
              color: kDarkBackgroundColor,
              fontSize: 15,
            ),
            decoration: new InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderRadius: new BorderRadius.circular(15.0),
                borderSide: BorderSide(color: kDarkBackgroundColor),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: new BorderRadius.circular(15.0),
                borderSide: BorderSide(color: Colors.red),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: new BorderRadius.circular(15.0),
                borderSide: BorderSide(color: kDarkBackgroundColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: new BorderRadius.circular(15.0),
                borderSide: BorderSide(color: kDarkBackgroundColor),
              ),
              hintText: widget.hintText,
              labelText: widget.hintText,
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
                  widget.data,
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
          );
  }
}
