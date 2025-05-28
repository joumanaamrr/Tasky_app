import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasky/AddTaskScreen.dart';


class LoginScreen extends StatelessWidget {
  static const String Routname = 'LoginScreen';

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 121, top:70),
                child: SvgPicture.asset('assets/images/check.svg',
                  width: 42,
                  height: 42,),
              ),
              SizedBox(width: 16,),
              Padding(
                padding: const EdgeInsets.only(top: 70),
                child: Text('Tasky',
                  style: Theme
                      .of(context)
                      .textTheme
                      .displayMedium,),
              ),
            ],
          ),
              SizedBox(height: 118,),


                        Center(
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left:76),
                                child: Text('Welcome to Tasky',
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .displayLarge,
                                textAlign: TextAlign.center,),
                              ),
                              SizedBox(width: 14,),
                              Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child:Image.asset('assets/images/hand.svg')
                              ),
                            ],
                          ),
                        ),
          SizedBox(height: 8,),
          Padding(
            padding: const EdgeInsets.only(right:20),
            child: Text('Your productivity journey starts here.',
            style: Theme.of(context).textTheme.displaySmall,),
          ),
          SizedBox(height: 24,),
          SvgPicture.asset('assets/images/backgroundd.svg'),
          SizedBox(height: 28,width: 9,),

                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Container(
                    alignment: Alignment.topLeft,
                    child: Text('Full Name',
                    style:Theme.of(context).textTheme.displaySmall,
                    ),
                  ),

                ),
          SizedBox(height: 8,),
          TextField(decoration: InputDecoration(
            labelText: 'e.g. Joumana Amr',
            filled: true,
            fillColor: Color(0xff282828),
            border:OutlineInputBorder(
              borderRadius:BorderRadius.all(Radius.circular(16)),
            ),
    ),
          ),
          SizedBox(height: 24,),
          ElevatedButton(onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => AddTaskScreen(),
                ),
              );
            },
            child: Text(
              'Let\'s Get Started',
              style: Theme.of(context).textTheme.displaySmall,
            ),
            style: Theme.of(context).elevatedButtonTheme.style,
          )









        ],

      ),

    );
  }
}