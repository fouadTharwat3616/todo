import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo/app_theme.dart';
import 'package:todo/firebase_utils.dart';
import 'package:todo/models/task_model.dart';
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
  var selectedDate =DateTime.now();
  @override
  Widget build(BuildContext context) {
   final dateFormat=DateFormat('dd/MM/yyyy');
    return Container(
      height: MediaQuery.of(context).size.height*.45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(8),
      //width: double.infinity,
      child: Column(
        children: [
          Text('Add new Task',style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppTheme.blackcolor),),
          CustomTextFormField(
              controller: titleController,
              hintText: 'Enter task Title'),
          SizedBox(height: 16,),
          CustomTextFormField(
            controller: descriptionController,
              hintText: 'Enter task Description',maxLines: 5),
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
          DefaultElevatedButton(label: 'Add',onpressed: addTask),
        ],
      ),
    );
  }

  void addTask(){
    FirebaseUtils.addTaskToFirestore(
        TaskModel(
            title: titleController.text,
            description: descriptionController.text,
            dateTime: selectedDate,
        ),//بت catch ال error أللي ممكن ال future  يضربه
    ).timeout(
        Duration(milliseconds: 500),
        onTimeout: (){
          Provider.of<TasksProvider>(context,listen: false).getTasks();
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
    ).catchError( (_){
      Navigator.of(context).pop();
      Fluttertoast.showToast(
        msg: "Something Went Wrong!",
        toastLength: Toast.LENGTH_SHORT,
      );
    }  );



  }
}
