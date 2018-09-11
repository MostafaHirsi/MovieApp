import 'package:mymovieapp/enums/settingsenums.dart';
import 'package:mymovieapp/models/mediamodel.dart';

class TVModel extends MediaModel{
  String name;

  TVModel.fromJson(Map json){
    this.name = json["name"];
    this.overview = json ["overview"];
    this.posterPath = "https://image.tmdb.org/t/p/w$Settings.searchImageWidth" + json["poster_path"];
  }
}