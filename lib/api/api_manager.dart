import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'constants/api_constant.dart';
import 'model/available_movies_response.dart';
import 'constants/end_point.dart';

class ApiManager {
  static Future<AvailableMoviesResponse?> getMovies({
    String? genre,
    int limit = 20,
    String sortBy = 'date_added',
    String orderBy = 'desc',
  }) async {
    Uri url = Uri.https(
      ApiConstants.baseUrl,
      ApiEndpoints.listMovies,
      {
        'sort_by': sortBy,
        'order_by': orderBy,
        'limit': limit.toString(),

        if (genre != null && genre.isNotEmpty) 'genre': genre.toLowerCase(),
      },
    );

    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        return AvailableMoviesResponse.fromJson(json);
      } else {
        if (kDebugMode) {
          print("Server Error: ${response.statusCode}");
        }
        return null;
      }
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print("================ API ERROR ================");
        print(e);
        print(stackTrace);
        print("===========================================");
      }
      return null;
    }
  }
}