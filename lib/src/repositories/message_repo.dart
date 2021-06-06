import 'dart:convert';
import 'dart:io';
import 'package:ironbox/src/helpers/helper.dart';
import 'package:ironbox/src/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:global_configuration/global_configuration.dart';

Future<Stream<User>> getUserContacts(String id) async {
  Uri uri = Helper.getUri('contacts');
  Map<String, dynamic> _queryParams = {"user_id": id};
  uri = uri.replace(queryParameters: _queryParams);
  print("URI For Getting User Contacts: ${uri.toString()}");
  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('post', uri));

    print(streamedRest.stream.map((data) {
      print(data);
    }));

    return streamedRest.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .map((data) {
          print(data);
          return Helper.getData(data);
        })
        .expand((data) => (data as List))
        .map((data) {
          print("printing contacts");
          print(data);
          return User.fromJSON(data);
        });
  } on SocketException {
    print("Message Repo Socket Exception: ");
    throw SocketException("Socket exception");
  } catch (e) {
    print("error caught");
    print("Message Repo Error: $e");
    return new Stream.value(new User.fromJSON({}));
  }
}
