import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class componentoftextform extends StatelessWidget {
  final GlobalKey<FormState> key = GlobalKey<FormState>();
   int ? maxlines;
  final TextEditingController cont ;
  final String Title;
  final String Description;
 final Function (String ?)? validator;
 componentoftextform({
    required this.Title,
   required this.Description,
   this. maxlines,
  this.validator,
   required this.cont,

});


  @override
  Widget build(BuildContext context) {
    return

         Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
          Text('${Title}',
          style:Theme.of(context).textTheme.displayLarge,

        ),

    SizedBox(height: 8,),
    TextFormField(
      maxLines: maxlines,
    controller:cont,

      validator:
    validator!=null ? (String ?value) =>validator!(value):null,
   decoration: InputDecoration(
    hintText: '${Description}',
    hintStyle: TextStyle(
    fontWeight: FontWeight.w400,

    ),
    filled: true,

    border:OutlineInputBorder(
    borderRadius:BorderRadius.all(Radius.circular(16)),
    ),
    ),
    ),
          ],
        );

  }
}
