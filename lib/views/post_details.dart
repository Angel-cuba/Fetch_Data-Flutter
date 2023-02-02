import 'package:fetch_data_api/api/request.dart';
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
          title: Text('Post $itemId'),
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
                          child: ListTile(
                            title: Text(data['title']),
                            subtitle: Text(data['body']),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditPost(
                                    data['id'],
                                  ),
                                ),
                              );
                              debugPrint('Edit post ${data['id']}');
                            },
                          ),
                        );
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
