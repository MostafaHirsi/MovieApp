
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mymovieapp/models/mediamodel.dart';
import 'package:mymovieapp/models/moviemodel.dart';
import 'package:mymovieapp/models/tvmodel.dart';
import 'package:flutter_rating/flutter_rating.dart';

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

  String getTitle()
  {
    return mediaItemModel is MovieModel ? (mediaItemModel as MovieModel)?.title ?? ""
    : (mediaItemModel as TVModel)?.name ?? "";
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

      // appBar: new AppBar(
      //   // Here we take the value from the MyHomePage object that was created by
      //   // the App.build method, and use it to set our appbar title.
      //   title: new Text("Search Films/Shows"),
      // ),


    return new Scaffold(
      floatingActionButton: 
            new FloatingActionButton(
              child: new Icon(Icons.mood), backgroundColor:  Colors.red.shade900,
              elevation: 2.0, 
              ),
      body:SafeArea(
              child: new Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                    new Stack(
                      children: <Widget>[
                      Center(
                        child: new Container(
                          child: new CachedNetworkImage(
                                imageUrl: mediaItemModel.backDropPath,
                                placeholder: Padding(
                                  padding: const EdgeInsets.all(60.0),
                                  child: Center(child: new CircularProgressIndicator()),
                                ),
                                errorWidget: new Icon(Icons.movie, color: Colors.black,),
                                fit: BoxFit.fitWidth,
                              ),
                          ),
                      ),
                      new Container(
                                  decoration: new BoxDecoration(gradient: new LinearGradient(colors: [Colors.black54, Colors.black54, Colors.black54, Colors.transparent,],
                                    stops: [0.3, 0.3, 0.3 , 2.5],
                                   begin: FractionalOffset.topCenter,
                                    end: FractionalOffset.bottomCenter, tileMode: TileMode.repeated)),
                                  padding: EdgeInsets.fromLTRB(5.0, 12.0, 10.0, 10.0),
                                  width: MediaQuery.of(context).size.width,
                                  child: new Text(getTitle(), style: TextStyle(fontSize: 22.1, color: Colors.white,  fontWeight: FontWeight.bold, ),
                                        maxLines: 2, overflow: TextOverflow.ellipsis, softWrap: true, textAlign: TextAlign.end,)
                                ),
                      new Baseline(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(250.0, 0.0, 0.0, 0.0),
                            child: new StarRating(rating: mediaItemModel.rating, 
                                                  color: Colors.yellow.shade400, 
                                                  borderColor: Colors.yellow.shade400 ),
                          ),
                          baseline: 223.0,
                          baselineType: TextBaseline.alphabetic,
                      ),
                      new BackButton(color: Colors.white,),
                    ],),

                  new Card(child: new Column(children: <Widget>[
                          new Padding(
                            child: new Text("Overview",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0), 
                                textAlign: TextAlign.start,),
                            padding: EdgeInsets.all(4.0),
                            ),
                          new Container(child: new Text(mediaItemModel.overview,
                      style: TextStyle(fontSize: 15.0, ),),)],
                      )
                  ,)
                ],
              ),
      ),
    );
  }
  
}