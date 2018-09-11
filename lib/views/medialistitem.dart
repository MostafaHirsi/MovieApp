
// Displays one Entry. If the entry has children then it's displayed
// with an ExpansionTile.
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mymovieapp/models/mediamodel.dart';
import 'package:mymovieapp/models/moviemodel.dart';
import 'package:mymovieapp/models/tvmodel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:mymovieapp/views/mediadetails.dart';

class MediaListItem extends StatelessWidget {
  const MediaListItem(this.mediaItemModel);

  final MediaModel mediaItemModel;

  String getTitle()
  {
    return mediaItemModel is MovieModel ? (mediaItemModel as MovieModel)?.title ?? ""
    : (mediaItemModel as TVModel)?.name ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return
    new GestureDetector(
      onTap: () {
    Navigator.push(context, 
              MaterialPageRoute(builder: (context) => MediaDetailPage(mediaItemModel)),);},
      child: new Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            new CachedNetworkImage(
              imageUrl: mediaItemModel?.posterPath ,
              placeholder: new CircularProgressIndicator(),
              errorWidget: new Icon(Icons.movie, color: Colors.black,),
              width: 64.0,
            ),
            new Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Container(
                    padding: EdgeInsets.all(8.0),
                    width: MediaQuery.of(context).size.width*0.8,
                    child: new Text(getTitle(), style: TextStyle(fontSize: 22.1,  fontWeight: FontWeight.bold),
                          maxLines: 2, overflow: TextOverflow.ellipsis, softWrap: true,),
                  ),
                  new Container(
                    padding: EdgeInsets.all(8.0),
                    width: MediaQuery.of(context).size.width*0.8,
                    child: new Text(mediaItemModel?.overview ?? "",
                          maxLines: 2, overflow: TextOverflow.ellipsis, softWrap: true,),
                  )
                ],
            ),
          ],
        )
      ),);
  }
}