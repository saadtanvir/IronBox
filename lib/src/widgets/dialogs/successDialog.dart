import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SuccessDialog extends StatelessWidget {
  final String successString;
  const SuccessDialog({Key key, this.successString}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: 200.0,
        width: 100.0,
        decoration: const BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(25.0)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.done,
              size: 50.0,
              color: Colors.green,
            ),
            const SizedBox(
              height: 20.0,
            ),
            Text(
              successString ?? "Success",
            ),
            const SizedBox(
              height: 30.0,
            ),
            TextButton(
              onPressed: () {
                Get.back();
              },
              style: ButtonStyle(
                padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(horizontal: 10.0),
                ),
                backgroundColor:
                    MaterialStateProperty.all(Theme.of(context).primaryColor),
                overlayColor: MaterialStateProperty.all(
                  Theme.of(context).accentColor.withOpacity(0.3),
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  const RoundedRectangleBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
              ),
              child: Text(
                "Okay",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
