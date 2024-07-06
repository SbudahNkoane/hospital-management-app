import 'package:flutter/material.dart';

class ApplicationTextFormField extends StatefulWidget {
  const ApplicationTextFormField({
    super.key,
    required this.labelText,
    required this.hasIconButton,
    this.prefixIcon,
    this.onSuffixIconPressed,
    this.suffixIcon,
    this.counter,
    this.maxLength,
    this.controller,
    required this.keyboardType,
    this.validator,
    this.obscureText = false,
    this.textCapitalization = TextCapitalization.none,
    this.suffix,
    this.maxLines,
  });
  final bool obscureText;
  final String labelText;
  final bool hasIconButton;
  final IconData? prefixIcon;
  final void Function()? onSuffixIconPressed;
  final IconData? suffixIcon;
  final int? counter;
  final int? maxLines;
  final int? maxLength;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final String? Function(String? text)? validator;
  final TextCapitalization? textCapitalization;
  final Widget? suffix;
  @override
  State<ApplicationTextFormField> createState() =>
      _ApplicationTextFormFieldState();
}

class _ApplicationTextFormFieldState extends State<ApplicationTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: widget.maxLines ?? 1,
      obscureText: widget.obscureText,
      textCapitalization: widget.textCapitalization!,
      controller: widget.controller,
      maxLength: widget.maxLength,
      keyboardType: widget.keyboardType,
      validator: widget.validator,
      style: const TextStyle(fontSize: 14),
      decoration: InputDecoration(
        errorMaxLines: 2,
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(
            width: 1,
            color: Color.fromARGB(255, 251, 0, 0),
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(
            width: 1,
            color: Color.fromARGB(255, 250, 20, 3),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(
            width: 1,
            color: Color(0xFFD9458D),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(
            width: 1,
            color: Color.fromARGB(255, 59, 59, 59),
          ),
        ),
        prefixIcon: widget.prefixIcon != null
            ? Icon(
                widget.prefixIcon,
                size: 18,
              )
            : null,
        suffix: widget.suffix,
        suffixIcon: widget.hasIconButton == true
            ? IconButton(
                onPressed: widget.onSuffixIconPressed,
                icon: Icon(
                  widget.suffixIcon,
                  size: 18,
                ),
              )
            : const SizedBox(),
        labelText: widget.labelText,
        labelStyle: const TextStyle(
          fontSize: 14,
          color: Color(0xFF2C3847),
        ),
      ),
    );
  }
}
