import 'package:flutter/material.dart';
import 'package:usafi_app/core/constants/app_colors.dart';
import 'package:usafi_app/core/constants/app_images.dart';

class AppTextField extends StatefulWidget {
  final String hint;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool isPassword;
  final IconData? prefixIcon;
  final int? maxLines;
  final int? maxLength;

  const AppTextField({
    super.key,
    required this.hint,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
    this.prefixIcon,
    this.maxLines = 1,
    this.maxLength = 30,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool _obscure = true;
  bool _focused = false;

  static const Color primaryPurple = Color(0xFF6447CE);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        boxShadow: _focused
            ? [
                BoxShadow(
                  color: primaryPurple.withOpacity(0.25),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ]
            : [],
      ),
      child: Focus(
        onFocusChange: (focus) {
          setState(() => _focused = focus);
        },
        child: TextField(
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          maxLines: widget.maxLines,
          maxLength: widget.maxLength,
          obscureText: widget.isPassword ? _obscure : false,
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: TextStyle(color: AppColors.textSecondary),
            counterText: "",
            prefixIcon: widget.prefixIcon != null
                ? Icon(widget.prefixIcon)
                : null,
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      child: _obscure
                          ? Image(
                              image: AssetImage(closeEye),
                              width: 20,
                            )
                          : Image(
                        image: AssetImage(openEye),
                        width: 20,
                      ),
                    ),
                    onPressed: () {
                      setState(() => _obscure = !_obscure);
                    },
                  )
                : null,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 16,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: primaryPurple, width: 1.6),
            ),
            filled: true,
            fillColor: Colors.white,
          ),
        ),
      ),
    );
  }
}
