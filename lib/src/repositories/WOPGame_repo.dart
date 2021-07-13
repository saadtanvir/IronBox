import 'dart:convert';
import 'dart:io';
import 'package:ironbox/src/helpers/helper.dart';
import 'package:http/http.dart' as http;
import 'package:ironbox/src/models/userWorkoutPlanGame.dart';

Future<Stream<UserWorkoutPlanGame>> getDayGames(String detailsId) async {
  Uri uri = Helper.getUri('fetch_user_plans_games/$detailsId');
  print("URI For Getting Day Games: ${uri.toString()}");
  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', uri));

    return streamedRest.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .map((data) {
          print(data);
          return Helper.getData(data);
        })
        .expand((data) => (data as List))
        .map((data) {
          print("printing games data");
          print(data);
          return UserWorkoutPlanGame.fromJSON(data);
        });
  } on SocketException {
    print("WOP Game Repo Socket Exception: ");
    throw SocketException("Socket exception");
  } catch (e) {
    print("error caught");
    print("WOP Game Repo Error: $e");
    return new Stream.value(new UserWorkoutPlanGame.fromJSON({}));
  }
}
