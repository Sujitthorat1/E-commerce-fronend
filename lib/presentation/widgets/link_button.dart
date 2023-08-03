import 'package:flutter/cupertino.dart';

class LinkButton extends StatelessWidget { 
    final String text;
    final Function()? onPressed;
  const LinkButton({required this.text, this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
   
    return CupertinoButton(
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
