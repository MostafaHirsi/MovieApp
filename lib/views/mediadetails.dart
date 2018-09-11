
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mymovieapp/models/mediamodel.dart';

class MediaDetailPage extends StatefulWidget {
  MediaModel mediaItemModel;

  MediaDetailPage(MediaModel mediaItemModel){
    this.mediaItemModel = mediaItemModel;
  }

  @override
  State<StatefulWidget> createState() => new _MediaDetailsPageState(mediaItemModel);
  
}
  
class _MediaDetailsPageState extends State<MediaDetailPage>  {
  MediaModel mediaItemModel;

  _MediaDetailsPageState(MediaModel mediaItemModel){
    this.mediaItemModel = mediaItemModel;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: new Text("Search Films/Shows"),
      ),
      body: new Center(
        heightFactor: 1.5,
        child: new Column(
          children: <Widget>[
            new CachedNetworkImage(
                imageUrl: mediaItemModel.posterPath,
                placeholder: new CircularProgressIndicator(),
                errorWidget: new Icon(Icons.movie, color: Colors.black,),
                fit: BoxFit.fill,
                width: 410.0,
                height: 600.0,
              )
          ],
        ),
      )
    );
  }
  
}