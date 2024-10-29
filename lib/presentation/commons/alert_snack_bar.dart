import 'package:flutter/material.dart';

final kAlertSnackBar = SnackBar(
  content: Text(
    'Si è verificato un errore. Riprova più tardi.',
    style: TextStyle(color: Colors.white),
  ),
  backgroundColor: Colors.red,
  duration: Duration(seconds: 3),
);
