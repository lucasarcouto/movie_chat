import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../core/services/error_handling/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../repositories/preferences_repository.dart';

class PreferencesGetStringUseCase implements UseCase<void, ParamsGetString> {
  final PreferencesRepository repository;

  PreferencesGetStringUseCase(this.repository);

  @override
  Future<Either<Failure, String>> call(ParamsGetString params) async {
    return await repository.getString(params.key, params.defVal);
  }
}

class ParamsGetString extends Equatable {
  final String key;
  final String defVal;

  const ParamsGetString({required this.key, required this.defVal});

  @override
  List<Object> get props => [key, defVal];
}
