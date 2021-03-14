import 'package:english_vip/routes/custom_router.dart';
import 'package:english_vip/routes/route_names.dart';
import 'package:english_vip/views/splashScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: FirebaseAuth.instance.authStateChanges(),
      lazy: false,
      child: MaterialApp(
        localizationsDelegates: [
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          Locale("ar", ""), // OR Locale('ar', 'AE') OR Other RTL locales
        ],
        locale: Locale("fa", ""),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: CustomRouter.allRoutes,
        initialRoute: homeRoute,
        home: SplashScreen(),
      ),
    );
  }
}
