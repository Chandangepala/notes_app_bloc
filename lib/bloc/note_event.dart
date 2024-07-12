

import 'package:notes_app_bloc/models/note_model.dart';

abstract class DbEvent{}

class InsertDataEvent extends DbEvent {
  NoteModel noteModel;
  InsertDataEvent({required this.noteModel});
}

class GetAllDataEvent extends DbEvent{
  GetAllDataEvent();
}

class DeleteDataEvent extends DbEvent{
  int noteId;
  DeleteDataEvent({required this.noteId});
}

class UpdateDataEvent extends DbEvent{
  NoteModel noteModel;
  UpdateDataEvent({required this.noteModel});
}