import 'package:ironbox/src/models/user.dart';

class Subscription {
  double subPrice;
  String id;
  String startDate;
  String endDate;
  String status;
  String traineeId;
  String trainerId;
  User trainers;

  Subscription();

  Subscription.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'].toString();
      subPrice = jsonMap['sub_price'] != null
          ? double.parse(jsonMap['sub_price'])
          : 0.0;
      startDate = jsonMap['start_date'] != null ? jsonMap['start_date'] : "";
      endDate = jsonMap['end_date'] != null ? jsonMap['end_date'] : "";
      status = jsonMap['status'] != null ? jsonMap['status'].toString() : "0";
      traineeId = jsonMap['trainee_id'] != null ? jsonMap['trainee_id'] : "";
      trainerId = jsonMap['trainer_id'] != null ? jsonMap['trainer_id'] : "";
      trainers = jsonMap['trainers'] != null &&
              (jsonMap['trainers'] as List).length > 0
          ? User.fromJSON(jsonMap['trainers'][0])
          : new User();
    } catch (e) {
      print("Subscription Model Error: $e");
    }
  }

  Map toMap() {
    var map = new Map<String, String>();
    map['status'] = status;
    map['end_date'] = endDate;
    map['start_date'] = startDate;
    map['trainee_id'] = traineeId;
    map['trainer_id'] = trainerId;
    map['sub_price'] = subPrice.toString();
    return map;
  }
}
