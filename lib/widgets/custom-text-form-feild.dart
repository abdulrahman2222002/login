// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';

class BuildTextFormFeild extends StatelessWidget {
  BuildTextFormFeild({
    required this.prfixIcon,
    this.keyboardType,
    this.isPassword,
    required this.onChanged,
    this.suffixIcon,
    this.visibilityTaped,
    Key? key,
  }) : super(key: key);
  IconData prfixIcon;
  IconData? suffixIcon;
  TextInputType? keyboardType;
  bool? isPassword;
  Function(String) onChanged;
  final VoidCallback? visibilityTaped;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6,
            offset: Offset(0.2, 0.2),
          )
        ],
      ),
      child: TextFormField(
        keyboardType: keyboardType,
        obscureText: isPassword!,
        validator: (data) {
          if (data!.isEmpty) {
            return 'field is required';
          }
        },
        onChanged: onChanged,
        style: const TextStyle(
          color: Colors.black54,
        ),
        decoration:  InputDecoration(
          prefixIcon: Icon(
            prfixIcon,
            color: const Color(0xff78B691),
          ),
          suffixIcon: GestureDetector(
            onTap: visibilityTaped,
            child: Icon(
              suffixIcon,
              color: const Color(0xff78B691),
            ),
          ),
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          border: InputBorder.none,
        ),
      ),
    );
  }
}