import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:news_app/Category%20in%20News%20app/world_category.dart';
import 'package:news_app/home.dart';
import 'package:news_app/splashscreen.dart';
import 'package:news_app/authentication_screens/login_screen.dart';
import 'package:sizer/sizer.dart'; // for Responsiveness in flutter app

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // for firebase to use in app
  await Firebase.initializeApp();// for initializing firebase in app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      SizerUtil.deviceType == DeviceType.mobile
      ? Container(
        width: 100.w,
        height: 20.5.h,
      )
      : Container(
        width: 100.w,
        height: 12.5.h,
      );
    return MaterialApp(
      title: 'Apna News',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home:Splash() , // here spalsh() loginscreen()
    );
  },);
  }
}


