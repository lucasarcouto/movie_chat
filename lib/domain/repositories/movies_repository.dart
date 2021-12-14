import 'package:dartz/dartz.dart';

import '../../core/services/data/movies/movies_response.dart';
import '../../core/services/error_handling/failures.dart';

abstract class MoviesRepository {
  Future<Either<Failure, MoviesResponse>> getMovies();
}
