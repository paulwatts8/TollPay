import 'package:flutter/material.dart';

const headerstyle = TextStyle( 
  fontWeight: FontWeight.bold,
   fontSize: 50.0, 
   color: Colors.indigo,
   fontFamily: 'Anton');

const textFieldDecoration = InputDecoration(
               hintStyle: TextStyle(color: Colors.grey),
              filled: true,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(color: Colors.indigo, width: 1),
               ),
);

const textDecoration = InputDecoration(
    filled: true,
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white, width: 1.0),
    ),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white, width: 2.0)));

       