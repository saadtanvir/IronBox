// import 'dart:io';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../helpers/app_constants.dart' as Constants;

// alert dialog for Android
// cupertinoAlert for Ios
// uncomment file to use

// class ConfirmationDialog extends StatelessWidget {
//   final String message;
//   final Function onConfirmMethod;
//   final Function onCancel;
//   ConfirmationDialog(this.message, this.onConfirmMethod,
//       {Key key, this.onCancel})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Platform.isAndroid
//         ? AlertDialog(
//             title: Text(message),
//             actions: [
//               TextButton(
//                 onPressed: () async {
//                   onConfirmMethod();
//                 },
//                 // style: ButtonStyle(
//                 //   padding: MaterialStateProperty.all(
//                 //     const EdgeInsets.symmetric(horizontal: 30.0),
//                 //   ),
//                 //   backgroundColor:
//                 //       MaterialStateProperty.all(Theme.of(context).primaryColor),
//                 //   overlayColor: MaterialStateProperty.all(
//                 //     Theme.of(context).accentColor.withOpacity(0.3),
//                 //   ),
//                 //   shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                 //     RoundedRectangleBorder(
//                 //       borderRadius:
//                 //           const BorderRadius.all(Radius.circular(15.0)),
//                 //     ),
//                 //   ),
//                 // ),
//                 child: Text(
//                   "Yes",
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     color: Theme.of(context).primaryColor,
//                   ),
//                 ),
//               ),
//               TextButton(
//                 onPressed: () async {
//                   onCancel() ?? Get.back();
//                 },
//                 // style: ButtonStyle(
//                 //   padding: MaterialStateProperty.all(
//                 //     const EdgeInsets.symmetric(horizontal: 30.0),
//                 //   ),
//                 //   backgroundColor:
//                 //       MaterialStateProperty.all(Theme.of(context).primaryColor),
//                 //   overlayColor: MaterialStateProperty.all(
//                 //     Theme.of(context).accentColor.withOpacity(0.3),
//                 //   ),
//                 //   shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                 //     RoundedRectangleBorder(
//                 //       borderRadius:
//                 //           const BorderRadius.all(Radius.circular(15.0)),
//                 //     ),
//                 //   ),
//                 // ),
//                 child: Text(
//                   "No",
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     color: Theme.of(context).primaryColor,
//                   ),
//                 ),
//               ),
//             ],
//           )
//         : CupertinoAlertDialog(
//             content: Text(
//               message,
//             ),
//             actions: [
//               CupertinoDialogAction(
//                 onPressed: () {
//                   onConfirmMethod();
//                 },
//                 child: Text("Yes"),
//               ),
//               CupertinoDialogAction(
//                 onPressed: () {
//                   onCancel() ?? Get.back();
//                 },
//                 child: Text("No"),
//               ),
//             ],
//           );
//   }
// }
