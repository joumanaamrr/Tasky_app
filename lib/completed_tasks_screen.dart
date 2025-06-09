import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky/models/taskmodel.dart';

import 'Services/theme_notifier.dart';
import 'Widgets/tasks_list_popup.dart';

class CompletedTasks extends StatefulWidget {
  static const String Routname = 'completedTasksScreen';

  @override
  _CompletedTasksScreenState createState() => _CompletedTasksScreenState();
}

class _CompletedTasksScreenState extends State<CompletedTasks> {
  List<taskmodel> tasksdone = [];
  List<taskmodel> tasksnotdone=[];
  List<taskmodel> alltasks=[];
  String?tasksall;
  String ? taskdone;
  String? tasknotdone;
  int index=0;
  bool? ischecked;

  @override
  void initState() {
    super.initState();
    loadTasks();
  }
  Future<void> loadTasks() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
     taskdone = pref.getString('tasks_done');
     tasknotdone=pref.getString('tasks_not_done');
     tasksall=pref.getString('tasks');

    if (taskdone != null && taskdone!.isNotEmpty) {
      final List<dynamic> decodedJson = jsonDecode(taskdone!);
      final List<dynamic> decodedJson2 = jsonDecode(tasknotdone!);
      final List<dynamic> decodedall=jsonDecode(tasksall!);

      final List<taskmodel> loadedTasks = decodedJson
          .map((jsonTask) => taskmodel.fromMap(Map<String, dynamic>.from(jsonTask)))
          .toList();
      final List<taskmodel> loadedTasks2 = decodedJson2
          .map((jsonTask) => taskmodel.fromMap(Map<String, dynamic>.from(jsonTask)))
          .toList();
      final List<taskmodel> loadedall = decodedall
          .map((jsonTask) => taskmodel.fromMap(Map<String, dynamic>.from(jsonTask)))
          .toList();

      setState(() { });
        tasksdone = loadedTasks;
        tasksnotdone=loadedTasks2;
        alltasks=loadedall;

    } else {
      setState(() {});
        tasksdone = [];
        tasksnotdone=[];
        alltasks=[];

    }
  }
  Future<void> saveAll() async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString('tasks_done',
        jsonEncode(tasksdone.map((e) => e.toMap()).toList()));
    await pref.setString('tasks_not_done',
        jsonEncode(tasksnotdone.map((e) => e.toMap()).toList()));
    await pref.setString('tasks',
        jsonEncode(alltasks.map((e) => e.toMap()).toList()));
  }


  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    final isDark = themeNotifier.isDarkMode;
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Completed Tasks",
        style: Theme.of(context).textTheme.displayLarge,),

        centerTitle: true,
      ),
      body:
      Expanded(
        child: ListView.separated(
            itemBuilder:(context,index){
              return
                   Padding(
                     padding: const EdgeInsets.symmetric(horizontal: 16),
                     child: Container(
                       margin: EdgeInsets.only(bottom: 12),
                       padding: EdgeInsets.all(16),
                       decoration: BoxDecoration(
                         color:isDark?Color(0xff282828):Colors.white,
                         borderRadius: BorderRadius.circular(12),
                           border: Border.all(
                               color:isDark?Color(0xff282828):Colors.grey

                           )
                       ),
                       width: 343,

                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          Checkbox(value:tasksdone[index].isdone?? false,
                            onChanged: (bool? isChecked) {
                                final removedTask = tasksdone.removeAt(index);
                                removedTask.isdone = false;
                                tasksnotdone.add(removedTask);
                                alltasks = alltasks.map((t) {
                                  return t.Title == removedTask.Title
                                      ? removedTask
                                      : t;
                                }).toList();
                                 saveAll();
                                setState(() {
                                    saveAll();
                              });


                            },



                            activeColor:Color(0xff15B86C),


                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  '${tasksdone[index].description}',
                                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                                    decoration: TextDecoration.lineThrough,
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  "${tasksdone[index].Title}",
                                  style: Theme.of(context).textTheme.displaySmall,
                                ),
                              ],
                            ),
                          ),


                          PopupMenuButton<TasksListPopup>(
                              icon: Icon(Icons.more_vert_sharp),
                              iconColor:Color(0xffA0A0A0),
                              itemBuilder:
                                  (context)=>
                                  TasksListPopup.values.map(
                                          (e){
                                        return PopupMenuItem<TasksListPopup>(
                                            value: e,
                                            child:Text(e.name));

                                      }
                                  ).toList(),
                              onSelected: (TasksListPopup selectedOption) {
                                setState(() {
                                  switch (selectedOption) {
                                    case TasksListPopup.MarkAsdone:
                                      final removedTask = tasksdone.removeAt(index);
                                      removedTask.isdone = false;
                                      tasksnotdone.add(removedTask);
                                      alltasks = alltasks.map((t) {
                                        return t.Title == removedTask.Title
                                            ? removedTask
                                            : t;
                                      }).toList();
                                      saveAll();
                                      setState(() {
                                        saveAll();
                                      });

                                      break;



                                    case TasksListPopup.Edit:
                                      showDialog(
                                        context: context,
                                        builder: (_) => AlertDialog(
                                          title: Text('Edit Task'),
                                          content: Text('Implement your edit logic here'),
                                          actions: [
                                            TextButton(onPressed: () => Navigator.pop(context), child: Text('Close'))
                                          ],
                                        ),
                                      );

                                      break;

                                    case TasksListPopup.Delete:
                                      final removedTask = tasksdone.removeAt(index);
                                      tasksnotdone.removeWhere(
                                              (t) => t.Title == removedTask.Title);
                                      alltasks.removeWhere(
                                              (t) => t.Title == removedTask.Title);
                                       saveAll();
                                      break;

                                      break;
                                  }

                                });

                              })
                        ],

                                         ),
                     ),
                   );


            },
            separatorBuilder:(context,index){
             return SizedBox(height: 16,);
              },
            itemCount:tasksdone.length),
      )



    );
  }
}

