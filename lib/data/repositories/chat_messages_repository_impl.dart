import 'dart:async';

import 'package:dartz/dartz.dart';

import '../../core/services/data/chat/chat_response.dart';
import '../../core/services/error_handling/failures.dart';
import '../../domain/repositories/chat_messages_repository.dart';
import '../datasources/remote/chat_messages_remote_data_source.dart';
import '../models/chat_message.dart';

class ChatMessagesRepositoryImpl implements ChatMessagesRepository {
  final ChatMessagesRemoteDataSource remoteDataSource;

  ChatMessagesRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, ChatResponse>> upsert(ChatMessage message) async {
    try {
      final result = await remoteDataSource.upsert(message);
      return Right(result);
    } catch (exception) {
      return Left(ServerFailure(exception: exception));
    }
  }

  @override
  Either<Failure, ChatResponse> getAll(String movieId) {
    try {
      final result = remoteDataSource.getAll(movieId);
      return Right(result);
    } catch (exception) {
      return Left(ServerFailure(exception: exception));
    }
  }
}
