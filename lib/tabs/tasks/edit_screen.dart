import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo/app_theme.dart';
import 'package:todo/tabs/settings/settings_provider.dart';
class EditTaskScreen extends StatelessWidget {
  static const String routename='Edit_TAsk';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                horizontal: MediaQuery.of(context).size.width* .07,
                vertical: MediaQuery.of(context).size.width*.05
            ),
            height: 617,
            width: 352,
            child: Column(
              children: [
                Text('Edit Task',style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppTheme.blackcolor),),
              ],
            ),
          ),
        ],
      )
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// import 'package:todo/app_theme.dart';
// import 'package:todo/firebase_utils.dart';
// import 'package:todo/models/task_model.dart';
// import 'package:todo/tabs/tasks/custom_text_form_field.dart';
// import 'package:todo/tabs/tasks/default_elevated_button.dart';
// import 'package:todo/tabs/tasks/tasks_provider.dart';
//
// class EditTaskScreen extends StatefulWidget {
//   @override
//   State<AddtaskBottimSheet> createState() => _AddtaskBottimSheetState();
// }
//
// class _AddtaskBottimSheetState extends State<AddtaskBottimSheet> {
// static const String routeName='Edit_Screen';
//   TextEditingController titleController=TextEditingController();
//   TextEditingController descriptionController=TextEditingController();
//   var selectedDate =DateTime.now();
//   @override
//   Widget build(BuildContext context) {
//     final dateFormat=DateFormat('dd/MM/yyyy');
//     return Container(
//       height: MediaQuery.of(context).size.height*.45,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10),
//       ),
//       padding: EdgeInsets.all(8),
//       //width: double.infinity,
//       child: Column(
//         children: [
//           Text('Add new Task',style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppTheme.blackcolor),),
//           CustomTextFormField(
//               controller: titleController,
//               hintText: 'Enter task Title'),
//           SizedBox(height: 16,),
//           CustomTextFormField(
//               controller: descriptionController,
//               hintText: 'Enter task Description',maxLines: 5),
//           SizedBox(height: 16,),
//           Align(
//               alignment: AlignmentDirectional.centerStart,
//               child: Text('Selected Date',style: Theme.of(context).textTheme.bodyLarge,)),
//           InkWell(
//             onTap: () async{
//               final dateTime = await showDatePicker(
//                   context: context,
//                   initialDate: selectedDate,
//                   firstDate: DateTime.now(),
//                   lastDate: DateTime.now().add(const Duration(days: 365)),
//                   //دي بتلغي icon الاختيار باليد
//                   initialEntryMode: DatePickerEntryMode.calendarOnly
//               );
//               if (dateTime != null)
//               {
//                 selectedDate=dateTime;
//               }
//
//               setState(() {});
//             },
//             child: Text(
//               dateFormat.format(selectedDate),
//               style: Theme.of(context).textTheme.bodySmall,
//             ),
//           ),
//           SizedBox(height: 20,),
//           DefaultElevatedButton(label: 'Add',onpressed: addTask),
//         ],
//       ),
//     );
//   }
//
//   void addTask(){
//     FirebaseUtils.addTaskToFirestore(
//       TaskModel(
//         title: titleController.text,
//         description: descriptionController.text,
//         dateTime: selectedDate,
//       ),//بت catch ال error أللي ممكن ال future  يضربه
//     ).timeout(
//       Duration(milliseconds: 500),
//       onTimeout: (){
//         Provider.of<TasksProvider>(context,listen: false).getTasks();
//         Navigator.of(context).pop();
//         print('Success');
//       },
//     ).catchError( (_){
//       print('Error, Try again!');
//     }  );
//
//
//
//   }
// }

