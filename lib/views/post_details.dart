import 'package:fetch_data_api/api/request.dart';
import 'package:fetch_data_api/views/posts_list.dart';
import 'package:flutter/material.dart';

import 'edit_post.dart';

class PostDetails extends StatelessWidget {
  const PostDetails(this.itemId, {Key? key}) : super(key: key);

  final int itemId;

  @override
  Widget build(BuildContext context) {
    Future<Map> postDetails = HTTPRequest().getSingleItem(itemId);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Post details'),
          actions: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => EditPost(itemId),
                //   ),
                // );
                debugPrint('Edit post $itemId');
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                HTTPRequest().deleteItem(itemId);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ListOfPosts()));
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.redAccent.shade400,
                    content: const Text('Post deleted'),
                  ),
                );
                debugPrint('Delete post $itemId');
              },
            ),
          ],
        ),
        body: FutureBuilder<Map>(
            future: postDetails,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text('Error fetching post ${snapshot.error}'),
                );
              }
              if (snapshot.hasData) {
                Map data = snapshot.data!;
                return Center(
                  heightFactor: 100,
                  child: ListView.builder(
                    itemCount: 1,
                    itemBuilder: (BuildContext context, int index) {
                      return Builder(builder: (context) {
                        return Card(
                            elevation: 5.0,
                            margin: const EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 6.0),
                            color: Colors.white70,
                            surfaceTintColor: Colors.yellowAccent,
                            child: Card(
                              child: ListTile(
                                title: Text(data['title']),
                                subtitle: Text(data['body']),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          EditPost(data, data['id']),
                                    ),
                                  );
                                },
                              ),
                            ));
                      });
                    },
                  ),
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            }));
  }
}
