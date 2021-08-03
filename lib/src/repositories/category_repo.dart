import 'dart:convert';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/helper.dart';
import '../models/category.dart';
import 'package:http/http.dart' as http;

Future<Stream<Category>> getAppCategories({String id}) async {
  print("getting categories");
  Uri uri = Helper.getUri('categories');
  SharedPreferences prefs = await SharedPreferences.getInstance();
  print('URI for gettiing categories: ' + uri.toString());
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
      // print(data);
      Helper.storeAppMainCategoryInSP(data, prefs);
      return Category.fromJSON(data);
    });
  } on SocketException {
    print("Socket Exception Getting Categories: ");
    throw SocketException("Socket exception");
  } catch (e) {
    print("error caught");
    print("Category Repo Error: $e");
    return new Stream.value(new Category.fromJSON({}));
  }
}

Future<Stream<Category>> getSubCategories() async {
  print("getting sub categories");
  Uri uri = Helper.getUri('sub_categories');
  print('URI for gettiing sub categories: ' + uri.toString());
  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', uri));

    return streamedRest.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .map((data) => Helper.getData(data))
        .expand((data) => (data as List))
        .map((data) {
      print("printing sub categories data");
      // print(data);
      return Category.fromJSON(data);
    });
  } on SocketException {
    print("Socket Exception Getting Sub Categories: ");
    throw SocketException("Socket exception");
  } catch (e) {
    print("error caught");
    print("Category Repo Error: $e");
    return new Stream.value(new Category.fromJSON({}));
  }
}

Future<Stream<Category>> getChildCategories() async {
  print("getting child categories");
  Uri uri = Helper.getUri('child_categories');
  print('URI for gettiing sub categories: ' + uri.toString());
  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', uri));

    return streamedRest.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .map((data) => Helper.getData(data))
        .expand((data) => (data as List))
        .map((data) {
      print("printing child categories data");
      // print(data);
      return Category.fromJSON(data);
    });
  } on SocketException {
    print("Socket Exception Getting Child Categories: ");
    throw SocketException("Socket exception");
  } catch (e) {
    print("error caught");
    print("Category Repo Error: $e");
    return new Stream.value(new Category.fromJSON({}));
  }
}
