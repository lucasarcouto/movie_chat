import 'package:flutter/material.dart';

class MovieChatScreen extends StatefulWidget {
  const MovieChatScreen({Key? key}) : super(key: key);

  @override
  _MovieChatScreenState createState() => _MovieChatScreenState();
}

class _MovieChatScreenState extends State<MovieChatScreen> {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Movie Chat"));
  }
}
