import '../../../../data/models/movie.dart';

class MoviesResponse {
  int error;
  int errorCode;
  List<Movie> movies;

  MoviesResponse(
      {required this.error, required this.errorCode, required this.movies});
}
