import 'package:flutter/material.dart';

class BlockButtonWidget extends StatelessWidget {
  const BlockButtonWidget(
      {Key key,
      @required this.color,
      @required this.text,
      @required this.onPressed})
      : super(key: key);

  final MaterialStateProperty<Color> color;
  final Text text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        // boxShadow: [
        //   // BoxShadow(
        //   //   color: this.color.withOpacity(0.4),
        //   //   blurRadius: 70,
        //   //   offset: Offset(0, 10),
        //   // ),
        //   BoxShadow(
        //     color: Theme.of(context).primaryColor,
        //     blurRadius: 10,
        //     offset: Offset(0, 2),
        //   ),
        // ],
        borderRadius: const BorderRadius.all(const Radius.circular(100)),
      ),
      child: TextButton(
        onPressed: this.onPressed,
        style: ButtonStyle(
          padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(horizontal: 30, vertical: 14)),
          backgroundColor: this.color,
          shape: MaterialStateProperty.all(StadiumBorder()),
        ),
        child: this.text,
      ),
    );
  }
}
