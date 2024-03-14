import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_timeline_calendar/timeline/flutter_timeline_calendar.dart';
import 'package:provider/provider.dart';
import 'package:todo/app_theme.dart';
import 'package:todo/auth/user_provider.dart';
import 'package:todo/firebase_utils.dart';
import 'package:todo/tabs/settings/settings_provider.dart';
import 'package:todo/tabs/tasks/edit_screen.dart';
import 'package:todo/tabs/tasks/task_item.dart';
import 'package:todo/tabs/tasks/tasks_provider.dart';

class TasksTab extends StatelessWidget {
  bool shouldGetTasks=true;
  late String userId;
  late TasksProvider tasksProvider;
  @override
  Widget build(BuildContext context) {
    if(shouldGetTasks==true)
    {
       userId = Provider.of<UserProvider>(context).currentUser!.id;
       tasksProvider = Provider.of<TasksProvider>(context)
        ..getTasks(userId);
      shouldGetTasks=false;
    }

    return Column(
      children: [
      TimelineCalendar(
      calendarType: CalendarType.GREGORIAN,
      calendarLanguage: "en",
      calendarOptions: CalendarOptions(
        viewType: ViewType.DAILY,
        toggleViewType: true,
        headerMonthElevation: 10,
        headerMonthShadowColor: Colors.black26,
        headerMonthBackColor: Colors.transparent,
        bottomSheetBackColor: Provider.of<settingsProvider>(context).backGround_bottom_sheet_settings_container
      ),
      dayOptions: DayOptions(
          compactMode: true,
          weekDaySelectedColor: Theme.of(context).primaryColor,
          selectedBackgroundColor: Theme.of(context).primaryColor,
          disableDaysBeforeNow: true),
      headerOptions: HeaderOptions(
          weekDayStringType: WeekDayStringTypes.SHORT,
          monthStringType: MonthStringTypes.FULL,
          backgroundColor: AppTheme.primaruColor,
          headerTextColor: Colors.black),

      onChangeDateTime: (CalendarDateTime ) {
       tasksProvider.changeDate(userId,CalendarDateTime.toDateTime());
      },
        dateTime: CalendarDateTime(
            year: tasksProvider.selectedDate.year,
            month: tasksProvider.selectedDate.month,
            day: tasksProvider.selectedDate.day
        ),
    ),
        const SizedBox(height: 8,),
        Expanded(
          child: ListView.builder(itemBuilder: (_, index) =>
              TaskItem(tasksProvider.tasks[index]),
            itemCount: tasksProvider.tasks.length,
          ),
        )
      ],
    );
  }
}
