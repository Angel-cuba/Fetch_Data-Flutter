import 'package:fetch_data_api/api/request.dart';
import 'package:fetch_data_api/views/posts_list.dart';
import 'package:flutter/material.dart';

class EditPost extends StatefulWidget {
  const EditPost(this.post, data, {super.key});

  // final int id;
  final Map post;

  @override
  State<EditPost> createState() => _EditPostState();
}

TextEditingController _titleController = TextEditingController();
TextEditingController _bodyController = TextEditingController();

class _EditPostState extends State<EditPost> {
  @override
  initState() {
    super.initState();
    _titleController.text = widget.post['title'];
    _bodyController.text = widget.post['body'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Post ${widget.post['id']}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
              ),
            ),
            TextFormField(
              controller: _bodyController,
              decoration: const InputDecoration(
                labelText: 'Body',
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                Map<String, String> data = {
                  'title': _titleController.text,
                  'body': _bodyController.text,
                };
                bool status = await HTTPRequest().updateItem(
                  data,
                  widget.post['id'].toString(),
                );
                if (status) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Post updated'),
                    ),
                  );
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ListOfPosts()));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Error updating post'),
                    ),
                  );
                }
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
