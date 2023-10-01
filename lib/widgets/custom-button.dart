// ignore_for_file: file_names

import 'package:flutter/material.dart';

class BuildButton extends StatelessWidget {
  const BuildButton({
    Key? key,
    required this.onTap,
    required this.title,

  }) : super(key: key);


  final VoidCallback onTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 45,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: Offset(0.2, 0.2),
            )
          ],
        ),
        child:  Center(
            child: Text(
              title,
              style: const TextStyle(
                  fontSize: 20,
                  color: Color(0xff78B691),
                  fontWeight: FontWeight.bold),
            )),
      ),
    );
  }
}