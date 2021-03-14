import 'package:another_flushbar/flushbar.dart';
import 'package:english_vip/functions/services.dart';
import 'package:english_vip/routes/route_names.dart';
import 'package:english_vip/widgets/headerWidget.dart';
import 'package:english_vip/widgets/loadingButtonWidget.dart';
import 'package:english_vip/widgets/regularTextWidget.dart';
import 'package:english_vip/widgets/roundedButtonWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:stripe_payment/stripe_payment.dart';

import '../constant.dart';

class PayWithCard extends StatefulWidget {
  @override
  _PayWithCardState createState() => _PayWithCardState();
}

class _PayWithCardState extends State<PayWithCard> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    StripeService.init();
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
                    headerText: paywithcard,
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
                  child: Column(
                    children: <Widget>[
                      CreditCardWidget(
                        cardBgColor: kDarkBackgroundColor,
                        cardNumber: cardNumber,
                        expiryDate: expiryDate,
                        cardHolderName: cardHolderName,
                        cvvCode: cvvCode,
                        showBackView:
                            isCvvFocused, //true when you want to show cvv(back) view
                      ),
                      CreditCardForm(
                        formKey: _formKey,
                        onCreditCardModelChange: (CreditCardModel data) {
                          setState(() {
                            cardNumber = data.cardNumber;
                            expiryDate = data.expiryDate;
                            cardHolderName = data.cardHolderName;
                            cvvCode = data.cvvCode;
                            isCvvFocused = data.isCvvFocused;
                          });
                        },
                      ),
                    ],
                  ),
                ),
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
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: InkWell(
                        onTap: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() {
                              isLoading = true;
                            });

                            int cvc = int.tryParse(cvvCode);
                            int carNo = int.tryParse(cardNumber.replaceAll(
                                RegExp(r"\s+\b|\b\s"), ""));
                            int exp_year =
                                int.tryParse(expiryDate.substring(3, 5));
                            int exp_month =
                                int.tryParse(expiryDate.substring(0, 2));

                            CreditCard stripeCard = CreditCard(
                                number: carNo.toString(),
                                expMonth: exp_month,
                                expYear: exp_year,
                                cvc: cvc.toString(),
                                name: cardHolderName);
                            var response =
                                await StripeService.payViaExistingCard(
                                    amount: '500',
                                    currency: 'USD',
                                    card: stripeCard);
                            if (response.success == true) {
                              setState(() {
                                isLoading = false;
                              });

                              Navigator.pushReplacementNamed(
                                  context, faceTestRoute,
                                  arguments: paymentSuccessul);
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
                                      duration: Duration(seconds: 8),
                                      margin: EdgeInsets.all(8),
                                      borderRadius: BorderRadius.circular(8),
                                      flushbarStyle: FlushbarStyle.FLOATING)
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
                                text: pay,
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
    );
  }
}
