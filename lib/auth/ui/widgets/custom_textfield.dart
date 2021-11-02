import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  String label;
  Function validation;
  TextEditingController controller;
  CustomTextField({
    @required this.label,
    @required this.validation,
    @required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: TextFormField(
        controller: this.controller,
        validator: (v) => this.validation(v),
        decoration: InputDecoration(
            labelText: this.label,
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(15))),
      ),
    );
  }
}
