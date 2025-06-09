import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:tasky/Services/theme_notifier.dart';
import 'package:tasky/Widgets/tasks_list_popup.dart';
import 'package:tasky/completed_tasks_screen.dart';
import 'package:tasky/components/taskcomponent.dart';
import 'package:tasky/models/taskmodel.dart';
import 'package:tasky/profile_screen.dart';
import 'package:tasky/tasks_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky/home_screen.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';



class AddTaskScreen extends StatefulWidget {
  static const String Routname = 'addtaskscreen';

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {


  List<taskmodel>tasksdone=[];
  List<taskmodel>tasksnotdone=[];
  List<taskmodel> taskshighpriority= [];
  late StreamingSharedPreferences prefs;
  late ValueNotifier<List<taskmodel>> alltasksNotifier;
  File? _image;


  final TextEditingController descriptioncont = TextEditingController();
  final TextEditingController titlecontroller = TextEditingController();
  List<taskmodel>alltasks=[];
  bool ischecked=false;
   late String tasksencoded;

  String? username;
  String? quote;
  final TextEditingController usercont=TextEditingController();
  final TextEditingController quotecont=TextEditingController();




  @override
   void initState(){
     super.initState();
     loadTasks();
     loadquote();
     loadImage();
     loadusername();


   }
  Future<void> loadImage() async {
    final prefs = await SharedPreferences.getInstance();
    final path = prefs.getString('image');
    if (path != null && File(path).existsSync()) {
      setState(() {
        _image = File(path);
      });
    }
  }

  Future <void> Saveusername()async{
    SharedPreferences pref=await SharedPreferences.getInstance();
    await pref.setString('user', usercont.text);
    setState(() {
      username=usercont.text;
    });
  }
  Future<void> SaveQuote()async{
    SharedPreferences pref=await SharedPreferences.getInstance();
    await pref.setString('quote', quotecont.text);
    setState(() {
      quote=quotecont.text;
    });
  }
  Future<void>loadusername()async{
    SharedPreferences pref=await SharedPreferences.getInstance();
    String? loadedname=pref.getString('user');
    setState(() {
      username=loadedname;
      usercont.text=username!;
    });
  }
  Future<void>loadquote()async{
    SharedPreferences pref=await SharedPreferences.getInstance();
    String? loadedquote=pref.getString('quote');
    setState(() {
      quote=loadedquote;
      quotecont.text=quote!;
    });
  }


  double percent() {
    if (alltasks.isEmpty) return 0.0;

    int completed = alltasks.where((task) => task.isdone).length;
    return completed / alltasks.length;
  }


  Future<void> loadTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? tasksJson = prefs.getString('tasks');
    username=prefs.getString('user');
    if (tasksJson != null) {
      final List<dynamic> decodedJson = jsonDecode(tasksJson);
      final List<taskmodel> loadedTasks = decodedJson
          .map((jsonTask) => taskmodel.fromMap(Map<String, dynamic>.from(jsonTask)))
          .toList();

      setState(() {
      });
        alltasks = loadedTasks;
        separateTasks();

    }
  }

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
    return Scaffold(
      body: SafeArea(
        child:Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Row
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: CircleAvatar(
                        radius: 25, // Half of width/height (50/2)
                        backgroundImage: _image != null
                            ? FileImage(_image!)
                            : AssetImage('assets/images/Thumbnail.jpg') as ImageProvider,
                      )
            
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Good Evening,${username}',
                              style: Theme.of(context).textTheme.displayLarge
                            ),
                            SizedBox(height: 4),
                            Text(
                              quote ?? 'One task at a time. One step closer.',
                              style: Theme.of(context).textTheme.displaySmall,
                            ),
                          ],
                        ),
                      ),
                    ),
                     SvgPicture.asset(
                        'assets/images/Icon.svg',
                        width: 24,
                        height: 24,
                      ),
            
                  ],
                ),

            
                // Title Section
                Text(
                  'Yuhuu, Your Work Is',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                Row(
                  children: [
                    Text(
                      'Almost Done!',
                      style: Theme.of(context).textTheme.displayLarge,),
                    SizedBox(width: 8),
                    Image.asset(
                      'assets/images/hand.svg',
                      width: 24,
                      height: 24,
                    ),
                  ],
                ),
                 SizedBox(height:5,),
            
                 Padding(
                   padding: EdgeInsets.only(top: 16),
                   child: Container(
                     height: 80,
            
                     decoration: BoxDecoration(
                       color:
                     isDark?Color(0xff282828):Colors.white,
            
            
                       borderRadius:  BorderRadius.circular(20),
                         border: Border.all(
                     color:isDark?Color(0xff282828):Colors.grey
            
                   )
                     ),
                     child: Padding(
                       padding: const EdgeInsets.all(8.0),
                       child:
                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            
                         children: [
                       Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
            
                              Text('Achieved Tasks',
                              style: Theme.of(context).textTheme.displayLarge,
                              ),
            
                                  Text('${tasksdone.length} out of ${alltasks.length} Done',
                                  style: Theme.of(context).textTheme.displaySmall,),
                            ],
                       ),
                                  Transform.translate(
                                    offset: Offset(0,-8),
            
                                    child: CircularPercentIndicator(
                                      radius:27,
                                      lineWidth: 4.0,
                                      percent: percent(), // Must be a double between 0.0 and 1.0
                                      center: Text(
                                        "${(percent() * 100).toStringAsFixed(0)}%",
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey, // 🎨 Customize number color
                                        ),
                                      ),
                                      progressColor: Color(0xff15B86C),
                                      backgroundColor: Color(0xff6D6D6D),
                                      // circularStrokeCap: CircularStrokeCap.round,
                                    ),
                                  ),
            
                            ],
                       ),
                     ),
                   ),
                 ),
                SizedBox(height:8,),
                Container(
                  height:90,
                  width: 400,
                  decoration: BoxDecoration(
                    color:isDark?Color(0xff282828):Colors.white ,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.grey.shade700, // outline (border) color
                      width: 1.5, // thickness of the border
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: 4,),
                               Text('High Priority Tasks',style: Theme.of(context).textTheme.displaySmall?.copyWith(
                                 color: Color(0xff15B86C),
                               )
                               ),
                        Expanded(child: TaskComponent(tasks:taskshighpriority.take(2).toList(),))
                         // Expanded(child: TaskComponent(length: taskshighpriority.take(2).length))
                      ],
                    ),
                  ),
                ),
            
            
            
                SizedBox(height: 5),
                  Text('My Tasks',
                  style: Theme.of(context).textTheme.displayLarge,),
                  SizedBox(height: 16,),

                  // Task List
                  Expanded(
                    child: ListView.builder(
                      itemCount: alltasks.length,
                      itemBuilder: (context, index) {
                        final taskname = alltasks[index];
                        return Container(

                            margin: EdgeInsets.only(bottom: 9),
                            padding: EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: isDark?Color(0xff282828):Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: isDark?Color(0xff282828):Colors.grey
                              )
                            ),
                            width: 343,
                            child:
                              Row(
                               children: [
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 10)
                                  , child:Checkbox(value:taskname.isdone?? false,
                                      onChanged: (bool? isChecked) {
                                        setState(() {
                                          taskname.isdone = isChecked ?? false;
                                          separateTasks();
                                        });
                                        saveTasks();
                                        saveTasksSeparately();
                                      },



                                      activeColor:Color(0xff15B86C),


                                    ),


                        ),

                        Expanded(
                        child:
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children:
                                  [

                                  Text(
                                    taskname.description ,

                                    style: taskname.isdone
                                        ? Theme.of(context).textTheme.displayLarge?.copyWith(
                                        decoration: TextDecoration.lineThrough,
                                        color: Colors.grey)
                                        : Theme.of(context).textTheme.displayLarge,




                                  ),
                                    Text(
                                      taskname.Title ,
                                      style:
                                           Theme.of(context).textTheme.displaySmall
                                    ),
                                    SizedBox(height:2),
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
                                          setState(() {

                                            taskname.isdone = !taskname.isdone;

                                            separateTasks();
                                          });

                                          saveTasks();
                                          saveTasksSeparately();
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
                                alltasks.removeAt(index);
                                setState(() {
                                  separateTasks();
                                });
                               saveTasks();
                               saveTasksSeparately();
                                    break;
                        }

                        });

                        })  ] ,

                          ),
                        );

                      }
                    ),
                    ),
                // Add Task Button
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TasksScreen()),
                      );
                    },
                    child: Text(
                      "+ Add New Task",
                      style:Theme.of(context).textTheme.displaySmall,
                    ),
                    style:Theme.of(context).elevatedButtonTheme.style,
                    ),
                  ),



]
      )
    )));
  }
}
