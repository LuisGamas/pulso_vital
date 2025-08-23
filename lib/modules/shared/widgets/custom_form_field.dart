// 🐦 Flutter imports:
import 'package:flutter/material.dart';

/// A custom, reusable text form field widget.
///
/// This widget provides a standardized look and behavior for text input fields
/// throughout the application. It simplifies the creation of text fields by
/// abstracting away common decoration and validation logic, ensuring a
/// consistent user interface.
class CustomFormField extends StatelessWidget {
  /// The label text for the form field.
  final String? label;

  /// The hint text to display inside the form field.
  final String? hint;

  /// The error message to display below the field when validation fails.
  final String? errorMessage;

  /// A flag to enable or disable the text field.
  ///
  /// Defaults to `true`.
  final bool? enabled;

  /// An optional icon to display on the left side of the field.
  final IconData? leftIcon;

  /// A callback function that is called whenever the text field's value changes.
  final Function(String)? onChanged;

  /// A validator function for the text field.
  ///
  /// This function takes the current value and returns an error message string
  /// or `null` if the value is valid.
  final String? Function(String?)? validator;

  /// The type of keyboard to display for the text field.
  final TextInputType? keyboardType;

  /// Creates a [CustomFormField] instance.
  ///
  /// All parameters are optional, allowing for flexible configuration.
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

    // Defines the standard border style for the input field.
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
    );

    return TextFormField(
      onChanged: onChanged,
      validator: validator,
      enabled: enabled,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        // Set the label text.
        label: label != null ? Text(label!) : null,
        // Set the hint text.
        hintText: hint,
        // Set the error message.
        errorText: errorMessage,
        // Set the focus color for the border.
        focusColor: colors.primary,
        // Define the border for the enabled state.
        enabledBorder: border.copyWith(borderSide: BorderSide(color: colors.outline)),
        // Define the border for the disabled state.
        disabledBorder: border.copyWith(borderSide: BorderSide(color: colors.surfaceContainer)),
        // Define the border for the focused state.
        focusedBorder: border.copyWith(borderSide: BorderSide(color: colors.primary)),
        // Define the border for the error state.
        errorBorder: border.copyWith(borderSide: BorderSide(color: colors.error)),
        // Define the border for the focused error state.
        focusedErrorBorder: border.copyWith(borderSide: BorderSide(color: colors.error)),
        // Conditionally set the prefix icon based on whether an icon is provided.
        prefixIcon: leftIcon != null
            ? Icon(
                leftIcon,
                color: enabled! ? colors.primary : colors.surfaceContainer,
              )
            : null,
      ),
    );
  }
}