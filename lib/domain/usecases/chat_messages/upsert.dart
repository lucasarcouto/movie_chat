import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../core/services/data/chat/chat_response.dart';
import '../../../core/services/error_handling/failures.dart';
import '../../../core/usecases/usecase.dart';
import '../../entities/chat_message_entity.dart';
import '../../repositories/chat_messages_repository.dart';

class UpsertChatMessageUseCase
    implements UseCase<ChatResponse, ParamsUpsertChatMessage> {
  final ChatMessagesRepository repository;

  UpsertChatMessageUseCase(this.repository);

  @override
  Future<Either<Failure, ChatResponse>> call(
      ParamsUpsertChatMessage params) async {
    return await repository.upsert(params.message);
  }
}

class ParamsUpsertChatMessage extends Equatable {
  final ChatMessageEntity message;

  const ParamsUpsertChatMessage({required this.message});

  @override
  List<Object> get props => [message];
}
