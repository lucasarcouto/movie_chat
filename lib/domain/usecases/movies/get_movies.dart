import 'package:dartz/dartz.dart';

import '../../../core/services/data/movies/movies_response.dart';
import '../../../core/services/error_handling/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../repositories/movies_repository.dart';

class GetMoviesUseCase implements UseCase<MoviesResponse, NoParams> {
  final MoviesRepository repository;

  GetMoviesUseCase(this.repository);

  @override
  Future<Either<Failure, MoviesResponse>> call(NoParams params) async {
    return await repository.getMovies();
  }
}
