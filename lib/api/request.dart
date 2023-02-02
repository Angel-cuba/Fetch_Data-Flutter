import 'package:http/http.dart' as http;

class HTTPRequest {
  // ! Fetch all items
  Future<List<Map>> getItems() async {
    List<Map> items = [];

    //? Fetch all the data from the API
    return items;
  }

//!Fetch details of a single user
  Future<Map> getSingleUser(String id) async {
    Map item = {};

    //? Fetch the data from the API
    return item;
  }

  //! Add a new item to the API
  Future<bool> addItem(Map item) async {
    bool result = false;
    //? Add the item to the API
    return result;
  }

  //! Update an item in the API
  Future<bool> updateItem(Map item, String id) async {
    bool result = false;
    //? Update the item in the API
    return result;
  }

  //! Delete an item from the API
  Future<bool> deleteItem(String id) async {
    bool result = false;
    //? Delete the item from the API
    return result;
  }
}
