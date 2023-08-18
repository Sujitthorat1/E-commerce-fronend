import 'package:ecommerce/core/ui.dart';
import 'package:flutter/cupertino.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final Color? color;
  final Function()? onPressed;
  const PrimaryButton({required this.text, this.onPressed,this.color, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: CupertinoButton(
        onPressed: onPressed,
        color: color ?? AppColors.accent,
        child: Text(text),
      ),
    );
  }
}
