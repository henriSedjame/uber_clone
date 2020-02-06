import 'package:flutter/material.dart';

class CurrentTextField extends StatelessWidget {
  
  final String hintText;
  final IconData icon;
  final TextEditingController controller;
  final ValueChanged<String> onSubmit;

  CurrentTextField({Key key, @required this.hintText, @required this.icon, this.controller, this.onSubmit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3.0),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Theme.of(context).accentColor,
                  blurRadius: 2.0,
                  spreadRadius: 1.0,
                  offset: Offset(1.0, 2.0))
            ]),
        child: TextField(
          controller: this.controller,
          cursorColor: Colors.black,
          decoration: InputDecoration(
              hintText: this.hintText,
              border: InputBorder.none,
              icon: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Icon(
                  this.icon,
                  color: Theme.of(context).primaryColor,
                ),
              )),
          onSubmitted: onSubmit ?? (value){},
        ));
  }
}
