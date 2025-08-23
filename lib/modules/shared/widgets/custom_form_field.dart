// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// Custom widget to display a text field
class CustomFormField extends StatelessWidget {
  final String? label;
  final String? hint;
  final String? errorMessage;
  final bool? enabled;
  final IconData? leftIcon;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;

  const CustomFormField({
    super.key,
    this.label,
    this.hint,
    this.errorMessage,
    this.enabled = true,
    this.leftIcon,
    this.onChanged,
    this.validator,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
    );

    return TextFormField(
      onChanged: onChanged,
      validator: validator,
      enabled: enabled,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        label: label != null ? Text(label!) : null,
        hintText: hint,
        errorText: errorMessage,
        focusColor: colors.primary,
        enabledBorder: border.copyWith(borderSide: BorderSide(color: colors.outline)),
        disabledBorder: border.copyWith(borderSide: BorderSide(color: colors.surfaceContainer)),
        focusedBorder: border.copyWith(borderSide: BorderSide(color: colors.primary)),
        errorBorder: border.copyWith(borderSide: BorderSide(color: colors.error)),
        focusedErrorBorder: border.copyWith(borderSide: BorderSide(color: colors.error)),
        prefixIcon: leftIcon != null 
          ? Icon(leftIcon, color: enabled! ? colors.primary : colors.surfaceContainer,) 
          : null,
      ),
    );
  }
}