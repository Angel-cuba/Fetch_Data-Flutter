import 'package:flutter/material.dart';

class ListOfPosts extends StatefulWidget {
  const ListOfPosts({super.key});

  @override
  State<ListOfPosts> createState() => _ListOfPostsState();
}

class _ListOfPostsState extends State<ListOfPosts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
      ),
      body: Container(),
    );
  }
}
