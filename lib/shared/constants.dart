import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
  // hintText:, //Displayed above Textbox after user enters text (Disappears when user enters data)
  // labelText:, //Displayed above Textbox after user enters text
  fillColor: Colors.white,
  filled: true,
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.white,
      width: 2.0,
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.pink,
      width: 2.0,
    ),
  ),
);
