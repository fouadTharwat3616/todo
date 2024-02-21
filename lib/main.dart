import 'package:flutter/material.dart';
import 'package:todo/app_theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo/homescreen.dart';
import 'package:todo/tabs/settings/settings_provider.dart';


void main() {
  runApp(
      ChangeNotifierProvider(
          create: (context) => settingsProvider(),
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

      },
      //initialRoute: HomeScreen.routeName,

    );
  }
}

