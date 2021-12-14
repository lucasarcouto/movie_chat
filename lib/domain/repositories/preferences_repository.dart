import 'package:dartz/dartz.dart';

import '../../core/services/error_handling/failures.dart';

abstract class PreferencesRepository {
  Future<Either<Failure, String>> getString(String key, String defVal);
  Future<Either<Failure, bool>> putString(String key, String value);
}
