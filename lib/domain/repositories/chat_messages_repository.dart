import 'package:dartz/dartz.dart';

import '../../core/services/data/chat/chat_response.dart';
import '../../core/services/error_handling/failures.dart';
import '../entities/chat_message_entity.dart';

abstract class ChatMessagesRepository {
  Future<Either<Failure, ChatResponse>> upsert(ChatMessageEntity message);
  Either<Failure, ChatResponse> getAll(String movieId);
}
