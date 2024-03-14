import 'package:flutter/material.dart';
import 'package:todo/firebase_utils.dart';
import 'package:todo/models/task_model.dart';

class TasksProvider with ChangeNotifier{
  List<TaskModel> tasks=[];
  DateTime selectedDate = DateTime.now();

  Future<void> getTasks(String userId) async{
   final AllTasks = await FirebaseUtils.getAllTasksFromFirestore(userId);
   tasks= AllTasks.where((task) =>
       task.dateTime.day==selectedDate.day &&
       task.dateTime.month==selectedDate.month &&
       task.dateTime.year==selectedDate.year)
       .toList();
   tasks.sort((task,nextTask) => task.dateTime.compareTo(nextTask.dateTime));
   notifyListeners();
  }

  void changeDate(String userId,DateTime dateTime){
    selectedDate = dateTime;
    getTasks(userId);
  }

  void clear(){
     tasks=[];
    selectedDate = DateTime.now();
  }

}