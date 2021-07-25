import 'package:flutter/material.dart';

class AdminLoginTextField extends StatelessWidget {
  final String labelText;
  final TextInputType type;
  final bool isObscure;
  final Function validator;
  final Function onChanged;
  final TextEditingController? controller;

  const AdminLoginTextField({
    required this.labelText,
    required this.type,
    required this.isObscure,
    required this.validator,
    required this.onChanged,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width*0.6,
        child: TextFormField(
          decoration: InputDecoration(
            border: new OutlineInputBorder(
                borderSide: new BorderSide(color: Colors.teal)),
            labelText: labelText,
            labelStyle: TextStyle(
                color: Colors.black45,
                letterSpacing: 1.2,
                fontSize: 20,
                fontWeight: FontWeight.w500),
          ),
          onChanged: (text) {
            onChanged(text);
          },
          style: TextStyle(
              //fontSize: 1 * SizeConfig.heightMultiplier,
              fontWeight: FontWeight.w400),
          obscureText: isObscure,
          obscuringCharacter: '*',
          validator: (text) {
            validator(text);
          },
          keyboardType: type,
          controller: controller,
        ),
      ),
    );
  }
}
