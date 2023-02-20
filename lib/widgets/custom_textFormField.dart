import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController txtController;
  final Function onChanged;
  final Function validator;
  final String hintText;
  final Widget prefixIcon;
  final String labelText;
  final TextInputType keyboardType;
  int? maxLength;
  TextInputAction? textInputAction;
  bool? passwordField;

  CustomTextFormField({
    super.key,
    required this.txtController,
    required this.onChanged,
    required this.validator,
    required this.hintText,
    required this.prefixIcon,
    required this.labelText,
    required this.keyboardType,
    this.maxLength,
    this.textInputAction,
    this.passwordField,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: TextFormField(
        keyboardType: widget.keyboardType,
        controller: widget.txtController,
        enableSuggestions: true,
        autocorrect: true,
        obscureText: widget.passwordField == true ? obscureText : false,
        obscuringCharacter: '*',
        validator: (value) => widget.validator(value),
        onChanged: widget.onChanged(widget.txtController),
        maxLength: widget.maxLength,
        textInputAction: widget.textInputAction,
        style: const TextStyle(
          fontSize: 15.5,
          color: Colors.black,
        ),
        decoration: InputDecoration(
          focusColor: Colors.red,
          counterText: '',
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.passwordField == true
              ? InkWell(
                  onTap: () {
                    setState(() {
                      if (obscureText == true) {
                        obscureText = false;
                      } else {
                        obscureText = true;
                      }
                    });
                  },
                  child: Icon(obscureText == true
                      ? Icons.visibility_off
                      : Icons.visibility))
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red, width: 2.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
          fillColor: Colors.grey,
          hintText: widget.hintText,
          hintStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
          labelText: widget.labelText,
          labelStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
