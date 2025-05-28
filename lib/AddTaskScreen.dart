import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasky/TasksScreen.dart';

class AddTaskScreen extends StatelessWidget{
  static const String Routname='addtaskscreen';
  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Scaffold(
         body: Column(
           children:
               [
           Row(
           children: [
             Padding(
               padding: const EdgeInsets.only(left: 16,top: 60),
               child: Image.asset('assets/images/Thumbnail.jpg'),
             ),

                  Padding(
                    padding: const EdgeInsets.only(left: 16,top: 60),
                    child: Column(
                     children: [
                       Text('Good Evening ,Usama',
                       style: Theme.of(context).textTheme.displayLarge,),
                       Padding(
                         padding: const EdgeInsets.only(left:10),
                         child: Text('One task at a time.One step closer.',
                           style:Theme.of(context).textTheme.displaySmall,),
                       ),
                     ],
                                     ),
                  ),
             Padding(
               padding: const EdgeInsets.only(top:60,left:30),
               child: SvgPicture.asset('assets/images/Icon.svg',
               width: 15,
               height: 15,),
             )
                ]
         ),
                 SizedBox(height: 16,),

        Row( children: [
               Column(

                 children: [

                      Text('Yuhuu,Your Work Is ',
                         style: Theme.of(context).textTheme.displayMedium!.copyWith(
                           fontSize: 32,
                         ),
                         ),

                 Row(
                      children: [

                    Text('Almost Done! ',
                           style: Theme.of(context).textTheme.displayMedium!.copyWith(
                               fontSize: 32
                           ),),

                        Image.asset('assets/images/hand.svg',

                        ),

              ] ),
                   ElevatedButton(onPressed: (){
                     Navigator.push(context, MaterialPageRoute(builder:
                     (context)=>TasksScreen(),
                     ),);
                   }, child:Text("+ Add New Task",
                   style: Theme.of(context).textTheme.displaySmall,),
                     style:Theme.of(context).elevatedButtonTheme.style,

                   )
    ]),
      ])

    ]
         ),



    );
  }

}