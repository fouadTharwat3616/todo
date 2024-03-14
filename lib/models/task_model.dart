import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  String id;
  String title;
  String description;
  DateTime dateTime;
  bool isDone;

  TaskModel({
    this.id = '',
    required this.title,
    required this.description,
    required this.dateTime,
    this.isDone=false,
  });

  // factory TaskModel.fromJson(Map<String,dynamic> json)
  // {
  //   return TaskModel(
  //       id: json["id"],
  //       title: json["title"],
  //       description: json["description"],
  //       dateTime: json["dateTime"],
  //       isDone: json["isDone"]);
  // }
  TaskModel.fromJson(Map<String,dynamic> json)
  :this(
      id: json["id"],
      title: json["title"],
      description: json["description"],
      dateTime: (json["dateTime"] as Timestamp).toDate() ,
      isDone: json["isDone"]
    );


  Map<String,dynamic> toJson() =>
      {
        "id" : id,
        "title" :title,
        "description" : description,
        "dateTime" : Timestamp.fromDate(dateTime),
        "isDone" : isDone,
      };


}