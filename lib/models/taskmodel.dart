import 'package:flutter/foundation.dart';

class taskmodel{
  int id;
  String Title;
  String description;
  bool ishighpriority;
   bool isdone;
  taskmodel({
 required this.id,
  required this.description,
   required this.ishighpriority,
  required this.Title,
   required this.isdone,

  });
  Map<String,dynamic> toMap(){
    return{
      'id':id,
      'description':description,
      'Title':Title,
      'ishighpriority':ishighpriority,
      'isdone':isdone,

 };
}
  factory taskmodel.fromMap(Map<String,dynamic> map){
    return taskmodel(
        id: map['id'] as int,
        description: map['description']as String,
        ishighpriority: map['ishighpriority']as bool,
        Title: map['Title'] as String,
      isdone: map['isdone'] as bool,
    );

  }

}