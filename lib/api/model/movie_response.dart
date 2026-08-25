class MovieResponse {
  final String status;
  final List<Movie>? movies;

  MovieResponse({required this.status, this.movies});

  factory MovieResponse.fromJson(Map<String, dynamic> json) {
    return MovieResponse(
      status: json['status'] ?? '',
      movies: json['data'] != null && json['data']['movies'] != null
          ? (json['data']['movies'] as List)
          .map((e) => Movie.fromJson(e))
          .toList()
          : [],
    );
  }
}

class Movie {
  final int id;
  final String title;
  final double rating;
  final String largeCoverImage;
  final String mediumCoverImage;
  final List<String> genres;

  Movie({
    required this.id,
    required this.title,
    required this.rating,
    required this.largeCoverImage,
    required this.mediumCoverImage,
    required this.genres,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      largeCoverImage: json['large_cover_image'] ?? '',
      mediumCoverImage: json['medium_cover_image'] ?? '',
      genres: json['genres'] != null ? List<String>.from(json['genres']) : [],
    );
  }
}
