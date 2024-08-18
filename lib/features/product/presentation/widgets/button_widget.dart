import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String title;
  final bool isFilled;
  final double buttonWidth;
  final void Function() onPressed;
  const ButtonWidget(
      {super.key,
      required this.title,
      required this.isFilled,
      required this.buttonWidth,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 50,
        width: buttonWidth,
        margin: const EdgeInsets.symmetric(horizontal: 4.0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isFilled ? const Color(0xff3F51F3) : Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 1,
              offset: const Offset(1, 0),
            ),
          ],
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          border: Border.all(
            color: isFilled ? const Color(0xff3F51F3) : Colors.red,
            width: 2,
          ),
        ),
        child: Text(
          title,
          style: TextStyle(color: isFilled ? Colors.white : Colors.red),
        ),
      ),
    );
  }
}
