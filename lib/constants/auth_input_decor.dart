
import 'package:flutter/material.dart';

import 'common_size.dart';

InputDecoration textInputDecor(String hint) {
  return InputDecoration(
    hintText: hint,
    enabledBorder: activeInputBorder(),
    focusedBorder: activeInputBorder(),
    focusedErrorBorder: errorInputBorder(),
    errorBorder: errorInputBorder(),
    filled: true,
    fillColor: Colors.grey[100],

  );
}

OutlineInputBorder errorInputBorder() {
  return OutlineInputBorder(
    borderSide:  BorderSide(
      color: Colors.redAccent,
    ),
    borderRadius: BorderRadius.circular(common_s_gap),
  );
}

OutlineInputBorder activeInputBorder() {
  return OutlineInputBorder(
    borderSide:  BorderSide(
      color: Colors.grey,
    ),
    borderRadius: BorderRadius.circular(common_s_gap),
  );
}