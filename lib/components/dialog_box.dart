import 'package:flutter/material.dart';

class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;
  DialogBox(
      {required this.controller,
        required this.onSave,
        required this.onCancel});

final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey.shade900,
      content: Form(
        key: _formKey,
        child: TextFormField(
        controller: controller,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: 'Add a new task',
          labelStyle: TextStyle(color: Colors.white),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
          validator: (value){
          if(value == null || value.isEmpty){
            return 'Please enter your task';
          }else{
            return null;
          }
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
        ),
      ),
      actions: [
        ElevatedButton(
            onPressed: onCancel,
            child: Text(
              'cancel',
              style: TextStyle(color: Colors.grey.shade800),
            )),
        SizedBox(
          width: 35,
        ),
        ElevatedButton(
            onPressed: (){
              if(_formKey.currentState?.validate() == true){
                onSave();
              }
            },
            child: Text(
              'Save',
              style: TextStyle(color: Colors.grey.shade800),
            )),
      ],
    );
  }
}

