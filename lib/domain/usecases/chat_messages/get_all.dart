import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../core/services/data/chat/chat_response.dart';
import '../../../core/services/error_handling/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../repositories/chat_messages_repository.dart';

class GetAllChatMessagesUseCase
    implements UseCase<ChatResponse, ParamsGetChatMessages> {
  final ChatMessagesRepository repository;

  GetAllChatMessagesUseCase(this.repository);

  @override
  Future<Either<Failure, ChatResponse>> call(
      ParamsGetChatMessages params) async {
    return repository.getAll(params.movieId);
  }
}

class ParamsGetChatMessages extends Equatable {
  final String movieId;

  const ParamsGetChatMessages({required this.movieId});

  @override
  List<Object> get props => [movieId];
}
