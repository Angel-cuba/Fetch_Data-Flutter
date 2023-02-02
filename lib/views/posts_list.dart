import 'package:fetch_data_api/api/request.dart';
import 'package:flutter/material.dart';

import 'post_details.dart';

class ListOfPosts extends StatefulWidget {
  const ListOfPosts({super.key});

  @override
  State<ListOfPosts> createState() => _ListOfPostsState();
}

class _ListOfPostsState extends State<ListOfPosts> {
  final Future<List<Map>> _listPosts = HTTPRequest().getItems();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
      ),
      body: FutureBuilder<List<Map>>(
          future: _listPosts,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('Error fetching posts ${snapshot.error}'),
              );
            }
            if (snapshot.hasData) {
              List<Map> data = snapshot.data;
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Builder(builder: (context) {
                    return Card(
                      elevation: 5.0,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 6.0),
                      color: Colors.white70,
                      surfaceTintColor: Colors.yellowAccent,
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.blueAccent,
                          child: Text(data[index]['id'].toString()),
                        ),
                        title: Text(data[index]['title']),
                        subtitle: Text(data[index]['body']),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PostDetails(
                                data[index]['id'],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  });
                },
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
