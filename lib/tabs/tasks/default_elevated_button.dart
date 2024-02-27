import 'package:flutter/material.dart';
import 'package:todo/app_theme.dart';

class DefaultElevatedButton extends StatelessWidget {
  DefaultElevatedButton({required this.label,required this.onpressed});
  String label;
  void Function() onpressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onpressed,
        child: Text(label,style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppTheme.whitecolor),),
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).primaryColor,
        fixedSize: Size(MediaQuery.of(context).size.width, 52),
      ),
    );
  }
}

