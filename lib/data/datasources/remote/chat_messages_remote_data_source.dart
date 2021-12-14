import '../../../core/services/data/chat/chat_response.dart';
import '../../../core/services/data/chat/chat_service.dart';
import '../../models/chat_message.dart';

abstract class ChatMessagesRemoteDataSource {
  Future<ChatResponse> upsert(ChatMessage message);
  ChatResponse getAll(String movieId);
}

class ChatMessagesRemoteDataSourceImpl implements ChatMessagesRemoteDataSource {
  @override
  Future<ChatResponse> upsert(ChatMessage message) async =>
      await ChatService.upsert(message);

  @override
  ChatResponse getAll(String movieId) => ChatService.getAll(movieId);
}
