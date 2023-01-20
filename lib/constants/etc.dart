
import 'package:flutter/material.dart';

final ButtonStyle flatButtonStyle_white = TextButton.styleFrom(
  foregroundColor: Colors.black, minimumSize: Size(88, 44),
  padding: EdgeInsets.symmetric(horizontal: 16.0),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(2.0)),
  ),
  backgroundColor: Colors.white,
);
final ButtonStyle flatButtonStyle_blue = TextButton.styleFrom(
  foregroundColor: Colors.white, minimumSize: Size(88, 44),
  padding: EdgeInsets.symmetric(horizontal: 16.0),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(6.0)),
  ),
  backgroundColor: Colors.blue,
);
ButtonStyle FlatButtonStyle(Color _foregroundColor, Color _backgroundColor, bool useBorder)
{
  return TextButton.styleFrom(
    foregroundColor: _foregroundColor,
    minimumSize: Size(88, 44),
    padding: EdgeInsets.symmetric(horizontal: 16.0),
    shape: useBorder ? const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(6.0))) : null,
    backgroundColor: _backgroundColor,
  );
}
