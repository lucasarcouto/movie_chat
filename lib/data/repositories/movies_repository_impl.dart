import 'dart:async';

import 'package:dartz/dartz.dart';

import '../../core/services/error_handling/failures.dart';
import '../../core/services/response/movies_response.dart';
import '../../domain/repositories/movies_repository.dart';
import '../datasources/remote/movies_remote_data_source.dart';

class MoviesRepositoryImpl implements MoviesRepository {
  final MoviesRemoteDataSource remoteDataSource;

  MoviesRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, MoviesResponse>> getMovies() async {
    try {
      final result = await remoteDataSource.getMovies();
      return Right(result);
    } catch (exception) {
      return Left(ServerFailure(exception: exception));
    }
  }
}
