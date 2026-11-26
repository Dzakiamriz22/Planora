import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';
import 'package:planora/core/format/formatters.dart';

class RupiahInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digits = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (digits.isEmpty) {
      return const TextEditingValue(
        text: '',
        selection: TextSelection.collapsed(offset: 0),
      );
    }
    final value = int.tryParse(digits);
    if (value == null) return oldValue;
    final formatted = AppFormatters.number(value);
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}

int parseRupiahInput(String raw) {
  final digits = raw.replaceAll(RegExp(r'[^0-9]'), '');
  if (digits.isEmpty) return 0;
  return int.tryParse(digits) ?? 0;
}

class RupiahTextField extends StatelessWidget {
  const RupiahTextField({
    super.key,
    required this.controller,
    required this.label,
    this.hintText = '0',
    this.helperText,
    this.validator,
    this.onChanged,
    this.enabled = true,
  });

  final TextEditingController controller;
  final String label;
  final String? hintText;
  final String? helperText;
  final String? Function(String?)? validator;
  final ValueChanged<int>? onChanged;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      enabled: enabled,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        RupiahInputFormatter(),
      ],
      decoration: InputDecoration(
        labelText: label.isEmpty ? null : label,
        hintText: hintText,
        prefixText: 'Rp ',
        helperText: helperText,
      ),
      validator: validator,
      onChanged: onChanged == null
          ? null
          : (value) => onChanged!(parseRupiahInput(value)),
    );
  }
}

