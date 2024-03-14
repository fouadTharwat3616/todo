import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/app_theme.dart';
import 'package:todo/auth/login_screen.dart';
import 'package:todo/auth/user_provider.dart';
import 'package:todo/firebase_utils.dart';
import 'package:todo/tabs/settings/settings_tab.dart';
import 'package:todo/tabs/tasks/add_task_bottom-sheet.dart';
import 'package:todo/tabs/tasks/tasks_provider.dart';
import 'package:todo/tabs/tasks/tasks_tab.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class HomeScreen extends StatefulWidget {
  static const String routeName='/HomeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> tabs=[
    TasksTab(),
    SettingsTab(),
  ];

  int selected_index=0;
  @override
  Widget build(BuildContext context) {
    List<String> labels=[
      AppLocalizations.of(context)!.todolist,
      AppLocalizations.of(context)!.settings
    ];
    return Scaffold(
      appBar: AppBar(
        title: //Text(selected_index ==0 ? 'To Do List' : 'Settings'),
        Padding(
          padding: EdgeInsetsDirectional.only(start: 20),
            child: Text(labels[selected_index])
        ),
        actions: [
          IconButton(
              onPressed: (){
                FirebaseUtils.LogOut();
                Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
                Provider.of<UserProvider>(context,listen: false).currentUser=null;
                Provider.of<TasksProvider>(context,listen: false).clear();
              },
              icon: Icon(Icons.logout_outlined,
                color:AppTheme.whitecolor ,
                size: 32,
              )
          )
        ],
      ),
      body: tabs[selected_index],
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        notchMargin: 10,
        child: BottomNavigationBar(
          currentIndex: selected_index,
          onTap: (index) => {
            selected_index=index,
            setState(() {

            })
          },
          items: [
            BottomNavigationBarItem(icon: ImageIcon(AssetImage('assets/images/tasks_icon.png')),label: 'tasks'),
            BottomNavigationBarItem(icon: ImageIcon(AssetImage('assets/images/settings_icon.png')),label: 'settings')
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
         onPressed: (){
           showModalBottomSheet(context: context,
             shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
             ),
               builder: (context) =>AddtaskBottimSheet(),
           );
         },
        child: Icon(Icons.add,color: AppTheme.whitecolor,size: 32,),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

    );
  }
}
