import 'package:mymovieapp/enums/settingsenums.dart';

class MediaModel{
  String overview = "";
  String posterPath = "";
  String backDropPath = "";
  double rating = 0.0;

  void getImages(Map json) {
    this.posterPath = "https://d1nhio0ox7pgb.cloudfront.net/_img/o_collection_png/green_dark_grey/256x256/plain/movies.png";
    this.backDropPath = "https://d1nhio0ox7pgb.cloudfront.net/_img/o_collection_png/green_dark_grey/256x256/plain/movies.png";

    var poster_path = json["poster_path"];
    var backdrop_path = json["backdrop_path"];
    var voter_average = json["voter_average"];

    bool hasAverage = json.containsKey("voter_average");

    for (var item in json.keys) {
      if(item.toString() == "vote_average")
      {
        double parsedRating = json[item] + 0.0;
        

        this.rating = parsedRating > 0.0 ? parsedRating/2 : 0.0 ;
      }
    }

    if(poster_path != null)
    {
      this.posterPath = "https://image.tmdb.org/t/p/w" + Settings.searchImageWidth.toString() + poster_path;
    }

    if(backdrop_path != null)
    {
      this.backDropPath = "https://image.tmdb.org/t/p/w" + Settings.detailImageWidth.toString() + backdrop_path;
    }

    if(voter_average != null)
    {
      this.rating = double.parse(voter_average);
    }
  }
}
