import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app_bloc/bloc/note_event.dart';
import 'package:notes_app_bloc/bloc/note_state.dart';

import '../database/app_database.dart';

class NoteBloc extends Bloc<DbEvent, NoteState>{
  AppDatabase db;
  NoteBloc({required this.db}): super(InitialState()){

    on<InsertDataEvent>((event, emit) async{
      emit(LoadingState());

      var check = await db.insertNotes(noteModel: event.noteModel);
      if(check){
        var data = await db.fetchUsersNotes(userId: 1);
        emit(LoadedState(dataList: data));
      }else{
        emit(ErrorState(errorMessage: "Error: Item not inserted."));
      }
    });

    on<GetAllDataEvent>((event, emit) async{
      emit(LoadingState());
      var allNotes = await db.fetchUsersNotes(userId: 1);
      emit(LoadedState(dataList: allNotes));
    });

    on<DeleteDataEvent>((event, emit) async{
      bool deleted = await db.deleteNote(noteId: event.noteId);
      if(deleted){
        var noteList = await db.fetchUsersNotes(userId: 1);
        emit(LoadedState(dataList: noteList));
      }else{
        emit(ErrorState(errorMessage: "Error: Couldn't Delete"));
      }
    });
    
    on<UpdateDataEvent>((event, emit) async{
      emit(LoadingState());
      var updated = await db.updateNote(noteModel: event.noteModel);
      if(updated){
        var noteList = await db.fetchUsersNotes(userId: 1);
        emit(LoadedState(dataList: noteList));
      }else{
        emit(ErrorState(errorMessage: "Error: Couldn't Update"));
      }
    });
  }
}