import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasky/add_task_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky/home_screen.dart';



class LoginScreen extends StatelessWidget {
  static const String Routname = 'LoginScreen';

  final GlobalKey<FormState> key= GlobalKey<FormState>();

  final TextEditingController controller=TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: key,
          child: SafeArea(
            child: Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left:90),
                      child: SvgPicture.asset('assets/images/check.svg',
                        width: 42,
                        height: 42,),
                    ),
                    SizedBox(width: 16,),

                     Text('Tasky',
                        style: Theme
                            .of(context)
                            .textTheme
                            .displayMedium,),

                  ],
                ),
                    SizedBox(height:50,),
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
                TextFormField(

                   controller: controller,
                  style: TextStyle(color: Colors.white),
                  validator:(String? value){
                     if(value==null || value.isEmpty){
                       return'This Field is required';
                     }else return null;
                  },
                  decoration: InputDecoration(
                    hintText: 'e.g. Joumana Amr',
                  hintStyle: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.white
                  ),
                  filled: true,
                  fillColor: Color(0xff282828),
                  border:OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xff15B86C),

                    ),
                    borderRadius:BorderRadius.all(Radius.circular(16)),
                  ),
                ),
                ),
                SizedBox(height: 24,),
                ElevatedButton(onPressed: ()async{
                  if(key.currentState?.validate()??false){
                      final SharedPreferences preferences= await SharedPreferences.getInstance();
                     await  preferences.setString('user',controller.text);
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) =>HomeScreen(),
                    ),
                    );
                  }
                },
                  child: Text(
                    'Let\'s Get Started',
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                  style: Theme.of(context).elevatedButtonTheme.style,
                )









              ],

            ),
          ),
        ),
      ),

    );
  }
}