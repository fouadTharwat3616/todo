import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/models/task_model.dart';

class FirebaseUtils{
 static CollectionReference<TaskModel> getTasksCollection() =>  FirebaseFirestore.instance.collection('tasks').withConverter<TaskModel>(
      fromFirestore: (snapshot, _) => TaskModel.fromJson(snapshot.data()!),
      toFirestore: (taskModel, _) => taskModel.toJson(),
  );

 static Future<void> addTaskToFirestore(TaskModel task){
    //يبقي انا بمسك ال collection اللي هضيف فيه او امسح....الخ
    final tasksCollection = getTasksCollection();
    //بعد كده بمسك من ال collection ده document بتاخد path اللي هو id
    final doc = tasksCollection.doc();
    task.id=doc.id;
    return doc.set(task);
  }

 static Future<void> deleteTaskFromFirestore(String taskId){
   final tasksCollection = getTasksCollection();
   return tasksCollection.doc(taskId).delete();


  }

 static Future<List<TaskModel>> getAllTasksFromFirestore()async{
   final tasksCollection = getTasksCollection();
   final querySnapshot = await tasksCollection.get();
   return querySnapshot.docs.map((doc) => doc.data()).toList();
  }



}