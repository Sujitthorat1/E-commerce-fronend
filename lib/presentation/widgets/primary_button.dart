import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final Color color;
  final Function()? onPressed;
  const PrimaryButton({required this.text, this.onPressed,this.color=Colors.blue, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: CupertinoButton(
        onPressed: onPressed,
        color: color,
        child: Text(text),
      ),
    );
  }
}
