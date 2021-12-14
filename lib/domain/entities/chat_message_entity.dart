import '../../data/models/chat_message.dart';

class ChatMessageEntity extends ChatMessage {
  ChatMessageEntity(
      {String uuid = "",
      String userUuid = "",
      String userName = "",
      String movieId = "",
      int date = -1,
      String message = ""}) {
    this.uuid = uuid;
    this.userUuid = userUuid;
    this.userName = userName;
    this.movieId = movieId;
    this.date = date;
    this.message = message;
  }
}

extension UserParsing on ChatMessageEntity {
  ChatMessageEntity fromModel(ChatMessage? model) => ChatMessageEntity(
        uuid: model != null ? model.uuid : "",
        userUuid: model != null ? model.userUuid : "",
        userName: model != null ? model.userName : "",
        movieId: model != null ? model.movieId : "",
        date: model != null ? model.date : -1,
        message: model != null ? model.message : "",
      );

  ChatMessageEntity fromData(Map<dynamic, dynamic> data) => ChatMessageEntity(
        uuid: data['uuid'],
        userUuid: data['user_uuid'],
        userName: data['user_name'],
        movieId: data['movie_id'],
        date: data['date'],
        message: data['message'],
      );
}
