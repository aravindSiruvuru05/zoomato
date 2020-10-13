import 'package:flutter/material.dart';

class PrefixIconTextField extends StatelessWidget {
  final Function onChange;
  final IconData icon;
  final String text;
  final Function onSubmit;

  const PrefixIconTextField({
    Key key,
    this.onChange,
    this.icon,
    this.text,
    this.onSubmit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChange,
      onSubmitted: onSubmit,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.grey[300], width: 1, style: BorderStyle.solid),
        ),
//        border: OutlineInputBorder(
//          borderSide: BorderSide(
//              color: Colors.grey[300], width: 1, style: BorderStyle.solid),
//        ),
        prefixIcon: Icon(icon, color: Colors.black87),
        hintText: text,
        hintStyle: TextStyle(fontSize: 18),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.grey[300], width: 1, style: BorderStyle.solid),
        ),
      ),
    );
  }
}
