import 'package:flutter/material.dart';
import 'package:ironbox/src/models/questions.dart';
import 'package:ironbox/src/models/user.dart';
import 'package:ironbox/src/widgets/trainerProfileDetails.dart';
import '../helpers/app_constants.dart' as Constants;

class PlanRequestQAWidget extends StatelessWidget {
  final List<Question> questions;
  const PlanRequestQAWidget({Key key, @required this.questions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
