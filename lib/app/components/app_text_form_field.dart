import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school_app/app/components/app_text.dart';

class AppTextFormField extends StatefulWidget {
  final String label;
  final bool isRequired;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final String? errorMessage;
  final bool isPassword;
  final EdgeInsetsGeometry? padding;
  final TextEditingController? controller;

  const AppTextFormField({
    super.key,
    required this.label,
    this.onChanged,
    this.validator,
    this.errorMessage,
    this.padding,
    this.controller,
    this.isRequired = false,
    this.isPassword = false,
  });

  @override
  AppTextFormFieldState createState() => AppTextFormFieldState();
}

class AppTextFormFieldState extends State<AppTextFormField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ?? EdgeInsets.symmetric(vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 10.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppTextBodyLarge(widget.label),
                if (widget.isRequired)
                  const AppTextBodyLarge(
                    ' *',
                    color: Colors.red,
                  ),
              ],
            ),
          ),
          TextFormField(
            onChanged: widget.onChanged,
            obscureText: widget.isPassword ? _obscureText : false,
            controller: widget.controller,
            validator: widget.validator,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              suffixIcon: widget.isPassword
                  ? IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () => setState(() {
                        _obscureText = !_obscureText;
                      }),
                    )
                  : null,
            ),
          ),
          if (widget.errorMessage != null && widget.errorMessage!.isNotEmpty)
            Padding(
              padding: EdgeInsets.only(top: 10.h),
              child: AppTextBodySmall(
                widget.errorMessage!,
                color: Colors.red,
              ),
            ),
        ],
      ),
    );
  }
}
