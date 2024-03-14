import 'package:flutter/material.dart';
import 'package:todo/models/user_model.dart';

class UserProvider with ChangeNotifier{
  UserModel? currentUser;


  void UpdateUser(UserModel user)
  {
    currentUser = user;
    notifyListeners();
  }

}