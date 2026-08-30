import '../details_film.dart';

class DetailsState {}

class DetailsLoading extends DetailsState {}

class DetailsError extends DetailsState {
  String message;

  DetailsError({required this.message});
}

class DetailsSuccess extends DetailsState {
  DetailsFilm? details;

  DetailsSuccess({this.details});
}

class InitialDetails extends DetailsState {}
