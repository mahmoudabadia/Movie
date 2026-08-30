import 'package:dio/dio.dart';
import 'package:movie_app/api/movie.dart';
import 'package:url_launcher/url_launcher.dart';

import 'details_film.dart';

class DioManager {
  static Future<void> openMovieUrl(String? urlString) async {
    if (urlString == null || urlString.isEmpty) return;

    final Uri uri = Uri.parse(urlString);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  static Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://movies-api.accel.li/api/v2/',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  static Future<DetailsFilm> getDetailsFilm(int idMovie) async {
    try {
      var responseDetails = await dio.get(
        'movie_details.json',
        queryParameters: {
          'movie_id': idMovie,
          'with_images': true,
          'with_cast': true,
        },
      );
      return DetailsFilm.fromJson(responseDetails.data);
    } catch (e) {
      rethrow;
    }
  }

  static Future<List<Movie>> getMovieSuggestions(int movieId) async {
    try {
      var response = await dio.get(
        'movie_suggestions.json',
        queryParameters: {'movie_id': movieId},
      );
      if (response.statusCode == 200 && response.data['data'] != null) {
        if (response.data['data']['movies'] != null) {
          List moviesJson = response.data['data']['movies'];
          return moviesJson.map((json) => Movie.fromJson(json)).toList();
        }
      }
      return [];
    } catch (e) {
      return [];
    }
  }
}
