import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky/profile_screen.dart';
import 'package:tasky/tasks_screen.dart';
import 'package:tasky/todotasks_screen.dart';

import 'add_task_screen.dart';
import 'completed_tasks_screen.dart';

class HomeScreen extends StatefulWidget{
  static const String Routname='homescreen';
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void initState(){
    super.initState();
    load();
  }
  Future<void>load()async{
    final SharedPreferences pref= await SharedPreferences.getInstance();
    String ? tasks=pref.getString('tasks');
   if(tasks!=null){
     Listoftasks=jsonDecode(tasks);
   }

  }

  int indexx=0;
  List<dynamic> Listoftasks=[];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    List<Widget> screens=[
      AddTaskScreen(),
      Todotasks(),
      CompletedTasks(),
      ProfileScreen(),


    ];

    return Scaffold(
    bottomNavigationBar:   BottomNavigationBar(
        currentIndex: indexx,

        onTap: (index){
          setState(() {
            indexx=index;
          });
        },
        items:[
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(icon:Icon(Icons.list_alt_sharp),label:'ToDo'),
          BottomNavigationBarItem(icon: Icon(Icons.done_outline_rounded),label:'Completed'),
          BottomNavigationBarItem(icon: Icon(Icons.person),label:'Profile'),

        ]),
    body: screens[indexx],
  );
  }
}