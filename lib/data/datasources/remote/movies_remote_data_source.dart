import '../../../core/services/movies/movies_service.dart';
import '../../../core/services/response/movies_response.dart';

abstract class MoviesRemoteDataSource {
  Future<MoviesResponse> getMovies();
}

class MoviesRemoteDataSourceImpl implements MoviesRemoteDataSource {
  @override
  Future<MoviesResponse> getMovies() => MoviesService.getMovies();
}
