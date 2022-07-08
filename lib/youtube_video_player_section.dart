import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:news_app/home.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:sizer/sizer.dart';
class MyApp extends StatelessWidget {
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
      debugShowCheckedModeBanner: false,
      home: App(),
    );
    },);
  }
}

class App extends StatelessWidget {
  static String videoID = 'Cy_6-_XUW-c';
  static String videoID2 = "pTCfY8Tatjw";
  static String videoID3 = "Xk9mtCbY6OY";
  static String videoID4 = "911cntbvPBU";
  static String videoID5 = "5r8EcF8-iTA";
  static String videoID6 = "Xmm3Kr5P1Uw";
  static String videoID8 = "lyeyoqwXm5o";
  static String videoID7 = "aC650xB9NNc";
  static String videoID9 = "rvGcGpUO3gU";
  static String videoID10 = "0JK4ai4yAs4";
  YoutubePlayerController _controller2 = YoutubePlayerController( //making youtube video controller to control videos
    initialVideoId: videoID2, // for displaying video in flutter
    flags: YoutubePlayerFlags( // youtube controls for videos
        autoPlay: false,
        mute: false,
        isLive: true, // for live video
        controlsVisibleAtStart: true,

    ),
  );
  // YouTube Video Full URL : https://www.youtube.com/watch?v=dFKhWe2bBkM&feature=emb_title&ab_channel=BBKiVines
  YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: videoID,
    flags: YoutubePlayerFlags(
      autoPlay: false,
      mute: false,
      isLive: true,
      controlsVisibleAtStart: true,

    ),
  );
  YoutubePlayerController _controller3 = YoutubePlayerController( // for showing third news video
    initialVideoId: videoID3,
    flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        isLive: true,
        controlsVisibleAtStart: true
    ),
  );

  YoutubePlayerController _controller4 = YoutubePlayerController( // for showing third news video
    initialVideoId: videoID4,
    flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        isLive: true,
        controlsVisibleAtStart: true
    ),
  );

  YoutubePlayerController _controller5 = YoutubePlayerController( // for showing third news video
    initialVideoId: videoID5,
    flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        isLive: true,
        controlsVisibleAtStart: true
    ),
  );

  YoutubePlayerController _controller6 = YoutubePlayerController( // for showing third news video
    initialVideoId: videoID6,
    flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        isLive: true,
        controlsVisibleAtStart: true
    ),
  );

  YoutubePlayerController _controller7 = YoutubePlayerController( // for showing third news video
    initialVideoId: videoID7,
    flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        isLive: true,
        controlsVisibleAtStart: true
    ),
  );

  YoutubePlayerController _controller8 = YoutubePlayerController( // for showing third news video
    initialVideoId: videoID8,
    flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        isLive: true,
        controlsVisibleAtStart: true
    ),
  );

  YoutubePlayerController _controller9 = YoutubePlayerController( // for showing third news video
    initialVideoId: videoID9,
    flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        isLive: true,
        controlsVisibleAtStart: true
    ),
  );

  YoutubePlayerController _controller10 = YoutubePlayerController( // for showing third news video
    initialVideoId: videoID10,
    flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        isLive: true,
        controlsVisibleAtStart: true
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
        appBar: AppBar(
          shadowColor: Colors.indigoAccent,
          backgroundColor: Colors.deepPurpleAccent.shade400,
          title: Text(' Live News',style: TextStyle(fontSize: 18.sp,fontFamily: "Merriweather-BlackItalic" ,color: Colors.white,fontWeight: FontWeight.bold ),),

          leading: IconButton( // for back button in app
            icon: Icon(Icons.arrow_back, color: Colors.white,size: 22.sp,),
            onPressed: () => Navigator.push(context,MaterialPageRoute(builder: (context) => Home())),
          ),

          titleSpacing: 15, // for spacing of title
        ),


        body: SingleChildScrollView(
          child: Column(
            children: [  // for showing list of video
              Container(
                margin: EdgeInsets.fromLTRB(10, 20, 0, 0),
                child: Text("Aaj Tak News Live",style: TextStyle(fontSize: 16.sp,fontFamily: "Merriweather-BlackItalic" ,color: Colors.white,fontWeight: FontWeight.bold),),
                alignment: Alignment.topLeft,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 1.h, 0, 1.h),
                height: 30.h,
                width: 100.w,
                child: YoutubePlayer(
                  controller: _controller,
                  liveUIColor: Colors.blue.shade800,
                  showVideoProgressIndicator: false,
                  aspectRatio: 16/9,
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(10, 0.2.h, 0, 0.2.h),
                child: Text("Zee News Live",style: TextStyle(fontSize: 16.sp,fontFamily: "Merriweather-BlackItalic" ,color: Colors.white,fontWeight: FontWeight.bold),),
                alignment: Alignment.topLeft,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 1.h, 0, 1.h),
                height: 30.h,
                width: 100.w,
                child: YoutubePlayer(
                  controller: _controller2,
                  liveUIColor: Colors.blueAccent,
                  showVideoProgressIndicator: false,
                  aspectRatio: 16/9,
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(10, 0.2.h, 0, 0.2.h),
                child: Text("Abp News Live",style: TextStyle(fontSize: 16.sp,fontFamily: "Merriweather-BlackItalic" ,color: Colors.white,fontWeight: FontWeight.bold),),
                alignment: Alignment.topLeft,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 1.h, 0, 1.h),
                height: 30.h,
                width: 100.w,
                child: YoutubePlayer(
                  controller: _controller3,
                  liveUIColor: Colors.blueAccent,
                  showVideoProgressIndicator: false,
                  aspectRatio: 16/9,
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(10, 0.2.h, 0, 0.2.h),
                child: Text("Republic Bharat Live",style: TextStyle(fontSize: 16.sp,fontFamily: "Merriweather-BlackItalic" ,color: Colors.white,fontWeight: FontWeight.bold),),
                alignment: Alignment.topLeft,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 1.h, 0, 1.h),
                height: 30.h,
                width: 100.w,
                child: YoutubePlayer(
                  controller: _controller4,
                  liveUIColor: Colors.blueAccent,
                  showVideoProgressIndicator: false,
                  aspectRatio: 16/9,
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(10, 0.2.h, 0, 0.2.h),
                child: Text("Zee Hindustan Live",style: TextStyle(fontSize: 16.sp,fontFamily: "Merriweather-BlackItalic" ,color: Colors.white,fontWeight: FontWeight.bold),),
                alignment: Alignment.topLeft,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 1.h, 0, 1.h),
                height: 30.h,
                width: 100.w,
                child: YoutubePlayer(
                  controller: _controller5,
                  liveUIColor: Colors.blueAccent,
                  showVideoProgressIndicator: false,
                  aspectRatio: 16/9,
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(10, 0.2.h, 0, 0.2.h),
                child: Text("India Tv Live",style: TextStyle(fontSize: 16.sp,fontFamily: "Merriweather-BlackItalic" ,color: Colors.white,fontWeight: FontWeight.bold),),
                alignment: Alignment.topLeft,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 1.h, 0, 1.h),
                height: 30.h,
                width: 100.w,
                child: YoutubePlayer(
                  controller: _controller6,
                  liveUIColor: Colors.blueAccent,
                  showVideoProgressIndicator: false,
                  aspectRatio: 16/9,
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(10, 0.2.h, 0, 0.2.h),
                child: Text("News24 Live",style: TextStyle(fontSize: 16.sp,fontFamily: "Merriweather-BlackItalic" ,color: Colors.white,fontWeight: FontWeight.bold),),
                alignment: Alignment.topLeft,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 1.h, 0, 1.h),
                height: 30.h,
                width: 100.w,
                child: YoutubePlayer(
                  controller: _controller7,
                  liveUIColor: Colors.blueAccent,
                  showVideoProgressIndicator: false,
                  aspectRatio: 16/9,
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(10, 0.2.h, 0, 0.2.h),
                child: Text("TV9 Bharatvarsh Live",style: TextStyle(fontSize: 16.sp,fontFamily: "Merriweather-BlackItalic" ,color: Colors.white,fontWeight: FontWeight.bold),),
                alignment: Alignment.topLeft,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 1.h, 0, 1.h),
                height: 30.h,
                width: 100.w,
                child: YoutubePlayer(
                  controller: _controller9,
                  liveUIColor: Colors.blueAccent,
                  showVideoProgressIndicator: false,
                  aspectRatio: 16/9,
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(10, 0.2.h, 0, 0.2.h),
                child: Text("News18 India Live",style: TextStyle(fontSize: 16.sp,fontFamily: "Merriweather-BlackItalic" ,color: Colors.white,fontWeight: FontWeight.bold),),
                alignment: Alignment.topLeft,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 1.h, 0, 1.h),
                height: 30.h,
                width: 100.w,
                child: YoutubePlayer(
                  controller: _controller10,
                  liveUIColor: Colors.blueAccent,
                  showVideoProgressIndicator: false,
                  aspectRatio: 16/9,
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(10, 0.2.h, 0, 0.2.h),
                child: Text("India Today Live",style: TextStyle(fontSize: 16.sp,fontFamily: "Merriweather-BlackItalic" ,color: Colors.white,fontWeight: FontWeight.bold),),
                alignment: Alignment.topLeft,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 1.h, 0, 1.h),
                height: 30.h,
                width: 100.w,
                child: YoutubePlayer(
                  controller: _controller8,
                  liveUIColor: Colors.blueAccent,
                  showVideoProgressIndicator: false,
                  aspectRatio: 16/9,
                ),
              ),
            ],
          ),
        ));
  }
}