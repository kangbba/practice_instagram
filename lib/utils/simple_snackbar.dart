import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void simpleSnackbar(BuildContext context, String s)
{
  SnackBar snackBar = SnackBar(
    content: Text(s), //snack bar의 내용. icon, button같은것도 가능하다.
    action: SnackBarAction( //추가로 작업을 넣기. 버튼넣기라 생각하면 편하다.
      label: 'OK', //버튼이름
      onPressed: (){
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      }, //버튼 눌렀을때.
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}