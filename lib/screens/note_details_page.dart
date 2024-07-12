import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app_bloc/bloc/note_bloc.dart';
import 'package:notes_app_bloc/bloc/note_event.dart';
import 'package:notes_app_bloc/bloc/note_state.dart';

import '../models/note_model.dart';

class NoteDetailsPage extends StatefulWidget {
  NoteModel noteModel;
  int index;
  NoteDetailsPage({super.key, required this.noteModel, required this.index});

  @override
  State<NoteDetailsPage> createState() => _NoteDetailsPageState();
}

class _NoteDetailsPageState extends State<NoteDetailsPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  bool editMode = false;
  NoteModel? updatedNote;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black38,
      appBar: AppBar(
        backgroundColor: Colors.black12,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              size: 30,
              color: Colors.white,
            )),
        actions: [
          Container(
              width: 50,
              height: 50,
              margin: EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey.withOpacity(0.5)),
              child: IconButton(
                icon: editMode
                    ? Icon(Icons.save, size: 32, color: Colors.white)
                    : Icon(Icons.create_rounded,
                    size: 32, color: Colors.white),
                onPressed: () async {
                  bool updated;
                  if (editMode) {

                    NoteModel noteUpdated = NoteModel(id: widget.noteModel.id, title: titleController.text, desc: descController.text, mColor: widget.noteModel.mColor, date: widget.noteModel.date, userId: widget.noteModel.userId);
                    context.read<NoteBloc>().add(UpdateDataEvent(noteModel: noteUpdated));

                    //This
                    //updatedNote = await AppDatabase.db.getSingleNote(userId: widget.noteModel.userId, noteId: widget.noteModel.id);
                    //print(updatedNote?.title);
                    editMode = false;
                  } else {
                    editMode = true;
                  }
                  setState(() {
                    titleController.text = updatedNote != null ?  updatedNote!.title : widget.noteModel.title;
                    descController.text = updatedNote != null ?  updatedNote!.desc : widget.noteModel.desc;
                  });
                },
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: BlocBuilder<NoteBloc, NoteState>(
          builder: (context, state){
              state is LoadedState ? updatedNote = state.dataList[widget.index]: updatedNote = null;
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  editMode
                      ? TextField(
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                        color: Colors.white),
                    controller: titleController,
                    decoration: InputDecoration(
                        label: Text('Title'),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  )
                      : Text(
                    updatedNote != null ?  updatedNote!.title : widget.noteModel.title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "${widget.noteModel.date}",
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  editMode
                      ? TextField(
                    maxLines: 7,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white),
                    controller: descController,
                    decoration: InputDecoration(
                        label: Text('Description'),
                        hintText: "Write a note...",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                  )
                      : Text(
                    updatedNote != null ?  updatedNote!.desc : widget.noteModel.desc,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white),
                  )
                ],
              );
          },
        )
      ),
    );
  }
}
