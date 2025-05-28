import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TasksScreen extends StatelessWidget{
  static const String Routname='Tasksscreen';
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 70,),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Row(
              children: [
                Text('Task Name',
                style: Theme.of(context).textTheme.displayLarge,
                ),
              ],
            ),
          ),
          SizedBox(height: 8,),
           TextField(


              decoration: InputDecoration(
              labelText: 'Finish UI design for login screen',
              filled: true,
              fillColor: Color(0xff282828),
              border:OutlineInputBorder(
                borderRadius:BorderRadius.all(Radius.circular(16),
                ),

              ),
            ),

          ),
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Row(
              children: [
                Text('Task Description',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ],
            ),
          ),
          SizedBox(height: 8,),

            TextField(
              maxLines: 10,

              decoration: InputDecoration(
              labelText: 'Finish onboarding UI and hand off to devs by Thursday.',

              filled: true,

              fillColor: Color(0xff282828),
              border:OutlineInputBorder(
                borderRadius:BorderRadius.all(Radius.circular(16),
                ),

              ),
            ),
            ),
          SizedBox(height: 20,),
          ElevatedButton(onPressed: (){}, child:Text('+ Add Task',
          style: Theme.of(context).textTheme.displaySmall,),
            style: Theme.of(context).elevatedButtonTheme.style,
          )



        ],
      ),
    );
  }

}