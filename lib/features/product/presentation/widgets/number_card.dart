import 'package:flutter/material.dart';

class NumberCard extends StatelessWidget {
  final String size;
  const NumberCard({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 60,
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: size == '41' ? const Color(0xff3F51F3) : Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 1,
            offset: const Offset(1, 0),
          ),
        ],
        borderRadius: const BorderRadius.all(Radius.circular(5.0)),
        border: Border.all(
          color: size == '41' ? const Color(0xff3F51F3) : Colors.white10,
          width: 2,
        ),
      ),
      child: Text(
        size,
        style: TextStyle(
          color: size == '41' ? Colors.white : Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
