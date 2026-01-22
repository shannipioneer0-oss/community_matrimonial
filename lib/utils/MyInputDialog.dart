

import 'package:flutter/material.dart';

class MyInputDialog extends StatefulWidget {

  final String title , description , btn_name;
  MyInputDialog(this.title, this.description, this.btn_name);

  @override
  _MyInputDialogState createState() => _MyInputDialogState();
}

class _MyInputDialogState extends State<MyInputDialog> {


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title ,style: TextStyle(fontSize: 16 ,color: Colors.black87),),
      content: Text(widget.description ,style: TextStyle(fontSize: 14 ,color: Colors.black87),),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context, widget.btn_name);  // Return text input
          },
          child: Text(widget.btn_name),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);  // Return text input
          },
          child: Text("Cancel"),
        )
      ],
    );
  }
}