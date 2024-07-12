import '../models/note_model.dart';

abstract class NoteState{}

class InitialState extends NoteState{}

class LoadingState extends NoteState{}

class LoadedState extends NoteState{
  List<NoteModel> dataList;
  LoadedState({required this.dataList});
}

class ErrorState extends NoteState{
  String errorMessage;
  ErrorState({required this.errorMessage});
}

