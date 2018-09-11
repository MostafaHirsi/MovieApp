import 'package:mymovieapp/enums/settingsenums.dart';
import 'package:mymovieapp/models/mediamodel.dart';

class MovieModel extends MediaModel{
  String title;

  MovieModel(){
    
  }

  MovieModel.fromJson(Map json){
    this.title = json["title"];
    this.overview = json ["overview"];
    
    this.posterPath = "https://image.tmdb.org/t/p/w" + Settings.searchImageWidth.toString() + json["poster_path"];
  }
}