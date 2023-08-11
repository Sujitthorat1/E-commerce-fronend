import 'package:ecommerce/core/ui.dart';
import 'package:flutter/cupertino.dart';
class LinkButton extends StatelessWidget {
  final String text;
  final Color? color;
  final Function()? onPressed;
  const LinkButton({required this.text, this.onPressed, this.color, super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton( 
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          color: color ?? AppColors.accent,
        ),
      ),
    );
  }
}
