


import 'package:flutter/material.dart';

class StylishCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  StylishCheckbox({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChanged(!value);
      },
      child: Container(
        width: 24.0,
        height: 24.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: value ? Colors.blue : Colors.transparent,
          border: Border.all(
            color: Colors.blue,
            width: 2.0,
          ),
        ),
        child: value
            ? Icon(
          Icons.check,
          size: 18.0,
          color: Colors.white,
        )
            : null,
      ),
    );
  }
}