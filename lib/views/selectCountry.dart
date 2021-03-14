import 'package:english_vip/data/countryData.dart';
import 'package:english_vip/models/country_model.dart';
import 'package:english_vip/routes/route_names.dart';
import 'package:english_vip/widgets/roundedButtonWidget.dart';
import 'package:flutter/material.dart';

import '../constant.dart';

class SelectCountry extends StatefulWidget {
  @override
  _SelectCountryState createState() => _SelectCountryState();
}

class _SelectCountryState extends State<SelectCountry> {
  List<CountryModel> country = new List();

  @override
  void initState() {
    // TODO: implement initState
    country = getCountry();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: screenWidth,
            child: Padding(
              padding: const EdgeInsets.only(top: 30.0, left: 20.0, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
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
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      shrinkWrap: true,
                      itemCount: country.length,
                      physics: ClampingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return CountryTile(
                          title: country[index].countryName,
                        );
                      },
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

class CountryTile extends StatelessWidget {
  final String title;

  CountryTile({@required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              setupAccountRoute,
              arguments: title,
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    color: kDarkBackgroundColor,
                  ),
                ),
              ),
              Divider(
                color: kDarkBackgroundColor,
              )
            ],
          )),
    );
  }
}
