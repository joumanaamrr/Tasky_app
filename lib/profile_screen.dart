import 'dart:io'; // ✅ This is the correct import for File


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky/login_screen.dart';
import 'package:tasky/user_details_screen.dart';

import 'Services/theme_notifier.dart';

class ProfileScreen extends StatefulWidget{
  static const String Routname='Profilescreen';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();

}


class _ProfileScreenState extends State<ProfileScreen> {
  String? username;
  String? quote;
  bool isdark = true;
  final TextEditingController usercont=TextEditingController();
  final TextEditingController quotecont=TextEditingController();


  @override
  void initState() {
    super.initState();
    loadusername();
    loadquote();
    loadImage();

  }

  File? _image;
  Future<void> loadImage() async {
    final prefs = await SharedPreferences.getInstance();
    final path = prefs.getString('image');
    if (path != null && File(path).existsSync()) {
      setState(() {
        _image = File(path);
      });
    }
  }

  Future<void> _pickImage() async {
    try {
      print("Opening image picker...");
      final ImagePicker _picker = ImagePicker();
      final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        print("Picked file: ${pickedFile.path}");
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('image', pickedFile.path);
        setState(() {
          _image = File(pickedFile.path);
        });
      } else {
        print("No image selected.");
      }
    } catch (e) {
      print("Error picking image: $e");
    }
  }

  Future<void>loadusername()async{
    SharedPreferences pref=await SharedPreferences.getInstance();
    String? loadedname=pref.getString('user');
    setState(() {
      username=loadedname;

    });
  }
  Future<void>loadquote()async{
    SharedPreferences pref=await SharedPreferences.getInstance();
    String? loadedquote=pref.getString('quote');
    setState(() {
      quote=loadedquote;

    });
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(

        title: Text("My Profile", style: Theme
            .of(context)
            .textTheme
            .displayLarge,),
        centerTitle: true,
      ),
      body: Column(

        children: [
          SizedBox(height: 8),

          Padding(
            padding: const EdgeInsets.only(left: 30),
            child:InkWell(
              borderRadius: BorderRadius.circular(7),
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 85,
                    backgroundImage: _image != null
                        ? FileImage(_image!)
                        : AssetImage('assets/images/Thumbnail.jpg') as ImageProvider,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 4,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: _pickImage,
                      child: CircleAvatar(
                        backgroundColor: Colors.black54,
                        radius: 20,
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

          ),

          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Text('${username}', style: Theme
                .of(context)
                .textTheme
                .displayMedium,),
          ),


          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              quote ?? 'One task at a time. One step closer.',
              style: Theme
                  .of(context)
                  .textTheme
                  .displaySmall,

            ),
          ),
          SizedBox(height: 24,),

          Align(
              alignment: Alignment.centerLeft,
              child:
              Padding(
                padding: const EdgeInsets.only(left: 11),
                child: Text('Profile Info', style: Theme
                    .of(context)
                    .textTheme
                    .displayMedium,),
              )),
          SizedBox(height: 14,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 14,),
              Icon(Icons.person_2_outlined,
                color: Colors.grey,
                size: 30,),
              SizedBox(width: 10,),


              Text('User Details', style: Theme
                  .of(context)
                  .textTheme
                  .displayLarge,),
              Spacer(),
              IconButton(onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => UserDetails()));
              }, icon: Icon(Icons.arrow_forward)),

            ],
          ),
          Divider(color: Colors.white,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 14,),
              Icon(Icons.dark_mode_outlined,
                color: Colors.grey,
                size: 30,),
              SizedBox(width: 10,),

              Text('Dark Mode', style: Theme
                  .of(context)
                  .textTheme
                  .displayLarge,),
              Spacer(),
              Switch(
                value: Provider.of<ThemeNotifier>(context).isDarkMode,
                onChanged: (value) {
                  Provider.of<ThemeNotifier>(context, listen: false).toggletheme();
                },
              ),




            ],
          ),
          Divider(color: Colors.white,),
          Row(
              mainAxisAlignment: MainAxisAlignment.start
              ,
              children: [
                SizedBox(height: 14,),
                Icon(Icons.logout_outlined,
                  color: Colors.grey,
                  size: 30,),
                SizedBox(width: 10,),


                Text('Log Out', style: Theme
                    .of(context)
                    .textTheme
                    .displayLarge,),
                Spacer(),
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Log Out Confirmation "),
                          content: Text("Confirm Logout?"),
                          actions: [
                            TextButton(
                              child: Text("Cancel"),
                              onPressed: () {
                                Navigator.of(context).pop(); // Close the dialog
                              },
                            ),
                            TextButton(
                              child: Text("Yes"),
                              onPressed: () {
                                Navigator.of(context).pop(); // Close the dialog
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen()),
                                );
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                  icon: Icon(Icons.arrow_forward),
                ),

              ]
          ),


        ],
      ),
    );
  }
}