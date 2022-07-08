class NewsQueryModel // for showing news in our app using NEWS API
    {
  late String newsHead; // for news heading
  late String newsDes;  // for news Desc
  late String newsImg;  // for news img
  late String newsUrl;  // for newsUrl

  // Cnstructor for defining variables in our app
  NewsQueryModel({ this.newsHead = "NEWS HEADLINE" , this.newsDes = "SOME NEWS", this.newsImg = "SOME URL", this.newsUrl = "SOME URL"});

  factory NewsQueryModel.fromMap(Map news) //we made NewsQueryModel object so that any one make its object would pass a Map first
  {
    return NewsQueryModel( // we return instance of a class here
        newsHead: news["title"],
        newsDes: news["description"],
        newsImg: news["urlToImage"],
        newsUrl: news["url"]
    );
  }
}