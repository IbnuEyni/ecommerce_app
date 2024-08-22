// CustomPasswordField Class
import 'package:flutter/material.dart';

class CustomPasswordField extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final bool isPasswordVisible;
  final VoidCallback onVisibilityChanged;

  const CustomPasswordField({
    required this.label,
    required this.hintText,
    required this.controller,
    required this.isPasswordVisible,
    required this.onVisibilityChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.02,
            color: Color(0xFF6F6F6F),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          height: 42,
          decoration: BoxDecoration(
            color: const Color(0xFFF2F2F2),
            borderRadius: const BorderRadius.all(
              Radius.circular(8),
            ),
            border: Border.all(
              color: const Color(0xFFDDDDDD),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller: controller,
              obscureText: !isPasswordVisible,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                hintText: hintText,
                hintStyle: const TextStyle(
                    color: Color.fromARGB(255, 180, 180, 180),
                    fontWeight: FontWeight.w300),
                suffixIcon: IconButton(
                  icon: Icon(
                    isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: onVisibilityChanged,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
