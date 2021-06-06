import 'dart:convert';
import 'dart:io';
import 'package:ironbox/src/helpers/helper.dart';
import 'package:ironbox/src/models/category.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

Future<Stream<Category>> getCategories({String id}) async {
  print("getting categories");
  Uri uri = Helper.getUri('catagories');
  print('URI for gettiing categories: ' + uri.toString());
  // Map<String, dynamic> _queryParams = {};
  // SharedPreferences prefs = await SharedPreferences.getInstance();
  // uri = uri.replace(queryParameters: _queryParams);
  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', uri));

    return streamedRest.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .map((data) => Helper.getData(data))
        .expand((data) => (data as List))
        .map((data) {
      print("printing categories data");
      print(data);
      return Category.fromJSON(data);
    });
  } on SocketException {
    print("Socket Exception occured: ");
    throw SocketException("Socket exception");
  } catch (e) {
    print("error caught");
    print("Category Repo Error: $e");
    return new Stream.value(new Category.fromJSON({}));
  }
}
