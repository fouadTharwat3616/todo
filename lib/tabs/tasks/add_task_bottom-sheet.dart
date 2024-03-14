import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo/app_theme.dart';
import 'package:todo/auth/user_provider.dart';
import 'package:todo/firebase_utils.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/tabs/settings/settings_provider.dart';
import 'package:todo/tabs/tasks/custom_text_form_field.dart';
import 'package:todo/tabs/tasks/default_elevated_button.dart';
import 'package:todo/tabs/tasks/tasks_provider.dart';

class AddtaskBottimSheet extends StatefulWidget {
  @override
  State<AddtaskBottimSheet> createState() => _AddtaskBottimSheetState();
}

class _AddtaskBottimSheetState extends State<AddtaskBottimSheet> {
  TextEditingController titleController=TextEditingController();
  TextEditingController descriptionController=TextEditingController();
  final formKey=GlobalKey<FormState>();
  var selectedDate =DateTime.now();
  @override
  Widget build(BuildContext context) {
   final dateFormat=DateFormat('dd/MM/yyyy');
    return Container(
      height: MediaQuery.of(context).size.height*.50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Provider.of<settingsProvider>(context).backGround_bottom_sheet_settings_container
      ),
      padding: EdgeInsets.all(8),
      //width: double.infinity,
      child: Form(
        key: formKey,
        child: Column(
          children: [
            Text('Add new Task',style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppTheme.blackcolor),),
            CustomTextFormField(
                controller: titleController,
                hintText: 'Enter task Title',
              validator: (value){
                if(value == null || value.isEmpty)
                {
                  return 'Title can not be empty';
                }
                return null;
              },

            ),
            SizedBox(height: 16,),
            CustomTextFormField(
              controller: descriptionController,
                hintText: 'Enter task Description',
                maxLines: 5,
              validator: (value){
                if(value == null || value.isEmpty)
                {
                  return 'Description can not be empty';
                }
                return null;
              },
            ),
            SizedBox(height: 16,),
            Align(
              alignment: AlignmentDirectional.centerStart,
                child: Text('Selected Date',style: Theme.of(context).textTheme.bodyLarge,)),
            InkWell(
              onTap: () async{
                final dateTime = await showDatePicker(
                    context: context,
                    initialDate: selectedDate,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                  //دي بتلغي icon الاختيار باليد
                  initialEntryMode: DatePickerEntryMode.calendarOnly
                );
                if (dateTime != null)
                  {
                    selectedDate=dateTime;
                  }

                setState(() {});
              },
              child: Text(
              dateFormat.format(selectedDate),
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
            SizedBox(height: 20,),
            DefaultElevatedButton(
                child:
                Text(
                  'Add',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppTheme.whitecolor),),
                // style: ElevatedButton.styleFrom(
                //   backgroundColor: Theme.of(context).primaryColor,
                //   fixedSize: Size(MediaQuery.of(context).size.width, 52),
                // ),,
                onpressed: addTask),
          ],
        ),
      ),
    );
  }

  void addTask(){
   if(formKey.currentState?.validate()==true) {
      FirebaseUtils.addTaskToFirestore(
        Provider.of<UserProvider>(context,listen: false).currentUser!.id,
        TaskModel(
          title: titleController.text,
          description: descriptionController.text,
          dateTime: selectedDate,
        ), //بت catch ال error أللي ممكن ال future  يضربه
      ).then(
            (_) {
          Provider.of<TasksProvider>(context, listen: false)
              .getTasks( Provider.of<UserProvider>(context,listen: false).currentUser!.id);
          Navigator.of(context).pop();
          Fluttertoast.showToast(
            msg: "Task Added Successfully",
            toastLength: Toast.LENGTH_SHORT,
            // gravity: ToastGravity.CENTER,
            // timeInSecForIosWeb: 1,
            // backgroundColor: Colors.red,
            // textColor: Colors.white,
            // fontSize: 16.0
          );
        },
      ).catchError((_) {
        Navigator.of(context).pop();
        Fluttertoast.showToast(
          msg: "Something Went Wrong!",
          toastLength: Toast.LENGTH_SHORT,
        );
      });
     }
  }
}
