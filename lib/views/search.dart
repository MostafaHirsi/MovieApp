import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mymovieapp/models/mediamodel.dart';
import 'package:mymovieapp/models/mediatype.dart';
import 'package:mymovieapp/services/mediaservice.dart';
import 'package:mymovieapp/views/medialistitem.dart';

class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _SearchPageState();

}

class _SearchPageState extends State<SearchPage> {
  ScrollController controller;
  MediaType selectedMediaType = MediaType.movie;
  List<DropdownMenuItem<MediaType>> mediaTypes = new List<DropdownMenuItem<MediaType>>();
  List<MediaModel> mediaModels = new List<MediaModel>();
  String selectedMediaTypeString = "";
  String currentSearchTerms = "";
  int pageNo = 1;

  void OnChanged(MediaType selectedValue)
  {
    setState(() {
      selectedMediaType = selectedValue;
      switch (selectedMediaType) {
        case MediaType.movie:
          selectedMediaTypeString = "movie";
          break;
        case MediaType.movie:
          selectedMediaTypeString = "tv show";
          break;
        default:
      }
    });
  }

  void OnSubmitted (String searchTerms) async
  {
    showDialog(
      context: context,
      barrierDismissible: false,
      child: new Dialog(
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            new Padding(padding: EdgeInsets.all(30.0), child: new CircularProgressIndicator()),
            new Padding(padding: EdgeInsets.all(30.0), child: new Text("Loading")),
          ],
        ),
      ),
    );
    mediaModels.clear();
    var mediaMods = await MediaService.searchForMedia(searchTerms,
      selectedMediaType, 1);      
    setState(() {
      mediaModels = mediaMods;
    });
    Navigator.pop(context);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedMediaTypeString = "movie";
    controller = new ScrollController()..addListener(_scrollListener);
    mediaTypes.add(new DropdownMenuItem(
      value: MediaType.tv,
      child: new Row(children: <Widget>[
          new Icon(Icons.tv),
          new Padding(child: new Text('TV'),
            padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
          )
      ]),
    ));
    mediaTypes.add(new DropdownMenuItem(
      value: MediaType.movie, 
      child: new Row(children: <Widget>[
          new Icon(Icons.movie),
          new Padding(child: new Text('Movie'),
            padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
          )
      ]),
    ));
  }

  void _scrollListener() async {
    if (controller.position.atEdge) {
      int properPage = pageNo + 1;
      List<MediaModel> mediaMods = await MediaService.searchForMedia(currentSearchTerms,
                selectedMediaType, properPage);
      setState(() {
        this.mediaModels.addAll(mediaMods);
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: new Text("Search Films/Shows"),
      ),
      body: new Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
                new Row(children: <Widget>[
                  new Container(child:  TextField(
                    decoration: new InputDecoration(labelText: "Enter a $selectedMediaTypeString name"),
                    keyboardType: TextInputType.text,
                    onSubmitted: OnSubmitted,
                  ), width: 300.0,),
                new Padding(child: new DropdownButton(
                  value: selectedMediaType, 
                  items: mediaTypes,
                  onChanged: OnChanged,
                  ),
                  padding: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
                ),],
                mainAxisAlignment: MainAxisAlignment.center,),
                new Expanded(child: ListView.builder(
                              itemBuilder: buildList, 
                              ),
                ),
          ],
        ),
      )
    );
  }

  Widget buildList(BuildContext context, int index){
      return mediaModels.length > 0 && index < mediaModels.length
       ? MediaListItem(mediaModels[index]) : null;
  }
}
