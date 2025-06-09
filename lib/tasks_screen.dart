import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky/components/componentoftextform.dart';
import 'package:tasky/home_screen.dart';
import 'package:tasky/models/taskmodel.dart';
import 'package:tasky/todotasks_screen.dart';

class TasksScreen extends StatefulWidget{
  static const String Routname='Tasksscreen';




  @override
  State<TasksScreen> createState() => _TasksScreenState();

}

class _TasksScreenState extends State<TasksScreen> {
  bool ishighpriority=true;
  bool isdone=false;
  final TextEditingController tasknamecontroller=TextEditingController();
  final TextEditingController taskdescriptioncontroller=TextEditingController();
  final GlobalKey<FormState> keyy=GlobalKey();
  String ? task;
  List<taskmodel>tasksdone=[];
  List<taskmodel>tasksnotdone=[];
  List<taskmodel> tasks=[];
  List<taskmodel>alltasks=[];
  List<taskmodel>taskshighpriority=[];
  void initState(){
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return
       Scaffold(

        body: SafeArea(
          child: Form(
            key: keyy,
            child: SingleChildScrollView(
              child: Column(
                 children: [
                   SizedBox(height: 9,),
                  componentoftextform(
                    Title:' Task Name',
                    cont:taskdescriptioncontroller,
                    validator:(String? value){
                      if(value==null || value.isEmpty){
                        return'This Field is required';
                      }else return null;
                    },
                    Description:'Finish UI design for login screen',


                  )
                  ,
                  SizedBox(height: 20,),
                        componentoftextform(
                          Title:'Task Description',
                          Description:'Finish onboarding UI and hand off to devs by Thursday.',
                          cont: tasknamecontroller,
                           maxlines:9,
                        ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('High Priority ',
                      style: Theme.of(context).textTheme.displayLarge,),
                        Switch(
                            value:ishighpriority,
                            onChanged:(value) {
                              setState(() {
                               ishighpriority =value;
                              });
                              if(ishighpriority==true){
                               final List<taskmodel>taskshigh=tasks.where(
                                   (task)=>task.ishighpriority==true).toList();

                              }
                            }
                        )
                    ],
                  ),
                  SizedBox(height: 100,),

                   ElevatedButton(
                     onPressed: () async {
                       if (keyy.currentState?.validate() ?? false) {
                         final SharedPreferences pref = await SharedPreferences.getInstance();

                         List<dynamic> allTasks = [];
                         List<dynamic> tasksDone = [];
                         List<dynamic> tasksNotDone = [];
                         List<dynamic> tasksHighPriority = [];

                         final String? allJson = pref.getString('tasks');
                         final String? doneJson = pref.getString('tasks_done');
                         final String? notDoneJson = pref.getString('tasks_not_done');
                         final String? highPriorityJson = pref.getString('tasks_high_priority');

                         if (allJson != null) allTasks = jsonDecode(allJson);
                         if (doneJson != null) tasksDone = jsonDecode(doneJson);
                         if (notDoneJson != null) tasksNotDone = jsonDecode(notDoneJson);
                         if (highPriorityJson != null) tasksHighPriority = jsonDecode(highPriorityJson);

                         final taskmodel newTask = taskmodel(
                           id: allTasks.length + 1,
                           Title: tasknamecontroller.text,
                           description: taskdescriptioncontroller.text,
                           ishighpriority: ishighpriority,
                           isdone: isdone,
                         );

                         allTasks.add(newTask.toMap());
                         if (newTask.isdone) {
                           tasksDone.add(newTask.toMap());
                         } else {
                           tasksNotDone.add(newTask.toMap());
                         }
                         if (newTask.ishighpriority==true) {
                           tasksHighPriority.add(newTask.toMap());
                         }

                         await pref.setString('tasks', jsonEncode(allTasks));
                         await pref.setString('tasks_done', jsonEncode(tasksDone));
                         await pref.setString('tasks_not_done', jsonEncode(tasksNotDone));
                         await pref.setString('tasks_high_priority', jsonEncode(tasksHighPriority));

                         ScaffoldMessenger.of(context).showSnackBar(
                           SnackBar(content: Text("Your Task Is Added!")),
                         );

                         Navigator.push(context, MaterialPageRoute(builder: (context)=>Todotasks())); // optional: return to previous screen
                       }
                     },
                     child: Text('+ Add Task', style: Theme.of(context).textTheme.displaySmall),
                     style: Theme.of(context).elevatedButtonTheme.style,
                   ),

                 ],
              ),
            ),
          ),
        ),
      
      

    );

  }




}