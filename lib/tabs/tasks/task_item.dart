import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:todo/app_theme.dart';
import 'package:todo/firebase_utils.dart';
import 'package:todo/models/task_model.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo/tabs/tasks/tasks_provider.dart';
class TaskItem extends StatelessWidget {
  final TaskModel task;

  const TaskItem(this.task);

  @override
  Widget build(BuildContext context) {
    return
      Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Slidable(
          key: const ValueKey(0),
          startActionPane: ActionPane(
            // A motion is a widget used to control how the pane animates.
            motion: const ScrollMotion(),

            children: [
              // A SlidableAction can have an icon and/or a label.
              SlidableAction(
                  onPressed: (_) {
                    FirebaseUtils.deleteTaskFromFirestore(task.id).timeout(
                      Duration(milliseconds: 500),
                      onTimeout: (){
                        Provider.of<TasksProvider>(context,listen: false).getTasks();
                        Fluttertoast.showToast(
                          msg: "Task Deleted Successfully",
                          toastLength: Toast.LENGTH_SHORT,
                        );
                      },
                    ).catchError( (_){
                      Fluttertoast.showToast(
                        msg: "Something Went Wrong!",
                        toastLength: Toast.LENGTH_SHORT,
                      );
                    }  );

                  },
                  backgroundColor: AppTheme.redcolor,
                  foregroundColor: AppTheme.whitecolor,
                  icon: Icons.delete,
                  label: 'Delete',
                  borderRadius: BorderRadius.circular(10)
              ),
            ],
          ),
          child:
          Container(
            decoration: BoxDecoration(
              color: AppTheme.whitecolor,
              borderRadius: BorderRadius.circular(15),

            ),
            padding: EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  width: 4,
                  height: 50,
                  color: Theme
                      .of(context)
                      .primaryColor,
                  margin: EdgeInsetsDirectional.only(end: 8),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(task.title, style: Theme
                        .of(context)
                        .textTheme
                        .bodyMedium,),
                    SizedBox(height: 4,),
                    Text(task.description, style: Theme
                        .of(context)
                        .textTheme
                        .bodySmall,),
                  ],
                ),
                Spacer(),
                Container(
                    height: 34,
                    width: 69,
                    decoration: BoxDecoration(
                        color: Theme
                            .of(context)
                            .primaryColor,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Image.asset('assets/images/done_icon.png'))
              ],
            ),
          ),
        ),
      );
  }
}


