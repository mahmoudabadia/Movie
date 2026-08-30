import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/api/cubit_dio/details_state.dart';
import 'package:movie_app/api/dio_manager.dart';
import 'package:movie_app/api/movie.dart';

class ViewModelDetails extends Cubit<DetailsState> {
  ViewModelDetails() : super(DetailsLoading());
  String errorMessage = '';
  List<Movie> similarMovies = [];

  void getDetailsFilmId(int idMovie) async {
    emit(DetailsLoading());
    try {
      final responseDetails = await DioManager.getDetailsFilm(idMovie);

      if (responseDetails.data!.movie != null) {
        emit(DetailsSuccess(details: responseDetails));
        getSimilarMovies(idMovie, responseDetails);
      } else {
        emit(DetailsError(message: responseDetails.statusMessage!));
      }
    } on DioException catch (e) {
      errorMessage = mapDioErrorToMessage(e);
      emit(DetailsError(message: mapDioErrorToMessage(e)));
    } catch (e) {
      emit(DetailsError(message: e.toString()));
    }
  }

  void getSimilarMovies(int movieId, dynamic details) async {
    try {
      print("Fetching similar movies for ID: $movieId ...");
      similarMovies = await DioManager.getMovieSuggestions(movieId);
      print("Fetched ${similarMovies.length} movies.");
      emit(DetailsSuccess(details: details));
    } catch (e) {
      print("Exception in getSimilarMovies: $e");
      similarMovies = [];
    }
  }
}

String mapDioErrorToMessage(DioException error) {
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
    case DioExceptionType.connectionError:
      return 'Make sure you are connected to the internet and try again.';
    case DioExceptionType.badResponse:
      final code = error.response?.statusCode;
      if (code == 404) return 'Movie Not Found';
      if (code == 500) return 'Some Thing went wrong try again later';
      return ' $code server error try again later.';
    default:
      return 'Sorry Server Error Try Again later';
  }
}
