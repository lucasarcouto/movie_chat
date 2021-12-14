import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/utils/custom_date_utils.dart';

import '../../core/services/localizations/localizations.dart';
import '../../core/widgets/custom_flushbar.dart';
import '../../domain/entities/chat_message_entity.dart';
import '../../domain/entities/movie_entity.dart';
import '../../injection_container.dart';
import 'bloc/movie_chat_bloc.dart';

class MovieChatScreen extends StatefulWidget {
  final MovieEntity movie;

  const MovieChatScreen({Key? key, required this.movie}) : super(key: key);

  @override
  _MovieChatScreenState createState() => _MovieChatScreenState();
}

class _MovieChatScreenState extends State<MovieChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  List<ChatMessageEntity> _messages = [];

  String _userUuid = "";
  String _userName = "";
  String _message = "";

  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  Widget build(BuildContext context) {
    var _localization = AppLocalization.of(context)!;

    return BlocProvider(
      create: (context) => injection<MovieChatBloc>(),
      child: BlocBuilder<MovieChatBloc, MovieChatState>(
        builder: (BuildContext context, MovieChatState state) {
          if (state is MovieChatEmpty) {
            BlocProvider.of<MovieChatBloc>(context)
                .add(MovieChatGetInitialData(widget.movie.uuid));
          } else if (state is MovieChatInitialDataLoaded) {
            state.messages?.listen((messages) {
              setState(() {
                _messages = messages;
                _messages.sort((a, b) {
                  if (a.date < b.date) {
                    return -1;
                  } else if (a.date > b.date) {
                    return 1;
                  } else {
                    return 0;
                  }
                });
                _scrollToBottom();
              });
            });

            _userUuid = state.userUuid;
            _userName = state.userName;

            BlocProvider.of<MovieChatBloc>(context).add(MovieChatSetIdle());
          } else if (state is MovieChatError) {
            CustomFlushbar.showDefaultErrorFlushbar(context);
            BlocProvider.of<MovieChatBloc>(context).add(MovieChatSetIdle());
          }

          return WillPopScope(
            onWillPop: () async => state is! MovieChatLoading,
            child: Scaffold(
              appBar: AppBar(
                title: Text("${widget.movie.title} (${widget.movie.title})"),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      controller: _scrollController,
                      itemCount: _messages.length,
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(8),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 4, bottom: 4),
                          child: Align(
                            alignment: (_messages[index].userUuid != _userUuid
                                ? Alignment.topLeft
                                : Alignment.topRight),
                            child: Column(
                              crossAxisAlignment:
                                  _messages[index].userUuid != _userUuid
                                      ? CrossAxisAlignment.start
                                      : CrossAxisAlignment.end,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color:
                                        (_messages[index].userUuid != _userUuid
                                            ? Colors.grey.shade200
                                            : Colors.blue[200]),
                                  ),
                                  padding: const EdgeInsets.all(16),
                                  child: Text(
                                    _messages[index].message,
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  "${_messages[index].userName.split(" ")[0]} - ${CustomDateUtils.parseDateMillis(_messages[index].date, dateComplete)}",
                                  style: const TextStyle(fontSize: 8),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: _localization.getString(writeComment),
                              hintStyle: const TextStyle(color: Colors.black38),
                              border: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 2.0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.0))),
                              enabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 2.0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.0))),
                            ),
                            keyboardType: TextInputType.text,
                            textCapitalization: TextCapitalization.words,
                            onChanged: (value) {
                              setState(() {
                                _message = value;
                              });
                            },
                            controller: _controller,
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.send,
                            color: Colors.grey[800]
                                ?.withAlpha(_message.isNotEmpty ? 255 : 80),
                          ),
                          onPressed: _message.isEmpty
                              ? null
                              : () {
                                  BlocProvider.of<MovieChatBloc>(context).add(
                                      MovieChatUpsertMessage(ChatMessageEntity(
                                          date: DateTime.now()
                                              .millisecondsSinceEpoch,
                                          message: _message,
                                          userName: _userName,
                                          userUuid: _userUuid,
                                          movieId: widget.movie.uuid)));
                                  _controller.text = "";
                                  _message = "";
                                  _scrollToBottom();
                                },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
