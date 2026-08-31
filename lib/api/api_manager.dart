import 'package:dio/dio.dart';
import 'package:movie_app/api/constants/end_point.dart';
import 'constants/api_constant.dart';
import 'model/available_movies_response.dart';


class ApiManager {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://${ApiConstants.baseUrl}/',
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
    ),
  );


  static Future<AvailableMoviesResponse?> getMovies({
    String? genre,
    int limit = 20,
    String sortBy = 'date_added',
    String orderBy = 'desc',
  }) async {
    try {
      var response = await _dio.get(
        ApiEndpoints.listMovies,
        queryParameters: {
          'limit': limit,
          'sort_by': sortBy,
          'order_by': orderBy,
          if (genre != null && genre.isNotEmpty) 'genre': genre.toLowerCase(),
        },
      );

      if (response.statusCode == 200 && response.data != null) {
        return AvailableMoviesResponse.fromJson(response.data);
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}