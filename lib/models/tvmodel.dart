import 'package:mymovieapp/models/mediamodel.dart';

class TVModel extends MediaModel{
  String name;

  TVModel.fromJson(Map json){
    this.name = json["name"];
    this.overview = json ["overview"];
  }
}