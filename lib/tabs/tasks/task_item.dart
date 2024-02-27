import 'package:flutter/material.dart';
import 'package:todo/app_theme.dart';

class TaskItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.whitecolor,
        borderRadius: BorderRadius.circular(15),

      ),
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.symmetric(horizontal: 16,vertical:8 ),
      child:
        Row(
          children: [
            Container(
              width: 4,
              height: 50,
              color: Theme.of(context).primaryColor,
              margin: EdgeInsetsDirectional.only(end: 8),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Task Title',style: Theme.of(context).textTheme.bodyMedium,),
                SizedBox(height: 4,),
                Text('Task Describtion',style: Theme.of(context).textTheme.bodySmall,),
              ],
            ),
            Spacer(),
            Container(
            height:34 ,
              width: 69,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(10)
              ),
                child: Image.asset('assets/images/done_icon.png'))
          ],
        )
    );
  }
}
