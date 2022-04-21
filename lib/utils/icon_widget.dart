import 'package:flutter/material.dart';

class IconWidget extends StatelessWidget {
  final color;
  final icon;

  const IconWidget({Key? key, required this.color, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(6),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
      child: Icon(
        icon,
        color: Colors.white,
      ),
    );
  }
}
