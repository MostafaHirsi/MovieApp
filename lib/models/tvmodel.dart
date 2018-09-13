import 'package:mymovieapp/enums/settingsenums.dart';
import 'package:mymovieapp/models/mediamodel.dart';

class TVModel extends MediaModel{
  String name;

  TVModel.fromJson(Map json){
    this.name = json["name"];
    this.overview = json ["overview"];
    getImages(json);
  }

  
}