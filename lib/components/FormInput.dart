import 'package:flutter/material.dart';

class FormInput extends StatefulWidget {
  const FormInput({super.key});

  @override
  State<FormInput> createState() => _FormInputState();
}

class _FormInputState extends State<FormInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 30,
      color: Colors.red,
    );
  }
}
