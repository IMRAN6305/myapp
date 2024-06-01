import 'package:flutter/material.dart';

class TextFiled extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final TextInputType inputType;
  final String hintText;
  final IconData preIcon;
  final bool checkObscure;

  const TextFiled({super.key, 
    required this.controller,
    required this.labelText,
    required this.inputType,
    required this.hintText,
    required this.preIcon,
    this.checkObscure = false,
  });

  @override
  _TextFiledState createState() => _TextFiledState();
}

class _TextFiledState extends State<TextFiled> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: widget.inputType,
      controller: widget.controller,
      obscureText: widget.checkObscure ? _obscureText : false,
      decoration: InputDecoration(
        prefixIcon: Icon(widget.preIcon),
        labelText: widget.labelText,
        hintText: widget.hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide:const BorderSide(
            color: Colors.black,
          ),
        ),
        suffixIcon: widget.checkObscure
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : null,
      ),
    );
  }
}
