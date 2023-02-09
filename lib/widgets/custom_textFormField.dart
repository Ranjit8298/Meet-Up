import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController txtController;
  final Function onChanged;
  final Function validator;
  final String hintText;
  final Widget prefixIcon;
  final String labelText;
  final TextInputType keyboardType;
  bool? obscureText;

  CustomTextFormField({
    super.key,
    required this.txtController,
    required this.onChanged,
    required this.validator,
    required this.hintText,
    required this.prefixIcon,
    required this.labelText,
    required this.keyboardType,
    this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: TextFormField(
        keyboardType: keyboardType,
        controller: txtController,
        enableSuggestions: true,
        autocorrect: true,
        obscureText: obscureText ?? false,
        validator: validator(txtController),
        onChanged: onChanged(txtController),
        style: const TextStyle(
          fontSize: 15.5,
          color: Colors.black,
        ),
        decoration: InputDecoration(
          focusColor: Colors.red,
          //add prefix icon
          prefixIcon: prefixIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red, width: 2.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
          fillColor: Colors.grey,
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
          labelText: labelText,
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
