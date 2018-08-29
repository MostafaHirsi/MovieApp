import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mymovieapp/models/mediamodel.dart';
import 'package:mymovieapp/services/mediaservice.dart';
import 'package:mymovieapp/views/movielistitem.dart';

class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _SearchPageState();

}

class _SearchPageState extends State<SearchPage> {
  String selectedMediaType = "Movie";
  List<DropdownMenuItem<String>> mediaTypes = new List<DropdownMenuItem<String>>();
  List<MediaModel> mediaModels = new List<MediaModel>();
  void OnChanged(String selectedValue)
  {
    setState(() {
      selectedMediaType = selectedValue;
    });
  }

  void OnSubmitted (String searchTerms) async
  {
    mediaModels.clear();
    mediaModels = await MediaService.searchForMedia(searchTerms, selectedMediaType.toLowerCase(), 1);      
  }

  @override
    void initState() {
      // TODO: implement initState
      super.initState();
      mediaTypes.add(new DropdownMenuItem(
        value: 'TV',
        child: new Row(children: <Widget>[
            new Icon(Icons.tv),
            new Padding(child: new Text('TV'),
              padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
            )
        ]),
      ));
      mediaTypes.add(new DropdownMenuItem(
        value: 'Movie', 
        child: new Row(children: <Widget>[
            new Icon(Icons.movie),
            new Padding(child: new Text('Movie'),
              padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
            )
        ]),
      ));
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
                    decoration: new InputDecoration(labelText: "Enter a $selectedMediaType name"),
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
                  new Expanded( 
                    child: ListView.builder(
                        itemBuilder: (BuildContext context, int index) =>
                            MovieListItem(mediaModels[index]),
                    ),
                  ),
          ],
        ),
      )
    );
  }
}
