import 'package:flutter/cupertino.dart';
import '../helpers/app_constants.dart' as Constants;

class Helper {
  BuildContext context;

  // Helper();
  Helper.of(BuildContext _context) {
    this.context = _context;
  }

  double getScreenHeight() {
    return MediaQuery.of(context).size.height;
  }

  double getScreenWidth() {
    return MediaQuery.of(context).size.width;
  }

  TextStyle textStyle(
      {double size = 15.0,
      Color color = Constants.primaryTextColor,
      double colorOpacity = 1.0,
      FontWeight font = FontWeight.normal}) {
    if (colorOpacity >= 0.0 && colorOpacity <= 1.0) {
      return TextStyle(
          color: color.withOpacity(colorOpacity),
          fontSize: size,
          fontWeight: font);
    } else {
      print("StackTrace: Color opacity value is out of range!");
      return TextStyle(
          color: color.withOpacity(1.0), fontSize: size, fontWeight: font);
    }
  }
}
