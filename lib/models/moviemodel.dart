import 'package:mymovieapp/models/mediamodel.dart';

class MovieModel extends MediaModel{
  String title;

  MovieModel.fromJson(Map json){
    this.title = json["title"];
    this.overview = json ["overview"];
  }
}