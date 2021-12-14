import '../../../../data/models/chat_message.dart';

class ChatResponse {
  int error;
  int errorCode;
  Stream<List<ChatMessage>>? messages;

  ChatResponse(
      {required this.error, required this.errorCode, required this.messages});
}
