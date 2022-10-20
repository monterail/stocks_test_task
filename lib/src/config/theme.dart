import 'package:flutter/material.dart';

class AppTheme {
  ThemeData get appTheme => ThemeData().copyWith(
        colorScheme: ThemeData().colorScheme.copyWith(
              primary: Colors.green,
            ),
      );
}
