import 'package:sity_movies/models/movie.dart';
import 'dart:async';
import 'dart:convert';
import 'package:sity_movies/services/networking.dart';

const apiKey = '48f3541d';
const String omdbUrl = 'http://www.omdbapi.com/?';

class DataModel {

  Future getMovieDataById(String id) async {
    NetworkHelper networkHelper =
        NetworkHelper('$omdbUrl&apikey=$apiKey&i=$id');
    var data = await networkHelper.getOmdbData();
    var result = Movie.fromJson(data);
    var jsonResult = result.toJson();
    print("jsonResult: $jsonResult");
    return result;
  }

  Future getMovieSearchData(String search, int page,
      {bool isMovie, String plot = 'full'}) async {
    var type = isMovie ? 'movie' : 'series';
    NetworkHelper netWorkHelper = NetworkHelper(
        '$omdbUrl&apikey=$apiKey&s=$search&type=$type&plot=$plot&page=$page');
    var moviesResults = await netWorkHelper.getOmdbData();
    var data = moviesResults["Search"];
  return data;
  }
}
