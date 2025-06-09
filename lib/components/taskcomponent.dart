import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Services/theme_notifier.dart';
import '../Widgets/tasks_list_popup.dart';
import '../models/taskmodel.dart';

class TaskComponent extends StatefulWidget {
  final List <taskmodel>tasks;
  TaskComponent({required this.tasks});
  @override
  State<TaskComponent> createState() => _TaskComponentState();

}

class _TaskComponentState extends State<TaskComponent> {
  // Make sure you have your `alltasks` list and related functions available
  // Example:
  List<taskmodel> alltasks = [];
  List <taskmodel>tasksdone=[];
  List<taskmodel>tasksnotdone=[];
  List<taskmodel>taskshighpriority=[];



  void separateTasks() {
    tasksdone = alltasks.where((task) => task.isdone).toList();
    tasksnotdone = alltasks.where((task) => !task.isdone).toList();
    taskshighpriority = alltasks.where((task) => task.ishighpriority).toList();
  }
  Future<void> saveTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Map<String, dynamic>> taskMaps = alltasks.map((task) => task.toMap()).toList();
    String tasksJson = jsonEncode(taskMaps);
    await prefs.setString('tasks', tasksJson);
  }
  Future<void> saveTasksSeparately() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String doneJson = jsonEncode(tasksdone.map((t) => t.toMap()).toList());
    String notDoneJson = jsonEncode(tasksnotdone.map((t) => t.toMap()).toList());
    String highPriorityJson = jsonEncode(taskshighpriority.map((t) => t.toMap()).toList());

    await prefs.setString('tasks_done', doneJson);
    await prefs.setString('tasks_not_done', notDoneJson);
    await prefs.setString('tasks_high_priority', highPriorityJson);
  }


  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    final isDark = themeNotifier.isDarkMode;
    return
       ListView.builder(
        itemCount:widget.tasks.length > 2 ? 2 : widget.tasks.length,
        itemBuilder: (context, index) {
          final taskname = widget.tasks[index];
      
          return Container(


            decoration: BoxDecoration(

              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                  color:isDark?Color(0xff282828):Colors.grey)
            ),
            width: 343,
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 25),
                  child: Checkbox(
                    value: taskname.isdone ?? false,
                    onChanged: (bool? isChecked) {
                      setState(() {
                        taskname.isdone = isChecked ?? false;
                        separateTasks();
                      });
                      saveTasks();
                      saveTasksSeparately();
                    },
                    activeColor: Color(0xff15B86C),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        taskname.description,
                        style: taskname.isdone
                            ? Theme.of(context).textTheme.displayLarge?.copyWith(
                          decoration: TextDecoration.lineThrough,
                          color: Colors.grey,
                        )
                            : Theme.of(context).textTheme.displayLarge,
                      ),
                      Text(
                        taskname.Title,
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      SizedBox(height: 4),
                    ],
                  ),
                ),
                PopupMenuButton<TasksListPopup>(
                  icon: Icon(Icons.more_vert_sharp),
                  iconColor: Color(0xffA0A0A0),
                  itemBuilder: (context) => TasksListPopup.values.map((e) {
                    return PopupMenuItem<TasksListPopup>(
                      value: e,
                      child: Text(e.name),
                    );
                  }).toList(),
                  onSelected: (TasksListPopup selectedOption) {
                    setState(() {
                      switch (selectedOption) {
                        case TasksListPopup.MarkAsdone:
                          taskname.isdone = !taskname.isdone;
                          separateTasks();
                          break;
                        case TasksListPopup.Edit:
                          showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: Text('Edit Task'),
                              content: Text('Implement your edit logic here'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text('Close'),
                                )
                              ],
                            ),
                          );
                          break;
                        case TasksListPopup.Delete:
                          alltasks.removeAt(index);
                          separateTasks();
                          break;
                      }
                    });
                    saveTasks();
                    saveTasksSeparately();
                  },
                ),
              ],
            ),
          );
        },

    );
  }
}
