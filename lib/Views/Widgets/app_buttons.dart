import 'package:flutter/material.dart';

class ApplicationPrimaryButton extends StatefulWidget {
  const ApplicationPrimaryButton({
    super.key,
    required this.child,
    required this.onPressed,
    required this.width,
    required this.height,
  });
  final Widget? child;
  final void Function()? onPressed;
  final double width;
  final double height;
  @override
  State<ApplicationPrimaryButton> createState() =>
      _ApplicationPrimaryButtonState();
}

class _ApplicationPrimaryButtonState extends State<ApplicationPrimaryButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        fixedSize: Size(widget.width, widget.height),
        foregroundColor: const Color(0xFFFFFFFF),
        backgroundColor: const Color(0xFF2C3847),
      ),
      onPressed: widget.onPressed,
      child: widget.child,
    );
  }
}

class ApplicationSecondaryButton extends StatefulWidget {
  const ApplicationSecondaryButton({
    super.key,
    required this.backgroundColor,
    required this.child,
    required this.onPressed,
  });
  final Color? backgroundColor;
  final Widget child;
  final void Function()? onPressed;
  @override
  State<ApplicationSecondaryButton> createState() =>
      _ApplicationSecondaryButtonState();
}

class _ApplicationSecondaryButtonState
    extends State<ApplicationSecondaryButton> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        fixedSize: const Size(100, 50),
        backgroundColor: widget.backgroundColor,
        foregroundColor: const Color(0xFFFFFFFF),
      ),
      onPressed: widget.onPressed,
      child: widget.child,
    );
  }
}
