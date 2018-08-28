import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:mymovieapp/models/mediamodel.dart';
import 'package:mymovieapp/models/moviemodel.dart';
import 'package:mymovieapp/models/tvmodel.dart';

class MediaService
{

    static Future<String> searchForMediaDetails(String mediaPath, String mediaID) async{
        Response response = await getMediaDetails(mediaPath,mediaID);
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        return jsonResponse['title'];
      }

    static Future<Response> getMediaDetails(String mediaPath, String mediaID) async {
        return get('https://api.themoviedb.org/3/$mediaPath/$mediaID?api_key=66f344b3bc2cb4979c529a1ff9f11214&language=en-US');
    }
    
    static Future<List<MediaModel>> searchForMedia(String searchKeyword, String mediaType, int page) async{
        Response response = await getMedia(searchKeyword, mediaType, page);
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        dynamic result = jsonResponse['results'];
        List<MediaModel> mediaModels = new List<MediaModel>();
        if(result == null)
        { 
          return new List<MediaModel>();
        }
        for (var i = 0; i < result.length; i++) {
            MediaModel mediaModel;
          if(mediaType == 'Movie'){
            mediaModel = new MovieModel.fromJson(result[i]);
          }else{
            mediaModel = new TVModel.fromJson(result[i]);
          }
          mediaModels.add(mediaModel);
        }
        return mediaModels;
      }

    static Future<Response> getMedia(String searchKeyword, String mediaType, int page) async {
        return get('https://api.themoviedb.org/3/search/$mediaType?api_key=66f344b3bc2cb4979c529a1ff9f11214&language=en-US&query=$searchKeyword&page=$page&include_adult=false');
    }

}
