import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo/app_theme.dart';
import 'package:todo/tabs/tasks/custom_text_form_field.dart';
import 'package:todo/tabs/tasks/default_elevated_button.dart';

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
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                initialEntryMode: DatePickerEntryMode.calendarOnly
              );
              if (dateTime != null)
                {
                  selectedDate=dateTime;
                }
            },
            child: Text(
            dateFormat.format(DateTime.now()),
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

  }
}
