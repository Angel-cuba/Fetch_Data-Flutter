import 'dart:convert';

import 'package:http/http.dart' as http;

class HTTPRequest {
  // ! Fetch all items
  Future<List<Map>> getItems() async {
    List<Map> items = [];

    //? Fetch all the data from the API
    http.Response response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    if (response.statusCode == 200) {
      String data = response.body;
      //! Convert the data to List<Map>
      List result = jsonDecode(data);
      items = result.map((e) => e as Map).toList();
    }
    return items;
  }

//!Fetch details of a single user
  Future<Map> getSingleItem(id) async {
    Map item = {};

    //? Fetch the data from the API
    http.Response response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/posts/$id'));
    if (response.statusCode == 200) {
      String data = response.body;
      //! Convert the data to Map
      item = jsonDecode(data);
    }
    return item;
  }

  //! Add a new item to the API
  Future<bool> addItem(Map item) async {
    bool status = false;
    //? Add the item to the API
    http.Response response = await http.post(
      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
      body: jsonEncode(item),
      headers: {
        'Content-type': 'application/json: charset=UTF-8',
      },
    );
    if (response.statusCode == 201) {
      status = response.body.isNotEmpty;
    }
    return status;
  }

  //! Update an item in the API
  Future<bool> updateItem(Map item, String id) async {
    bool status = false;
    //? Update the item in the API
    http.Response response = await http.put(
      Uri.parse('https://jsonplaceholder.typicode.com/posts/$id'),
      body: jsonEncode(item),
      headers: {
        'Content-type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      status = response.body.isNotEmpty;
    }
    return status;
  }

  //! Delete an item from the API
  Future<bool> deleteItem(String id) async {
    bool result = false;
    //? Delete the item from the API
    http.Response response = await http
        .delete(Uri.parse('https://jsonplaceholder.typicode.com/posts/$id'));

    if (response.statusCode == 200) {
      result = true;
    }
    return result;
  }
}
