import 'package:flutter/material.dart';

class BacsicButton extends StatelessWidget {
  const BacsicButton(
      {super.key,
      required this.onPressed,
      required this.label,
      required this.width});
  final VoidCallback? onPressed;
  final String? label;
  final double? width;
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onPressed,
        child: Container(
          width: width,
          alignment: Alignment.center,
          padding: const EdgeInsets.all(20 * 0.85),
          decoration: const BoxDecoration(
              color: Color(0xff3564ce),
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              )),
          child: Text(
            label!,
            style: Theme.of(context)
                .textTheme
                .button
                ?.copyWith(color: Colors.white),
          ),
        ));
  }
}
