import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String? txt;
  final Color? color;
  final Function()? fn;
  const MyButton({this.txt, this.color, this.fn});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: color!),
        borderRadius: BorderRadius.circular(5),
      ),
      child: TextButton(
        onPressed: fn!,
        child: Text(
          txt!,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: color!,
          ),
        ),
      ),
    );
  }
}
