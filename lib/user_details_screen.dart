import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky/components/componentoftextform.dart';
import 'package:tasky/home_screen.dart';

class UserDetails extends StatefulWidget{
  @override
  State<UserDetails> createState() => _UserDetailsState();

}

class _UserDetailsState extends State<UserDetails> {
  String ? username;
  String ? quote;
  TextEditingController usercont =TextEditingController();
  TextEditingController quotecont=TextEditingController();
  @override
  void initState(){
    super.initState();
    loadquote();
    loadusername();
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
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return
      Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: componentoftextform(Title: 'User Name',
                  Description: username ?? '..',
                  cont: usercont,),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: componentoftextform(Title: 'Motivation Quote',
                  Description: quote ?? 'One task at a time. One step closer.',
                  cont: quotecont,
                  maxlines:4,),
              ),
              SizedBox(height: 5,),
              ElevatedButton(onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Changes Are Saved!")),
                );
                SaveQuote();
                Saveusername();
                loadusername();
                loadquote();
              }, child: Text("Save Changes!", style: Theme
                  .of(context)
                  .textTheme
                  .displaySmall,))

            ],
          ),
        ),


      );
  }}