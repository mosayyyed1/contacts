import 'package:flutter/material.dart';

class LabeledTextField extends StatelessWidget {
  final String labelText;
  final Function(String) onChanged;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;

  const LabeledTextField({
    super.key,
    required this.labelText,
    required this.onChanged,
    this.keyboardType = TextInputType.text,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(labelText: labelText),
      onChanged: onChanged,
      keyboardType: keyboardType,
      validator: validator,
    );
  }
}
