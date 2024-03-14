import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/models/user_model.dart';

class FirebaseUtils{
  static CollectionReference<UserModel> getUsersCollection() =>
      FirebaseFirestore.instance.collection('Users').withConverter<UserModel>(
    fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
    toFirestore: (userModel, _) => userModel.toJson(),
  );

 static CollectionReference<TaskModel> getTasksCollection(String userId) =>
     getUsersCollection().doc(userId).collection('tasks').withConverter<TaskModel>(
      fromFirestore: (snapshot, _) => TaskModel.fromJson(snapshot.data()!),
      toFirestore: (taskModel, _) => taskModel.toJson(),
  );

 static Future<void> addTaskToFirestore(String userId,TaskModel task){
    //يبقي انا بمسك ال collection اللي هضيف فيه او امسح....الخ
    final tasksCollection = getTasksCollection(userId);
    //بعد كده بمسك من ال collection ده document بتاخد path اللي هو id
    final doc = tasksCollection.doc();
    task.id=doc.id;
    return doc.set(task);
  }

 static Future<void> deleteTaskFromFirestore(String userId,String taskId){
   final tasksCollection = getTasksCollection(userId);
   return tasksCollection.doc(taskId).delete();
  }

  // static Future<void> EditTask(String userId,TaskModel task)async{
  //   final tasksCollection = getTasksCollection(userId);
  //   //بعد كده بمسك من ال collection ده document بتاخد path اللي هو id
  //   await tasksCollection.doc(task.id).update(task.toJson());
  // }
  static Future<void> UpdateTask(String userId,TaskModel task)async{
    await getTasksCollection(userId).doc(task.id).update(task.toJson());

  }


 static Future<List<TaskModel>> getAllTasksFromFirestore(String userId)async{
   final tasksCollection = getTasksCollection(userId);
   final querySnapshot = await tasksCollection.get();
   return querySnapshot.docs.map((doc) => doc.data()).toList();
  }

  static Future<UserModel> Register({
    required String name,
    required String email,
    required String password,
  })async{
  final credentials =await FirebaseAuth.instance.createUserWithEmailAndPassword(
       email: email,
       password: password
   );
  final user = UserModel(
      //firebase User
      id: credentials.user!.uid,
      name: name,
      email: email
  );
  final userCollection = getUsersCollection();
  await userCollection.doc(user.id).set(user);
  return user;
  }


  static Future<UserModel> Login({
    required String email,
    required String password,
  })async{
   final credentials =await FirebaseAuth.instance.signInWithEmailAndPassword(
       email: email,
       password: password
   );
   final userCollection = getUsersCollection();
   final docSnapshot =await userCollection.doc(credentials.user!.uid).get();
   return docSnapshot.data()!;
  }
  static Future<void> LogOut(){
   return FirebaseAuth.instance.signOut();
  }

}