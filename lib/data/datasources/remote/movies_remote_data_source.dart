import '../../../core/services/data/movies/movies_response.dart';
import '../../../core/services/data/movies/movies_service.dart';

abstract class MoviesRemoteDataSource {
  Future<MoviesResponse> getMovies();
}

class MoviesRemoteDataSourceImpl implements MoviesRemoteDataSource {
  @override
  Future<MoviesResponse> getMovies() => MoviesService.getMovies();
}
