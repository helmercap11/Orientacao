import 'package:flutter/material.dart';

import '../const/global_const.dart';


class CustomText extends StatelessWidget {
  final String text;
  final double size;
  final Color color;
  final FontWeight weight;


  const CustomText({required this.text, required this.size, required this.color,required this.weight});
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontSize: size ?? 16,
          color: color ?? black,
          fontWeight: weight ?? FontWeight.normal),
    );
  }
}
