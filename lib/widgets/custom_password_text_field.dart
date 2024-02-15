import 'package:flutter/material.dart';

class CustomPasswordFormTextField extends StatefulWidget {
  CustomPasswordFormTextField({
    super.key,
    this.onChanged,
    this.hintText,
    this.obscureText = false,
  });

  String? hintText;
  Function(String)? onChanged;
  bool? obscureText;

  @override
  State<CustomPasswordFormTextField> createState() =>
      _CustomPasswordFormTextFieldState();
}

class _CustomPasswordFormTextFieldState
    extends State<CustomPasswordFormTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: widget.obscureText!,
      validator: (data) {
        if (data!.isEmpty) {
          return 'Field is required';
        }
        return null;
      },
      style: const TextStyle(color: Colors.white),
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        suffixIcon: IconButton(
            icon: widget.obscureText!
                ? const Icon(
                    Icons.visibility,
                    color: Colors.white,
                  )
                : const Icon(
                    Icons.visibility_off,
                    color: Colors.white,
                  ),
            onPressed: () {
              setState(() {
                widget.obscureText = !widget.obscureText!;
              });
            }),
        hintText: widget.hintText,
        hintStyle: const TextStyle(color: Colors.white),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
