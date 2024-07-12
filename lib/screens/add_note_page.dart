import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:notes_app_bloc/bloc/note_bloc.dart';
import 'package:notes_app_bloc/bloc/note_event.dart';
import 'package:notes_app_bloc/models/note_model.dart';

class AddNotePage extends StatelessWidget {
  AddNotePage({super.key});

  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black38,
        body: Padding(
            padding: const EdgeInsets.all(10.0),
            child:  Column(
        children: [
        Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(onPressed: (){
              Navigator.pop(context);
            }, icon: Icon(Icons.arrow_back_ios_new, size: 32, color: Colors.white,)),
            TextButton(onPressed: () async{
              if(titleController.text.isNotEmpty && descController.text.isNotEmpty){
                DateTime dateNow = DateTime.now();
                String fDateNow = DateFormat('MMMM d, yyyy').format(dateNow);
                NoteModel noteModel = NoteModel(title: titleController.text, desc: descController.text, mColor: Random().nextInt(20), date: fDateNow, userId: 1);
                context.read<NoteBloc>().add(InsertDataEvent(noteModel: noteModel));
                Navigator.pop(context);
              }else{
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Missing Title or Description!"))
                ) ;
              }
            },
                child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 15),
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(12)
                    ),
                    child: Text("Save", style: TextStyle(color: Colors.white, fontSize: 16, ),)))
          ],
        ),
        SizedBox(height: 40,),
        TextField(
          controller: titleController,
          cursorColor: Colors.grey,
          style: TextStyle(
              fontSize: 18,
              color: Colors.white
          ),
          decoration: InputDecoration(
              labelText: "Title",
              labelStyle: TextStyle(
                  color: Colors.white
              ),
              hintText: "Enter Title",
              focusColor: Colors.grey,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey)
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.white)
              )
          ),
        ),
        SizedBox(height: 30,),
        TextField(
          maxLines: 7,
          controller: descController,
          cursorColor: Colors.grey,
          style: TextStyle(
              fontSize: 16,
              color: Colors.white
          ),
          decoration: InputDecoration(
              labelStyle: TextStyle(
                  color: Colors.white
              ),
              hintText: "Write a note...",
              hintStyle: TextStyle(color: Colors.white38),
              focusColor: Colors.grey,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey)
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.white)
              )
          ),
        ),
        ],
      )
        ),
      ),
    );
  }
}
