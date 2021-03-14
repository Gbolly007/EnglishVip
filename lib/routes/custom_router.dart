import 'package:english_vip/routes/route_names.dart';
import 'package:english_vip/views/blankPage.dart';
import 'package:english_vip/views/bottomNavbar.dart';
import 'package:english_vip/views/changePassword.dart';
import 'package:english_vip/views/correctVideoDetails.dart';
import 'package:english_vip/views/editDesc.dart';
import 'package:english_vip/views/faceTest.dart';
import 'package:english_vip/views/failedVideoDetails.dart';
import 'package:english_vip/views/forgotPassword.dart';
import 'package:english_vip/views/homePage.dart';
import 'package:english_vip/views/loginScreen.dart';
import 'package:english_vip/views/onboardScreen.dart';
import 'package:english_vip/views/payWithCard.dart';
import 'package:english_vip/views/registerScreen.dart';
import 'package:english_vip/views/selectCountry.dart';
import 'package:english_vip/views/settings.dart';
import 'package:english_vip/views/setupAccountInfo.dart';
import 'package:english_vip/views/splashScreen.dart';
import 'package:english_vip/views/userProfile.dart';
import 'package:english_vip/views/videoDetails.dart';
import 'package:english_vip/views/viewLeaderboard.dart';
import 'package:flutter/material.dart';

class CustomRouter {
  static Route<dynamic> allRoutes(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case loginRoute:
        var data = settings.arguments as String;
        return MaterialPageRoute(builder: (_) => LoginScreen(data: data));
      case onboardRoute:
        return MaterialPageRoute(builder: (_) => OnboardScreen());
      case registerRoute:
        return MaterialPageRoute(builder: (_) => RegisterScreen());
      case forgotPasswordRoute:
        return MaterialPageRoute(builder: (_) => ForgotPassword());
      case setupAccountRoute:
        var data = settings.arguments as String;
        return MaterialPageRoute(
            builder: (_) => SetupAccountInfo(
                  country: data,
                ));
      case selectCountryRoute:
        return MaterialPageRoute(builder: (_) => SelectCountry());
      case changePasswordRoute:
        return MaterialPageRoute(builder: (_) => ChangePassword());
      case homePageRoute:
        return MaterialPageRoute(builder: (_) => HomePage());
      case bottomNavRoute:
        var data = settings.arguments as String;
        return MaterialPageRoute(
            builder: (_) => BottomNavbar(
                  data: data,
                ));
      case videoDetailsRoute:
        var datas = settings.arguments;
        return MaterialPageRoute(builder: (_) => VideoDetails(data: datas));
      case settingsRoute:
        return MaterialPageRoute(builder: (_) => SettingsScreen());
      case userProfileRoute:
        return MaterialPageRoute(builder: (_) => UserProfile());
      case faceTestRoute:
        var data = settings.arguments as String;
        return MaterialPageRoute(
            builder: (_) => FaceTest(
                  data: data,
                ));
      case blankRoute:
        var data = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => BlankPage(
                  data: data,
                ));
      case cvDetailsRoute:
        var datas = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => CorrectVideoDetails(
                  data: datas,
                ));
      case fvDetailsRoute:
        var datas = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => FailedVideoDetails(data: datas));
      case editDescRoute:
        var data = settings.arguments as String;
        return MaterialPageRoute(
            builder: (_) => EditDesc(
                  desc: data,
                ));
      case viewLeaderBoardRoute:
        return MaterialPageRoute(builder: (_) => ViewLeaderboard());
      case cardPaymentRoute:
        return MaterialPageRoute(builder: (_) => PayWithCard());
    }
  }
}
