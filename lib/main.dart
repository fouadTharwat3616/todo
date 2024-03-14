//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo/app_theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo/auth/login_screen.dart';
import 'package:todo/auth/register_screen.dart';
import 'package:todo/auth/user_provider.dart';
import 'package:todo/homescreen.dart';
import 'package:todo/models/task_model.dart';
import 'package:todo/tabs/settings/settings_provider.dart';
import 'package:todo/tabs/tasks/edit_screen.dart';
import 'package:todo/tabs/tasks/tasks_provider.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // await FirebaseFirestore.instance.disableNetwork();
  // FirebaseFirestore.instance.settings =
  //     const Settings(cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);
  runApp(
    MultiProvider(
        providers: [
          ChangeNotifierProvider(
        create: (context) => settingsProvider(),
    ),
          ChangeNotifierProvider(
            create: (context) => UserProvider(),
          ),
      ChangeNotifierProvider(
        // .. اسمها كاسكيد ابوريتور
          create: (context) => TasksProvider(),
      )],
        child: ToDo()
    )

  );
}

class ToDo extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    settingsProvider provider=Provider.of<settingsProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.DarkTheme,
      themeMode: provider.themeMode,
      //themeMode: ,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales:AppLocalizations.supportedLocales,
      locale:  Locale(provider.languagecode),
      routes: {
        HomeScreen.routeName:(_) => HomeScreen(),
        //EditTaskScreen.routename: (context) => EditTaskScreen(),
        LoginScreen.routeName:(context) => LoginScreen(),
        RegisterScreen.routeName:(context) => RegisterScreen(),
      },
      initialRoute: LoginScreen.routeName,
      //initialRoute: HomeScreen.routeName,

    );
  }
}

