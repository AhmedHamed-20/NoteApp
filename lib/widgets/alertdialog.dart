import 'package:flutter/material.dart';

Widget alertDialog(Function ifpressYes,BuildContext context){
  return AlertDialog(
    title: Text('Are you sure ?'),
    content: Text('Delete this note ?'),
    actions: [

      TextButton(onPressed: (){
     Navigator.pop(context);
      }, child: Text('No'),),
      TextButton(onPressed: (){
        ifpressYes();
      }, child: Text('Yes'),),
    ],
  );
}