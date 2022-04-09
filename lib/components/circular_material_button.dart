import 'package:flutter/material.dart';

class CircularMaterialButton extends StatelessWidget {
  final IconData icon;
  final void Function()? onPressed;

  const CircularMaterialButton({
    Key? key,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      child: Icon(icon, color: Colors.white),
      shape: const CircleBorder(),
      padding: const EdgeInsets.all(2.0),
      minWidth: double.minPositive,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      elevation: 0,
      color: Colors.black.withOpacity(0.5),
      onPressed: onPressed,
    );
  }
}
