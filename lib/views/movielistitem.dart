
// Displays one Entry. If the entry has children then it's displayed
// with an ExpansionTile.
import 'package:flutter/widgets.dart';
import 'package:mymovieapp/models/mediamodel.dart';
import 'package:mymovieapp/models/moviemodel.dart';
import 'package:mymovieapp/models/tvmodel.dart';

class MovieListItem extends StatelessWidget {
  const MovieListItem(this.mediaItemModel);

  final MediaModel mediaItemModel;

  String getTitle()
  {
    return mediaItemModel is MovieModel ? (mediaItemModel as MovieModel).title 
    : (mediaItemModel as TVModel).name;
  }

  @override
  Widget build(BuildContext context) {
    return new Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        new Text(getTitle(), style: TextStyle(fontSize: 22.1,  fontWeight: FontWeight.bold), textAlign: TextAlign.start,),
        new Text(mediaItemModel.overview)
      ],
    );
  }
}