import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo/app_theme.dart';
import 'package:todo/auth/user_provider.dart';
import 'package:todo/firebase_utils.dart';
import 'package:todo/homescreen.dart';
import 'package:todo/tabs/settings/settings_provider.dart';
import 'package:todo/tabs/tasks/custom_text_form_field.dart';
import 'package:todo/tabs/tasks/default_elevated_button.dart';
import 'package:todo/tabs/tasks/tasks_provider.dart';

import '../../models/task_model.dart';
class EditTaskScreen extends StatefulWidget {
  //static const String routename='Edit_TAsk';
  TaskModel taskModel;
  EditTaskScreen({required this.taskModel});
  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  TextEditingController titleEditController = TextEditingController();

  TextEditingController descriptionEditController = TextEditingController();

  var selectedDate = DateTime.now();
  final formKey = GlobalKey<FormState>();
  void initState(){
    super.initState();
    titleEditController.text=widget.taskModel.title;
    descriptionEditController.text=widget.taskModel.description;
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    final dateFormat=DateFormat('dd/MM/yyyy');
    return Scaffold(
      resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: //Text(selected_index ==0 ? 'To Do List' : 'Settings'),
          Padding(
              padding: EdgeInsetsDirectional.only(start: 20),
              child: Text(AppLocalizations.of(context)!.todolist)
          ),
        ),
        body: Stack(
          children: [
            Container(
              color: AppTheme.primaruColor,
              width: double.infinity,
              height: 100,
            ),
            Container(
              decoration: BoxDecoration(
                color: AppTheme.whitecolor,
                borderRadius: BorderRadius.circular(15),
              ),
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.symmetric(
                  horizontal: MediaQuery
                      .of(context)
                      .size
                      .width * .07,
                  vertical: MediaQuery
                      .of(context)
                      .size
                      .width * .05
              ),
              height: 617,
              width: 352,
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Text('Edit Task', style: Theme
                        .of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: AppTheme.blackcolor),),
                    CustomTextFormField(
                        controller: titleEditController,
                        onChanged: (value){
                          widget.taskModel.title=value;
                          setState(() {

                          });

                        },
                        //hintText: 'Enter task Title'
                    ),
                    SizedBox(height: 16,),
                    CustomTextFormField(
                      onChanged: (value){
                        widget.taskModel.description=value;
                        setState(() {

                        });
                      },
                        controller: descriptionEditController,
                       // hintText: 'Enter task Description',
                        maxLines: 5
                    ),
                    SizedBox(height: 16,),
                    Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: Text('Selected Date', style: Theme
                            .of(context)
                            .textTheme
                            .bodyLarge,)),
                    SizedBox(height: 20,),
                    InkWell(
                      onTap: () async {
                        final dateTime = await showDatePicker(
                            context: context,
                            initialDate: selectedDate,
                            firstDate: DateTime.now(),
                            lastDate: DateTime.now().add(const Duration(
                                days: 365)),
                            //دي بتلغي icon الاختيار باليد
                            initialEntryMode: DatePickerEntryMode.calendarOnly
                        );
                        if (dateTime != null) {
                          selectedDate = dateTime;
                        }

                      },
                      child: Text(
                        dateFormat.format(selectedDate),
                        style: Theme
                            .of(context)
                            .textTheme
                            .bodySmall,
                      ),
                    ),
                   SizedBox(height: 20,),
                    DefaultElevatedButton(
                      onpressed: EditTask,
                      child: Text(
                        'Save Changes',
                        style: Theme
                            .of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(
                            color: AppTheme.whitecolor,
                            fontSize: 14
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        )
    );
  }
  void EditTask(){
    if(formKey.currentState?.validate()==true) {
      FirebaseUtils.UpdateTask(
        Provider.of<UserProvider>(context,listen: false).currentUser!.id,
        widget.taskModel
      , //بت catch ال error أللي ممكن ال future  يضربه
      ).then(
            (_) {
          Provider.of<TasksProvider>(context, listen: false)
              .getTasks( Provider.of<UserProvider>(context,listen: false).currentUser!.id);
          Navigator.of(context).pop();
          Fluttertoast.showToast(
            msg: "Task Edited Successfully",
            toastLength: Toast.LENGTH_SHORT,
            // gravity: ToastGravity.CENTER,
            // timeInSecForIosWeb: 1,
            // backgroundColor: Colors.red,
            // textColor: Colors.white,
            // fontSize: 16.0
          );
        },
      ).catchError((e) {
        Fluttertoast.showToast(
          msg: '$e',
          toastLength: Toast.LENGTH_SHORT,
        );
      });
    }
  }

}