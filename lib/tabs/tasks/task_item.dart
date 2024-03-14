import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:todo/app_theme.dart';
import 'package:todo/auth/user_provider.dart';
import 'package:todo/firebase_utils.dart';
import 'package:todo/models/task_model.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo/tabs/settings/settings_provider.dart';
import 'package:todo/tabs/tasks/edit_screen.dart';
import 'package:todo/tabs/tasks/tasks_provider.dart';
class TaskItem extends StatefulWidget {
  final TaskModel task;

  const TaskItem(this.task);

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
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
                    final userId= Provider.of<UserProvider>(context,listen: false).currentUser!.id;
                    FirebaseUtils.deleteTaskFromFirestore(
                    userId ,
                    widget.task.id
                    ).then(
                       (_){
                        Provider.of<TasksProvider>(context,listen: false).getTasks(userId);
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
                    }
                    );

                  },
                  backgroundColor: AppTheme.redcolor,
                  foregroundColor: AppTheme.whitecolor,
                  icon: Icons.delete,
                  label: 'Delete',
                  borderRadius: BorderRadius.circular(10)
              ),
              SlidableAction(
                  onPressed: (_) {
                    Navigator.push(
                        context,
                      PageTransition(
                          type: PageTransitionType.leftToRight,
                          child: EditTaskScreen(taskModel:widget.task,),
                    )
                    );
                  },
                  backgroundColor: AppTheme.primaruColor,
                  foregroundColor: AppTheme.whitecolor,
                  icon: Icons.delete,
                  label: 'Edit',
                  borderRadius: BorderRadius.circular(10)
              ),

            ],
          ),
          child:
          Container(
            decoration: BoxDecoration(
              color: Provider.of<settingsProvider>(context).backGround_bottom_sheet_settings_container,
              borderRadius: BorderRadius.circular(15),

            ),
            padding: EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  width: 4,
                  height: 50,
                  color:widget.task.isDone==false ?
                       Theme
                      .of(context)
                      .primaryColor:
                       AppTheme.greencolor,
                  margin: EdgeInsetsDirectional.only(end: 8),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.task.title, style:Theme
                        .of(context)
                        .textTheme
                        .bodyMedium?.copyWith(color: AppTheme.primaruColor),
                    ),
                    SizedBox(height: 4,),
                    Text(widget.task.description, style: Theme
                        .of(context)
                        .textTheme
                        .bodyMedium?.copyWith(color: AppTheme.primaruColor)
                      ,
                    ),
                  ],

                ),
                Spacer(),
                widget.task.isDone==true ?
                    Container(
                      child: Text(
                        'Done!',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppTheme.greencolor
                        )
                      ),
                    ) :
                InkWell(
                  onTap: (){
                    if(widget.task.isDone)return;
                    widget.task.isDone=true;
                    FirebaseUtils.UpdateTask(Provider.of<UserProvider>(context,listen: false).currentUser!.id, widget.task);
                    setState(() {});
                  },
                  child: Container(
                      height: 34,
                      width: 69,
                      decoration: BoxDecoration(
                          color: Theme
                              .of(context)
                              .primaryColor,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Image.asset('assets/images/done_icon.png')),
                )
              ],
            ),
          ),
        ),
      );
  }
}


