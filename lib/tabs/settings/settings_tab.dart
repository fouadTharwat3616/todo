import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/app_theme.dart';
import 'package:todo/tabs/settings/settings_provider.dart';

class SettingsTab extends StatefulWidget {
  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  List<language> languages=[language(name: 'English', code: 'en'),language(name: 'العربية', code: 'ar')];
  List<chooseThemeMode> themeModes=[chooseThemeMode(themeMode: ThemeMode.light,code: 'light'),chooseThemeMode(themeMode: ThemeMode.dark, code: 'dark')];
  @override
  Widget build(BuildContext context) {
    settingsProvider provider= Provider.of<settingsProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsetsDirectional.only(start: 30,top: 30),
          child: Text(
            'Language',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontSize: 14,
              fontWeight: FontWeight.bold,
                color: AppTheme.whitecolor
            ),
          ),
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 10,horizontal:15 ),
          margin: EdgeInsets.symmetric(vertical: 20,horizontal:20 ),
          decoration: BoxDecoration(
            color: Provider.of<settingsProvider>(context).backGround_bottom_sheet_settings_container,
            border: Border.all(color: AppTheme.primaruColor),
          ),
          child: SizedBox(
            width: MediaQuery.of(context).size.width*.3,
            child: DropdownButtonHideUnderline(
              child: DropdownButton<language>(
                value: languages.firstWhere((lang) => lang.code==provider.languagecode) ,
                items: languages.map(
                        (language) => DropdownMenuItem(
                      value: language,
                      child: Text(language.name,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: AppTheme.primaruColor
                        ),
                      ),
                    )
                ).toList(),
                onChanged: (selectedLanguage){
                  if(selectedLanguage !=null)
                  {
                    provider.changeLanguage(selectedLanguage.code);
                  }
                  setState(() {

                  });
                },
                borderRadius: BorderRadius.circular(20),
              ),

            ),
          ),
        ),
        Container(
          margin: EdgeInsetsDirectional.only(start: 30,top: 30),
          child: Text(
            'Mode',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              color: AppTheme.whitecolor
            ),
          ),
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 10,horizontal:15 ),
          margin: EdgeInsets.symmetric(vertical: 20,horizontal:20 ),
          decoration: BoxDecoration(
            color: Provider.of<settingsProvider>(context).backGround_bottom_sheet_settings_container,
            border: Border.all(color: AppTheme.primaruColor),
          ),
          child: SizedBox(
            width: MediaQuery.of(context).size.width*.3,
            child: DropdownButtonHideUnderline(
              child: DropdownButton<chooseThemeMode>(
                value: themeModes.firstWhere((theme) => theme.themeMode == provider.themeMode) ,
                items: themeModes.map(
                        (chooseThemeMode) => DropdownMenuItem(
                      value: chooseThemeMode,
                      child: Text(chooseThemeMode.code,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: AppTheme.primaruColor
                        ),
                      ),
                    )
                ).toList(),
                onChanged: (selectedThem){
                  if(provider.themeMode==ThemeMode.dark)
                  {
                    provider.changeTheme(selectedThem!.themeMode);
                  } else
                  {
                    provider.changeTheme(selectedThem!.themeMode);
                  }
                  setState(() {

                  });
                },
                borderRadius: BorderRadius.circular(20),
              ),

            ),
          ),
        ),

      ],
    );
  }
}

class language
{
  String name;
  String code;
  language({required this.name,required this.code});
}

class chooseThemeMode{
  ThemeMode themeMode;
  String code;
  chooseThemeMode({required this.themeMode, required this.code});
}