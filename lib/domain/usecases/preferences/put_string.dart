import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../core/services/error_handling/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../repositories/preferences_repository.dart';

class PreferencesPutStringUseCase implements UseCase<void, ParamsPutString> {
  final PreferencesRepository repository;

  PreferencesPutStringUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(ParamsPutString params) async {
    return await repository.putString(params.key, params.value);
  }
}

class ParamsPutString extends Equatable {
  final String key;
  final String value;

  const ParamsPutString({required this.key, required this.value});

  @override
  List<Object> get props => [key, value];
}
