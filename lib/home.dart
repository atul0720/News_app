import 'dart:convert';
import 'dart:math';
import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' as cg; // rename foundation as cg
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:news_app/NewsView.dart';
import 'package:news_app/authentication_screens/login_screen.dart';
import 'package:news_app/home.dart';
import 'package:news_app/model/model.dart';
import 'package:news_app/Category in News app/category.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:flushbar/flushbar.dart';
import 'package:news_app/Category in News app/Entertainment.dart'; // for using Entertainment category here
import 'package:news_app/Category in News app/Business_news.dart';
import 'package:news_app/Category in News app/world_category.dart';
import 'package:news_app/Category in News app/Health_category.dart';
import 'package:news_app/Category in News app/Sports_category.dart';
import 'package:news_app/Category in News app/Stocks_category.dart';
import 'package:news_app/Category in News app/CryptoCurrency.dart';
import 'package:news_app/Category in News app/Technology_category.dart';
import 'package:news_app/Category in News app/Science_category.dart';
import 'package:news_app/Category in News app/Food_category.dart';
import 'package:news_app/Category in News app/Travel_category.dart';
import 'package:news_app/Category in News app/Weather_category.dart';
import 'package:news_app/webview%20of%20news.dart';
import 'package:news_app/youtube_video_player_section.dart';
import 'package:sizer/sizer.dart';
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {


  TextEditingController SearchController = new TextEditingController(); // for Controlling Search Bar
  List<NewsQueryModel> newsList = <
      NewsQueryModel>[]; //  for showing news in our app we make newsQueryModel list here
  List<NewsQueryModel> newsModelListCarousel =
  <NewsQueryModel>[]; // for showing new in carousel slider
  List<String> navBarItem = [
    "Top News",
    "India",
    "World",
    "Entertainment",
    "Finance",
    "Health",
    "Technology",
    "Sports",
    "Stock",
    "CryptoCurrency",
    "Business",
    "Science",
    "Food",
    "Travel",
    "Weather"
  ]; // for horizontal category wise Scrollable List

  // FOR SHOWING NEWS AND FETCHING DATA FROM NEWS API
  bool isLoading = true;


  getNewsHindi(String query) async {
    //# (best and fast method to retrive data from database section or API takes LESS LOad and Memory) 1st Method to Slicing NEWS SECTION and SHOW ONLY 6 NEWS IN LATEST NEWS SECTION
    Map element; // Local Map variable to pass data  in for LOOP
   int i = 0; // for iterating in DATA USING  FOR LOOP
    // async function is used for fetching data and passing it to model and receiving it also
    String url = // for showing news using news API Url
        "https://newsapi.org/v2/everything?q=aajtak&sortBy=publishedAt&apiKey=6e6c0f04acc04e59bf23aaea51c1fafa"; // making function with name getNewsByQuery to show news in our app
    Response response = await get(
        Uri.parse(url)); // get method for fetching data and Uri to Pass Url
    Map data = jsonDecode(response
        .body); // response is received in Json format converting it in Map format Here
    setState(() {
      for (element in data["articles"]) {
        // articles is list of map where news is present , foreach for iterating and fetching elements(is Map where heading,desc,image is present) from each item
        try {
          // THIS IS USED TO HANDLE ERROR IN APPLICATION
         i++; // for moving in next data article section
          NewsQueryModel newsQueryModel = new NewsQueryModel();
          newsQueryModel = NewsQueryModel.fromMap(
              element); // here news query model is returned where news data is present
          newsList.add(newsQueryModel); // adding data in news model list
          setState(() {
            isLoading = false;
          });

          if (i == 10) {
            // for showing only 6 NEWS IN LATEST NEWS SECTION
            break;
          }
        } catch (e) {
          // for catching error THIS IS PART OF ERROR HANDLING
          print(e);
        };
        // newsList.sublist(0,6);
        //2nd Method(IT takes memory and time to laod news) THIS IS USE FOR SLICING NEWS LIST TO 6 NEWS IN LATEST NEWS SECTION
      }
    });
  }
  // for showing news in Carousel Slider

  getNewsofIndia(String provider) async {
    Map element;
    // async function is used for fetching data and passing it to model and receiving it also
    String url = // for showing news using news API Url
        "https://newsapi.org/v2/top-headlines?country=in&apiKey=6e6c0f04acc04e59bf23aaea51c1fafa"; // making function with name getNewsByQuery to show news in our app
    Response response = await get(
        Uri.parse(url)); // get method for fetching data and Uri to Pass Url
    Map data = jsonDecode(response
        .body); // response is received in Json format converting it in Map format Here
    setState(() {
      for (element in data["articles"]) {
        // articles is list of map where news is present , foreach for iterating and fetching elements(is Map where heading,desc,image is present) from each item
        try {
          NewsQueryModel newsQueryModel = new NewsQueryModel();
          newsQueryModel = NewsQueryModel.fromMap(
              element); // here news query model is returned where news data is present
          newsModelListCarousel
              .add(newsQueryModel); // adding data in news model list
          setState(() {
            isLoading = false;
          });
        } catch (e) {
          // for Handling error in news APP Fetching data from API SECTION
          print(e);
        };

      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNewsHindi("india.in"); // for showing news in our app
    getNewsofIndia("aaj tak.in");
  }

  @override
  Widget build(BuildContext context) {
    var newstype = [
      "Cricket News",
      "Bollywood News ",
      "Election News",
      "State News",
      "Foreign News",
      "World News",
      "Technology news",
      "Food News"
    ];
    final _random = new Random();
    var news = newstype[_random.nextInt(newstype.length)]; // for selecting random news and store it in news variable
    return Scaffold(

      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent.shade400,
          brightness: Brightness.dark, // for light icons
        title: Row(
          children: [
            Expanded(
              child: Text(
              "Apna News",
              style: TextStyle(
                  fontFamily: 'RobotoCondensed Bold',
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  fontSize: 10.sp),

          ),

            ),

        ],
        ),

    titleSpacing: 3, // for spacing o title
      //  centerTitle: true, // for center of title
          actions: [ // for icons in app bar

            Container( // for making google button in  app bar
             margin: EdgeInsets.all(5),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.pinkAccent.shade700,
                  onPrimary: Colors.white,
                  shadowColor: Colors.blueAccent.shade700,
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0)),
                  minimumSize: Size(100, 40),
                ),
                onPressed:(){
                Navigator.push(context, MaterialPageRoute(builder: (context) => webView()));
                },

                child: Text('Search News',style: TextStyle(fontSize: 12.sp,fontFamily: "Merriweather-BlackItalic" ,color: Colors.white,fontWeight: FontWeight.bold),),

              ),
            ),
            Container( // for making youtube button in  app bar
              margin: EdgeInsets.all(5),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.pinkAccent.shade700,
                  onPrimary: Colors.white,
                  shadowColor: Colors.blueAccent.shade700,
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0)),
                  minimumSize: Size(100, 40),
                ),
                onPressed:() {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp() ));
                  },
                child: Text('News Live',style: TextStyle(fontSize: 12.sp,fontFamily: "Merriweather-BlackItalic" ,color: Colors.white,fontWeight: FontWeight.bold),),


              ),
            ),
            //more widgets to place here
          ],


// for setting image in app bar
     leading: Padding(
       padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
       child: Image.asset(
      "images/icon.png",
       fit: BoxFit.cover,
         color: Colors.white,
       ),


// leading: IconButton( // for back button in app
        //   icon: Icon(Icons.arrow_back, color: Colors.black,size: 30,),
        //   onPressed: () => Navigator.of(context).pop(),
        //  ),
    ),

      ),
      body: SingleChildScrollView(
        // for making image Scrollable
        child: Column(
          // for showing fields in vertical format
          children: [
            Container(
              // search container
              padding: EdgeInsets.symmetric(
                  horizontal: 2.h), // for padding to search bar
              margin: EdgeInsets.symmetric(
                  horizontal: 2.h,
                  vertical:
                  2.h), // margin from other container in horizontally and vertically
              decoration: BoxDecoration(
                // for decorating search bar container
                  color: Colors.lightBlue.shade400, // for color of search bar
                  borderRadius: BorderRadius.circular(
                      24) // for giving round edges to search bar
              ),
              child: Row(
                children: [
                  GestureDetector(
                    // gesture detector helps to detect what user is doing in search
                    onTap: () {

                      //# HERE WE GET SEARCHING QUERY RELATED NEWS
                      if ((SearchController.text).replaceAll(" ", "") == "") {
                        print("Blank search");
                      } else {
                        // THIS IS FOR PASSING SEARCH CONTROLLER TEXT TO SHOW NEWS RELATED TO THIS CATEGORY

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Category(Query: SearchController.text)));
                      }
                    }, // for running this function on tapping
                    child: Container(
                      child: Icon(Icons.search),
                      margin: EdgeInsets.fromLTRB(3, 0, 7, 0),
                    ), // for showing  this search icon in child
                  ), // for searching through search icon
                  Expanded(
                    child: TextField(
                      // for giving different properties.it must be in expanded widget(so that user can type more text
                      controller: SearchController,
                      textInputAction: TextInputAction
                          .search, // for having search icon in keyboard
                      onSubmitted: (value) {
                        if(value == ""){ //## FOR RESTRICTED SEARCH TO BLANK SPACE WHEN NO DATA IS GIVEN
                          print("BLANK SEARCH");
                        } else if((SearchController.text) == 'Entertainment'|| (SearchController.text) == 'entertainment'|| (SearchController.text) == 'entert'  ){ // for navigating on to Entertainment section when search entertainment

                        Navigator.push(
                        context,
                        MaterialPageRoute(
                        builder: (context) => Entertainment(Query: SearchController.text)));

                        }else if((SearchController.text) == 'Business' || (SearchController.text) == 'Finance'|| (SearchController.text) == 'finance' || (SearchController.text) == 'business' ){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Business(Query: SearchController.text)));
                        }else if((SearchController.text) == 'World' || (SearchController.text) == 'world'){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => World(Query: SearchController.text)));
                        }else if((SearchController.text) == 'Health' || (SearchController.text) == 'health'){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Health(Query: SearchController.text)));
                        }else if((SearchController.text) == 'Technology' || (SearchController.text) == 'technology' || (SearchController.text) == 'tech'){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Technology(Query: SearchController.text)));
                        }else if((SearchController.text) == 'Sports' || (SearchController.text) == 'sports'){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Sports(Query: SearchController.text)));
                        }else if((SearchController.text) == 'Stock' || (SearchController.text) == 'stock'){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Stocks(Query: SearchController.text)));
                        }else if((SearchController.text) == 'CryptoCurrency' || (SearchController.text) == 'cryptocurrency' || (SearchController.text) == 'Crypto' || (SearchController.text) == 'crypto'){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CryptoCurrency(Query: SearchController.text)));
                        }else if((SearchController.text) == 'Science' || (SearchController.text) == 'science' ){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Science(Query: SearchController.text)));
                        }else if((SearchController.text) == 'Food' || (SearchController.text) == 'food'){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Food(Query: SearchController.text)));
                        }else if((SearchController.text) == 'Travel' || (SearchController.text) == 'travel'){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Travel(Query: SearchController.text)));
                        }else if((SearchController.text) == 'Weather' || (SearchController.text) == 'weather' || (SearchController.text) == 'india weather'){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Weather(Query: SearchController.text)));
                        }
                        else { //## FOR  SEARCHING DATA IN NEWS APP
                          // function to perform action on search bar

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Category(Query: value)));
                        }
                      },
                      decoration: InputDecoration(
                        // for decorating the text field
                          hintText: "Search News Like $news",
                          border: InputBorder.none),
                    ),
                  )
                ],
              ), // for creating search bar (in row format)
            ),

            Container(
              // Horizontal navigation bar Container
              height: 6.h,
              child: ListView.builder(
                  shrinkWrap: true, // always true in column
                  scrollDirection: Axis
                      .horizontal, // for making ListView Scrollable in horizontal direction
                  itemCount: navBarItem
                      .length, // for making list View upto navBar Length
                  itemBuilder: (context, index) {
                    // For navigation from Homepage to CATEGORY SECTION
                    return InkWell(
                      //Widget which perform action on tapping
                      onTap: () {
                        //# This is For navigation from Homepage to different category section using Category.dart
                        if(navBarItem[index] == 'Entertainment'){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Entertainment(
                                    Query: navBarItem[index],
                                  )));
                          ShowNotificationForCategory(context,navBarItem[index]);
                        }else if(navBarItem[index] == 'Business' || (navBarItem[index]) == 'Finance'){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Business(Query: navBarItem[index])));
                        }else if(navBarItem[index] == 'World' ){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => World(Query: navBarItem[index])));
                        }else if(navBarItem[index] == 'Health' ){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Health(Query: navBarItem[index])));
                        }else if(navBarItem[index] == 'Technology' ){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Technology(Query: navBarItem[index])));
                        }else if(navBarItem[index] == 'Sports' ){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Sports(Query: navBarItem[index])));
                        }else if(navBarItem[index] == 'Stock' ){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Stocks(Query: navBarItem[index])));
                        }else if(navBarItem[index] == 'CryptoCurrency' ){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CryptoCurrency(Query: navBarItem[index])));
                        }else if(navBarItem[index] == 'Science' ){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Science(Query: navBarItem[index])));
                        }else if(navBarItem[index] == 'Food' ){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Food(Query: navBarItem[index])));
                        }else if(navBarItem[index] == 'Travel' ){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Travel(Query: navBarItem[index])));
                        }else if(navBarItem[index] == 'Weather' ){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Weather(Query: navBarItem[index])));
                        }
                        else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Category(
                                        Query: navBarItem[index],
                                      )));
                          ShowNotificationForCategory(context,
                              navBarItem[index]); // for showing flushbar in category section

                        }

                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10), // for padding to ListView
                        margin: EdgeInsets.symmetric(horizontal: 1.h),
                        decoration: BoxDecoration(
                            color:
                            Colors.lightBlue.shade300, // for giving Container color
                            borderRadius: BorderRadius.circular(15)),
                        child: Center(
                          // for having text in navBar in Center
                          child: Text(
                            navBarItem[index],
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.pink[500],
                              fontFamily: 'Merriweather BoldItalic',
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ), // for making ListView Builder
                      ),
                    );
                  }),
            ),

            //### create SlidesShow in Flutter (AutoScroll + User Controllable + Animation)
            //### for this we need to import Carousel Slider in pubspec.yaml folder

            Container(
              margin: EdgeInsets.symmetric(
                  vertical: 2.h), // for giving margin to Scrollable Slider
              // ## FOR SHOWING CIRCULAR PROGRESS INDICATOR IN OUR APP
              child: isLoading
                  ? Container(
                  height: 15.h,
                  child: Center(child: CircularProgressIndicator()))
                  : CarouselSlider(
                // for making Circular Progress Indicator(Circular Progress Indicator is Shown when APP Is Laoding, when App is Not Loading it will show Carousel Slider items)
                //## Circular Progress Indicator is put in Center to Show Loading Screen in Center
                options: CarouselOptions(
                  height: 27.h,
                  autoPlay: true, // for making Slider Auto Scrollable
                  enableInfiniteScroll:
                  true, // for not making it infinite Scrollable
                  aspectRatio: 16 /9 ,
                  enlargeCenterPage:
                  true, // for having center item enlarge
                ),
                items: newsModelListCarousel.map((instance) {
                  return Builder(builder: (BuildContext context) {
                    try {
                      // THIS IS FOR HANDLING PRINTING NEWS ERROR OR RELATED ERROR
                      return Container(
                        child: InkWell( // for performing any work when clicked we use InkWell
                          onTap: (){
                            //## for moving on url when Clicked
                            Navigator.push(context,MaterialPageRoute(builder:(context) => NewsView(instance.newsUrl)));
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                              // for changing shape of Card and make it Circular Edges
                                borderRadius: BorderRadius.circular(10)),
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    instance.newsImg,
                                    fit: BoxFit.fill,
                                    loadingBuilder: (BuildContext context, Widget child,
                                        ImageChunkEvent? loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return Center(
                                        child: CircularProgressIndicator(
                                          value: loadingProgress.expectedTotalBytes != null
                                              ? loadingProgress.cumulativeBytesLoaded /
                                              loadingProgress.expectedTotalBytes!
                                              : null,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                Positioned(
                                    left: 0,
                                    right: 0,
                                    bottom: 0,
                                    child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                                10), // for making bottom edges in round shape of card
                                            gradient: LinearGradient(
                                              // for giving Color Linear Gradient list
                                                colors: [
                                                  Colors.black12
                                                      .withOpacity(0),
                                                  Colors.black
                                                ],
                                                begin: Alignment
                                                    .topCenter, // starting and ending position of linear gradient alignment
                                                end: Alignment
                                                    .bottomCenter)),
                                        child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 1.w,
                                                vertical:
                                                1.h), // for giving padding to news headline
                                            child: Container(
                                                margin:
                                                EdgeInsets.symmetric(
                                                    horizontal: 1.w,
                                                    vertical: 2.h),
                                                child: Text(
                                                  instance.newsHead,
                                                  style: TextStyle(
                                                      fontSize: 15.sp,
                                                      color: Colors.white,
                                                      fontWeight:
                                                      FontWeight.bold),
                                                ))) // FOR Headline text in Scrollable View

                                    ))
                              ],
                            ),
                          ),
                        ),
                      );
                    } catch (e) {
                      print(e);
                      return Container();
                    }
                  }); // for making Slider in News App
                }).toList(), // for Converting it in List Format
              ), // for showing Loading indicator when App is Loading
            ),

            // HOMEPAGE FOR NEWS APP
            Container(
              // creating Homepage for News App
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(15, 25, 0,
                        0), // for giving margin to our headline after Scrollable View
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment
                          .start, // for Showing latest news Headline in Start
                      children: [
                        Text(
                          "Latest News ",
                          style: TextStyle(
                            // for making headline Like Latest News in App
                            fontWeight: FontWeight.w500,
                            fontSize: 20.sp,
                            color: Colors.black,
                            fontFamily: 'Oswald Bold',
                          ),
                        ),
                      ],
                    ),
                  ), // Heading of News app before images Scrollable

                  //## Latest news Section

                  //### THIS isLoading will show Circular Progress indicator in Latest News Section
                  isLoading
                      ? Container(
                    height: MediaQuery.of(context).size.height - 550,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                      : ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: newsList
                          .length, // no of times items shown in our app
                      itemBuilder: (context, index) {
                        try{ // for handling LATEST NEWS SECTION ERROR
                          // we use ListView builder to show more than one news in our App
                          return Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 3.w, vertical: 1.h),
                              child: InkWell( // FOR PERFORMING WORK ON TAPPING NEWS
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => NewsView(newsList[index].newsUrl) )); //## for showing news at particular index in News App at Latest News Section
                                },
                                child: Card(
                                  // for making a Card widget to show news
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  elevation:
                                  1.0, // for giving elevation to image
                                  child: Stack(
                                    // for writing over images we use stack
                                    children: [
                                      ClipRRect(
                                        // for changing shape of image
                                          borderRadius:
                                          BorderRadius.circular(15),
                                          child: Image.network(
                                            newsList[index].newsImg,
                                            fit: BoxFit.fill,
                                            height: 28.5.h,
                                            width: double.infinity,
                                          )), //for taking news img url from newModelList
                                      Positioned(
                                        // for positioning a widget we can use position to move anywhere in Stack
                                          left: 0,
                                          right: 0,
                                          bottom:
                                          0, // for moving text widget in downword position
                                          child: Container(
                                            // Using it to move up the News Headline Text
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(15),
                                                  gradient: LinearGradient(
                                                    // for giving gradient color to news headline
                                                      colors: [
                                                        Colors.black12
                                                            .withOpacity(0),
                                                        Colors.black
                                                      ],
                                                      begin: Alignment
                                                          .topCenter, // for showing color starting and ending position
                                                      end: Alignment
                                                          .bottomCenter)),
                                              padding: EdgeInsets.fromLTRB(
                                                  15, 15, 10, 8),
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .start, // for moving it in start
                                                children: [
                                                  Text(
                                                    newsList[index]
                                                        .newsHead, // for getting news heading using data
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 18.sp,
                                                        fontFamily:
                                                        "Oswald SemiBold",
                                                        fontWeight:
                                                        FontWeight.w700),
                                                  ),
                                                  // for displaying only 75 words in news app desc
                                                  Text(
                                                      newsList[index]
                                                          .newsDes
                                                          .length >
                                                          50
                                                          ? "${newsList[index].newsDes.substring(0, 55)}...."
                                                          : newsList[index]
                                                          .newsDes,
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 12.sp,
                                                          fontFamily:
                                                          "Oswald SemiBold",
                                                          fontWeight:
                                                          FontWeight.w700))
                                                ],
                                              )))
                                    ],
                                  ),
                                ),
                              )
                          );
                        }catch(e){print(e); return Container();} // for handling list Builder error
                      }),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 5.h, 0, 2.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center, // for moving button in center
                      children: [

                        //### for making Show More Button working and will show more news of Technology related
                        Padding(
                          padding: const EdgeInsets.fromLTRB(4, 2, 20, 10),
                          child: SizedBox(
                            height: 40,
                            width: 140,
                            child: ElevatedButton(

                                style: ElevatedButton.styleFrom(
                                  primary: Colors.deepPurpleAccent.shade400, // background
                                  onPrimary: Colors.white, // foreground
                                  elevation: 0,
                                ),
                                onPressed: () {

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Category(Query: " Entertainment")));
                                  moveToCategoryAndShowNotification(context); // for showing notification using flushbar
                                },
                                child: Text(
                                    "Show More",style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w500,color: Colors.white),textAlign: TextAlign.center,)),
                          ),
                        ), // FOR MAKING ELEVATED BUTTON
                        SizedBox(
                          height: 55,

                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(20, 2, 20, 10),
                            child: SizedBox(
                              height: 40,
                              width: 140,
                              child: ElevatedButton(

                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.deepPurpleAccent.shade400, // background
                                    onPrimary: Colors.white, // foreground
                                    elevation: 0,
                                  ),
                                  onPressed: () {
                                    print("User Sign Out");
                                    Authentication.signOut(context: context);
                                    showDialog(context: context, builder: (context){ // for Dialog Box to Appear on screen
                                      return Container(
                                        height: 4.h,
                                        width: 10.w,
                                        child: AlertDialog( // for showing alert dialog
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          title: Text("Are You Sure? You Want to Exit ",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 15.sp,),),

                                          actions: [
                                            TextButton(
                                              onPressed: (){
                                                Navigator.pop(context);
                                              } ,
                                              child: Text("NO",style: TextStyle(fontSize: 13.sp,fontWeight: FontWeight.bold),),
                                            ),
                                            TextButton(
                                              onPressed: (){
                                                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                                              } ,
                                              child: Text("Yes",style: TextStyle(fontSize: 13.sp,fontWeight: FontWeight.bold),),
                                            )
                                          ], // for doing actions according to situation
                                        ),

                                      );
                                    });


                                  },
                                  child: Text(
                                    "Logout",style: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w500,color: Colors.white),textAlign: TextAlign.center,)),
                            ),
                          ),
                        ), // FOR MAKING ELEVATED BUTTON
                ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

// This is used in Starting for making Carousel slider Preview before displaying news in this section
// final List items = [
//   Colors.blueAccent,
//   Colors.orange,
//   Colors.red,
//   Colors.green,
//   Colors.purple,
//   Colors.pink
// ]; // for Slider List Items
}

class Authentication {
  static Future<void> signOut({required BuildContext context}) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn();
    try {
      if (!cg.kIsWeb) {
        await googleSignIn.signOut();
        await _auth.signOut();
      }
      await FirebaseAuth.instance.signOut();
    }catch(e){
      Fluttertoast.showToast(msg: "Error signing out. Try again. ",fontSize: 13.sp,backgroundColor: Colors.pinkAccent[400]);
    }
    }
  }

void moveToCategoryAndShowNotification(BuildContext context) { // flushbar for show more button section
  Flushbar(
    flushbarPosition: FlushbarPosition.TOP, // for chnaging position of flush bar
    duration: Duration(seconds: 10),
    margin: EdgeInsets.all(8),
    padding: EdgeInsets.all(2.h),

    backgroundGradient: LinearGradient(
      colors: [
        Colors.purple.shade900,
        Colors.purple.shade700,
        Colors.purple.shade500
      ],
      stops: [0.4, 0.7, 1],
    ),
    boxShadows: [
      BoxShadow(
        color: Colors.black45,
        offset: Offset(3, 3),
        blurRadius: 3,
      ),
    ],
    dismissDirection: FlushbarDismissDirection.HORIZONTAL,
    forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
    title: 'More News',
    message: 'Showing more news in This News App.Help you to increase your Knowledge about world.',
  ).show(context);
}

void ShowNotificationForCategory(BuildContext context, String Query) { // flushbar for category section
  Flushbar(
    flushbarPosition: FlushbarPosition.TOP, // for chnaging position of flush bar
    duration: Duration(seconds: 2),
    margin: EdgeInsets.all(8),
    padding: EdgeInsets.all(10),

    backgroundGradient: LinearGradient(
      colors: [
        Colors.blue.shade900,
        Colors.blue.shade700,
        Colors.blue.shade500
      ],
      stops: [0.4, 0.7, 1],
    ),
    boxShadows: [
      BoxShadow(
        color: Colors.black45,
        offset: Offset(3, 3),
        blurRadius: 3,
      ),
    ],
    dismissDirection: FlushbarDismissDirection.HORIZONTAL,
    forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
    title: 'Category: ' + (Query),
    message: 'Showing latest news about ' + (Query)  ,
  ).show(context);
}

// sign out from google authentication



 // _launchURLApp2() async { // for youtube url button in app bar
 //   const url = 'https://www.aajtak.in/livetv?utm_source=homepage&utm_campaing=hp_page_banner';
 //   if (await canLaunch(url)) {
 //     await launch(url, forceSafariVC: true, forceWebView: true);
 //   } else {
 //     throw 'Could not launch $url';
 //   }
 // }
