import 'dart:convert';
import 'package:news_app/NewsView.dart';
import 'package:news_app/model/model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'; // for Response to work
import 'package:sizer/sizer.dart';
class World extends StatefulWidget { // for showing Entertainment Category in our App

  String Query; // query variable
  World({required this.Query}); // making Category constructor for taking query
  @override
  _WorldState createState() => _WorldState();
}
class _WorldState extends State<World> {

  List<NewsQueryModel> newsList = <NewsQueryModel>[]; //  for showing news in our app we make newsQueryModel list here

  bool isLoading = true;
  getNewsByQuery(String query) async {
    Map element; // for error handling passing element as map
    String url = "https://newsapi.org/v2/everything?q=world&sortBy=popularity%20and%20latest&apiKey=6e6c0f04acc04e59bf23aaea51c1fafa"; // for taking url according to query
    if(query == "Top News" || query == "India" || query == "World"){ // for showing news belong to this category section
      String url = // for showing top news using news API Url
          "https://newsapi.org/v2/top-headlines?country=in&apiKey=6e6c0f04acc04e59bf23aaea51c1fafa";
    }
    // async function is used for fetching data and passing it to model and receiving it also
    Response response = await get(
        Uri.parse(url)); // get method for fetching data and Uri to Pass Url
    Map data = jsonDecode(response.body); // response is received in Json format converting it in Map format Here
    setState(() {
      for(element in data["articles"]) { // articles is list of map where news is present , foreach for iterating and fetching elements(is Map where heading,desc,image is present) from each item
        try{   //# Handling error while Fetching data from API
          NewsQueryModel newsQueryModel = new NewsQueryModel();
          newsQueryModel = NewsQueryModel.fromMap(element); // here news query model is returned where news data is present
          newsList.add(newsQueryModel); // adding data in news model list
          setState(() {
            isLoading = false;
          });
        }catch(e){print(e);}; // for handling error while ,fetching data
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNewsByQuery(widget.Query); // by simply adding widget of query variable we show news here
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigoAccent[400],
        title: Text("Apna News",style: TextStyle(fontFamily: 'Merriweather Bold', fontWeight: FontWeight.w700,color:Colors.white ,fontSize: 15.sp)),

        leading: IconButton( // for back button in app
          icon: Icon(Icons.arrow_back, color: Colors.white,size: 30,),
          onPressed: () => Navigator.of(context).pop(),
        ),

      titleSpacing: 25,
      ) ,
      body: SingleChildScrollView( // for making it Scrollable
        child: Container(
          // creating Homepage for News App
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(15,25,0,0), // for giving margin to our headline after Scrollable View
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start, // for Showing latest news Headline in Start
                  children: [
                    SizedBox(width: 12,), // for Making heading text in top Beautiful
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 15),
                      child: Text(widget.Query,style: TextStyle( // for making headline Like Latest News in App, widget.query is used for showing text of particular category
                        fontWeight: FontWeight.bold,
                        fontSize: 17.sp,
                        color: Colors.black,
                        fontFamily: 'Oswald SemiBold',




                      ),),
                    ),
                  ],
                ),
              ), // Heading of News app before images Scrollable

              //### THIS isLoading will show Circular Progress indicator in Latest News Section
              isLoading ? Container(height: MediaQuery.of(context).size.height - 600,child: Center(child: CircularProgressIndicator(),),) :
              ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: newsList.length, // no of times items shown in our app
                  itemBuilder: (context, index) {
                    try{
                      // we use ListView builder to show more than one news in our App
                      return Container(
                          margin:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          child: InkWell( // FOR PERFORMING WORK ON TAPPING NEWS
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => NewsView(newsList[index].newsUrl) )); //## for showing news at particular index in News App at Latest News Section
                              },
                              child: Card(
                                // for making a Card widget to show news
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                elevation: 1.0, // for giving elevation to image
                                child: Stack(
                                  // for writing over images we use stack
                                  children: [
                                    ClipRRect(
                                      // for changing shape of image
                                        borderRadius: BorderRadius.circular(15),
                                        child: Image.network(newsList[index].newsImg , fit: BoxFit.fitHeight,height: 230,width: double.infinity,)),//for taking news img url from newModelList
                                    Positioned(
                                      // for positioning a widget we can use position to move anywhere in Stack
                                        left: 0,
                                        right: 0,
                                        bottom:0, // for moving text widget in downword position
                                        child: Container( // Using it to move up the News Headline Text
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(15),
                                                gradient: LinearGradient( // for giving gradient color to news headline
                                                    colors: [
                                                      Colors.black12.withOpacity(0),
                                                      Colors.black
                                                    ],
                                                    begin: Alignment.topCenter, // for showing color starting and ending position
                                                    end: Alignment.bottomCenter
                                                )
                                            ),
                                            padding: EdgeInsets.fromLTRB(15,15,10,8),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,// for moving it in start
                                              children: [
                                                Text(
                                                  newsList[index].newsHead, // for getting news heading using data
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18,
                                                      fontFamily:"Oswald SemiBold",
                                                      fontWeight: FontWeight.w700),
                                                ),
                                                // for displaying only 75 words in news app desc
                                                Text(newsList[index].newsDes.length > 50 ? "${newsList[index].newsDes.substring(0,55)}...." : newsList[index].newsDes, style: TextStyle(color: Colors.white ,fontSize: 14,fontFamily:"Oswald SemiBold",fontWeight: FontWeight.w700))
                                              ],
                                            )
                                        ))
                                  ],
                                ),
                              )));

                    }catch(e){print(e); return Container();} // for handling error while printing data form API
                  }),

            ],
          ),
        ),
      ),
    );
  }
}
