class ChatMessage {
  String uuid;
  String userUuid;
  String userName;
  String movieId;
  int date;
  String message;

  ChatMessage({
    this.uuid = "",
    this.userUuid = "",
    this.userName = "",
    this.movieId = "",
    this.date = -1,
    this.message = "",
  });

  Map<String, dynamic> toData() => {
        'uuid': uuid,
        'user_uuid': userUuid,
        'user_name': userName,
        'movie_id': movieId,
        'date': date,
        'message': message,
      };
}
