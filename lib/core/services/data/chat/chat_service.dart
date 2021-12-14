import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

import '../../../../data/models/chat_message.dart';
import '../../../../domain/entities/chat_message_entity.dart';
import '../../error_handling/service_errors.dart';
import '../firebase_consts.dart';
import 'chat_response.dart';

const chatsDocument = "chats";
const chatsCollection = "chats_list";
const messagesCollection = "messages";

class ChatService {
  static Future<ChatResponse> upsert(ChatMessage message) async {
    ChatResponse response =
        ChatResponse(error: noError, errorCode: -1, messages: null);

    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final CollectionReference _mainCollection =
        _firestore.collection(mainCollection);

    if (message.uuid.isEmpty) {
      message.uuid = const Uuid().v4();
    }

    DocumentReference documentReferencer = _mainCollection
        .doc(chatsDocument)
        .collection(chatsCollection)
        .doc(message.movieId)
        .collection(messagesCollection)
        .doc();

    await documentReferencer
        .set(message.toData())
        .whenComplete(() => response =
            ChatResponse(error: noError, errorCode: -1, messages: null))
        .catchError((ex, stack) {
      response =
          ChatResponse(error: errorServer, errorCode: -1, messages: null);
    });

    return response;
  }

  static ChatResponse getAll(String movieId) {
    ChatResponse response =
        ChatResponse(error: noError, errorCode: -1, messages: null);

    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final CollectionReference _mainCollection =
        _firestore.collection(mainCollection);

    CollectionReference collection =
        _mainCollection.doc(chatsDocument).collection(chatsCollection);

    response.messages = collection
        .doc(movieId)
        .collection(messagesCollection)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((item) => ChatMessageEntity().fromData(item.data()))
            .toList());

    return response;
  }
}
