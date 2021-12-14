import 'dart:async';

import 'package:dartz/dartz.dart';

import '../../core/services/error_handling/failures.dart';
import '../../domain/repositories/preferences_repository.dart';
import '../datasources/local/preferences_local_data_source.dart';

class PreferencesRepositoryImpl implements PreferencesRepository {
  final PreferencesLocalDataSource localDataSource;

  PreferencesRepositoryImpl({
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, String>> getString(String key, String defVal) async {
    try {
      final result = await localDataSource.getString(key, defVal);
      return Right(result);
    } catch (exception) {
      return Left(CacheFailure(exception: exception));
    }
  }

  @override
  Future<Either<Failure, bool>> putString(String key, String value) async {
    try {
      final result = await localDataSource.putString(key, value);
      return Right(result);
    } catch (exception) {
      return Left(CacheFailure(exception: exception));
    }
  }
}
