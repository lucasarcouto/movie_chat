import 'package:dartz/dartz.dart';

import '../../core/services/error_handling/failures.dart';
import '../../core/services/response/movies_response.dart';

abstract class MoviesRepository {
  Future<Either<Failure, MoviesResponse>> getMovies();
}
