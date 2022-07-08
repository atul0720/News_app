import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:news_app/home.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'authentication_screens/login_screen.dart';

class Splash extends StatefulWidget { 
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() { // function which change state of widget when our class is called according to function in splash screen
    super.initState();
  //  _navigatetohome();
    Timer(
        Duration(seconds: 5),
           () => Navigator.push(
          context,
         MaterialPageRoute(builder: (context) => LoginScreen()), // for moving on to login screen
        ),
      );
  }
  
  // _navigatetohome() async { // async function for time
  //   await Future.delayed(Duration(milliseconds: 1000), () {}); // for delaying screen for 2.5 seconds
  //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home())); // for moving from splash screen to homepage
  // }

  @override
  Widget build(BuildContext context) {
    // return SplashScreen(
    //   seconds:10,
    //  navigateAfterSeconds: _navigatetohome(),
    //   title:  Text(
    //     'APNA NEWS',
    //     textScaleFactor: 3,
    //     style:TextStyle(
    //       fontFamily: "Merriweather-Black",
    //       fontWeight: FontWeight.w700,
    //       color: Colors.deepPurple.shade600
    //     )
    //   ),
    //   image:  Image.asset('images/logo2.png',alignment: Alignment.center,),
    //   loadingText: Text("Loading"),
    //   photoSize: 100.0,
    //   loaderColor: Colors.blue,
    // );

    return Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(color: Colors.blueAccent),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                   child: SizedBox(
                     height: 10.h, // for responsive change in height of square box
                     width: 10.h,
                     child: Image.asset(
                      "images/icon.png",
                      fit: BoxFit.cover,
                      color: Colors.white,
                  ),
                   ),
                ),
        Container(
          margin: EdgeInsets.fromLTRB(10, 30, 0, 0), // for padding to make Responsive
          alignment: Alignment.center,
          child: Text(
           'APNA NEWS',
          textScaleFactor: 1.7,
          style:TextStyle(
            fontFamily: "Merriweather-Black",
             fontWeight: FontWeight.w700,
            color: Colors.white
       )
       ),
        ),

                SizedBox(
                  height: 8.h,
                ),
                SpinKitWave(
                  type: SpinKitWaveType.start,
                  itemBuilder: (BuildContext context, int index) {
                    return DecoratedBox(
                      decoration: BoxDecoration(
                        color: index.isEven ? Colors.white : Colors.deepPurpleAccent,
                      ),
                    );
                  },
                ),

              ],
            ),
          ],
        ));
  }
}

