import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({required this.hintText,this.maxLines,required this.controller});
  final String hintText;
  final int? maxLines;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        //  to hide counter that appear from using max length
        counter: SizedBox()
      ),
      maxLines: maxLines,

    );
  }
}
