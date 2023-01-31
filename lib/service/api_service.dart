import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:trouver/model/movie_cast_model.dart';
import 'package:trouver/model/movie_detail_model.dart';
import 'package:trouver/model/movie_now_playing_model.dart';
import 'package:trouver/model/movie_popular_model.dart';
import 'package:trouver/model/movie_top_rated_model.dart';
import 'package:trouver/model/movie_upcoming_model.dart';
import 'package:trouver/ui/widget/snackbar.dart';

class ApiService {
  final baseUrl = "https://api.themoviedb.org/3";
  final apiKey = "3c8c8a2940921b169a00215ea1295df5";

  Future getMovieTopRated() async {
    const endPoint = "/movie/top_rated";
    const language = "en-US";
    const page = "1";
    final url =
        "$baseUrl$endPoint?api_key=$apiKey&language=$language&page=$page";

    try {
      final response = await http.get(Uri.parse(url));

      print('status code : ${response.statusCode}');
      if (response.statusCode == 200) {
        MovieTopRatedModel model =
            MovieTopRatedModel.fromJson(json.decode(response.body));
        return model;
      } else {
        throw Exception("Failed to fetch data from API");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future getMoviePopular() async {
    const endPoint = "/movie/popular";
    const language = "en-US";
    const page = "1";
    final url =
        "$baseUrl$endPoint?api_key=$apiKey&language=$language&page=$page";

    try {
      final response = await http.get(Uri.parse(url));

      print('status code : ${response.statusCode}');
      if (response.statusCode == 200) {
        MoviePopularModel model =
            MoviePopularModel.fromJson(json.decode(response.body));
        return model;
      } else {
        throw Exception("Failed to fetch data from API");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future getMovieUpcoming() async {
    const endPoint = "/movie/upcoming";
    const language = "en-US";
    const page = "1";
    final url =
        "$baseUrl$endPoint?api_key=$apiKey&language=$language&page=$page";

    try {
      final response = await http.get(Uri.parse(url));

      print('status code : ${response.statusCode}');
      if (response.statusCode == 200) {
        MovieUpcomingModel model =
            MovieUpcomingModel.fromJson(json.decode(response.body));
        return model;
      } else {
        throw Exception("Failed to fetch data from API");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future getMovieNowPlaying(String region) async {
    const endPoint = "/movie/now_playing";
    const language = "en-US";
    const page = "1";
    final url =
        "$baseUrl$endPoint?api_key=$apiKey&language=$language&page=$page&region=$region";

    try {
      final response = await http.get(Uri.parse(url));

      print('status code : ${response.statusCode}');
      if (response.statusCode == 200) {
        MovieNowPlayingModel model =
            MovieNowPlayingModel.fromJson(json.decode(response.body));
        return model;
      } else {
        throw Exception("Failed to fetch data from API");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future getMovieDetail(String id) async {
    final endPoint = "/movie/$id";
    const language = "en-US";
    final url = "$baseUrl$endPoint?api_key=$apiKey&language=$language";

    try {
      final response = await http.get(Uri.parse(url));

      print('status code : ${response.statusCode}');
      if (response.statusCode == 200) {
        MovieDetailModel model =
            MovieDetailModel.fromJson(json.decode(response.body));
        return model;
      } else {
        throw Exception("Failed to fetch data from API");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future getMovieCast(BuildContext context, String id) async {
    final endPoint = "/movie/$id/credits";
    const language = "en-US";
    final url = "$baseUrl$endPoint?api_key=$apiKey&language=$language";

    try {
      final response = await http.get(Uri.parse(url));

      print('status code : ${response.statusCode}');
      if (response.statusCode == 200) {
        MovieCastModel model =
            MovieCastModel.fromJson(json.decode(response.body));
        return model;
      } else {
        throw Exception("Failed to fetch data from API");
      }
    } on HttpException {
      showSnackBar(context, title: "HttpException");
    }
  }
}
