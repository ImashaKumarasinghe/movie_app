import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_app/core/constants/api_constants.dart';
import 'package:movie_app/models/movie_model.dart';

class MovieService {
  Map<String, String> get headers => {
        'Authorization': 'Bearer ${ApiConstants.bearerToken}',
        'accept': 'application/json',
      };

  Future<List<MovieModel>> popularMovies() async {
    final response = await http.get(
      Uri.parse('${ApiConstants.baseUrl}/movie/popular?language=en-US&page=1'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return (data['results'] as List)
          .map((movie) => MovieModel.fromJson(movie))
          .toList();
    } else {
      throw Exception('Failed to load popular movies');
    }
  }

  Future<List<MovieModel>> topRatedMovies() async {
    final response = await http.get(
      Uri.parse('${ApiConstants.baseUrl}/movie/top_rated?language=en-US&page=1'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return (data['results'] as List)
          .map((movie) => MovieModel.fromJson(movie))
          .toList();
    } else {
      throw Exception('Failed to load top rated movies');
    }
  }

  Future<List<MovieModel>> upcomingMovies() async {
    final response = await http.get(
      Uri.parse('${ApiConstants.baseUrl}/movie/upcoming?language=en-US&page=1'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return (data['results'] as List)
          .map((movie) => MovieModel.fromJson(movie))
          .toList();
    } else {
      throw Exception('Failed to load upcoming movies');
    }
  }

  Future<List<MovieModel>> similarMovies(int movieId) async {
    final response = await http.get(
      Uri.parse('${ApiConstants.baseUrl}/movie/$movieId/similar?language=en-US&page=1'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return (data['results'] as List)
          .map((movie) => MovieModel.fromJson(movie))
          .toList();
    } else {
      throw Exception('Failed to load similar movies');
    }
  }
}