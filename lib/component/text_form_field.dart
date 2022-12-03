import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class textFormField extends StatelessWidget {
  final TextEditingController cotroller;
  final String hintText;
  final Widget prefixIcon;
  final bool? obsecure;

  const textFormField({
    required this.cotroller,
    required this.hintText,
    this.obsecure,
    required this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: TextFormField(
        controller: cotroller,
        obscureText: obsecure != null ? obsecure! : false,
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(color: Colors.grey)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(color: Colors.grey)),
          hintText: hintText,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(color: Colors.grey)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide(color: Colors.grey)),
        ),
      ),
    );
  }
}
