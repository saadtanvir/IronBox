import 'package:intl/intl.dart';
import 'package:ironbox/src/models/user.dart';
import '../helpers/app_constants.dart' as Constants;

class Review {
  String id;
  String message;
  String trainer_id;
  String trainee_id;
  String date;
  String rating;
  User trainee;
  DateFormat _dateFormatter = DateFormat(Constants.dateStringFormat);

  Review();

  Review.fromJSON(Map<String, dynamic> jsonMap) {
    id = jsonMap['id'] != null ? jsonMap['id'].toString() : "";
    message = jsonMap['message'] != null ? jsonMap['message'] : "";
    trainer_id = jsonMap['review_for'] != null ? jsonMap['review_for'] : "";
    trainee_id = jsonMap['review_by'] != null ? jsonMap['review_by'] : "";
    rating = jsonMap['rating'] != null ? jsonMap['rating'] : "";
    date = jsonMap['created_at'] != null
        ? _dateFormatter.format(DateTime.parse(jsonMap['created_at']))
        : "";
    trainee = jsonMap['user'] != null && (jsonMap['user'] as List).length > 0
        ? User.fromJSON(jsonMap['user'][0])
        : new User();
  }

  Map toMap() {
    var map = new Map<String, String>();
    map['review_for'] = trainer_id;
    map['review_by'] = trainee_id;
    map['message'] = message;
    return map;
  }
}
