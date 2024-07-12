import 'package:notes_app_bloc/models/note_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase{
  //singleton class creation
  AppDatabase._();

  static final AppDatabase db = AppDatabase._();

  static const String DB_NAME = "smart_notes.db";
  static const String NOTES_TABLE = "notes_table";
  static const String COLUMN_NOTES_ID = "note_id";
  static const String COLUMN_NOTE_TITLE = 'note_title';
  static const String COLUMN_NOTE_DESC = 'note_desc';
  static const String COLUMN_NOTE_COLOR_CODE = 'note_color';
  static const String COLUMN_NOTE_DATE = 'note_date';
  static const String COLUMN_USER_ID = 'user_id';

  Database? mDB;

  Future<Database> getDB() async{
    if(mDB != null){
      return mDB!;
    }else{
      mDB = await openDB();
      return mDB!;
    }
  }

  Future<Database> openDB() async{
    var rootPath = await getApplicationDocumentsDirectory();
    var dbPath = join(rootPath.path, DB_NAME);
    return await openDatabase(dbPath, version: 1 ,
        onCreate: (db, version){
          db.execute(
              'create table $NOTES_TABLE ($COLUMN_NOTES_ID integer primary key autoincrement, $COLUMN_NOTE_TITLE text, $COLUMN_NOTE_DESC text, $COLUMN_NOTE_COLOR_CODE integer, $COLUMN_NOTE_DATE text, $COLUMN_USER_ID integer)'
          );
    });
  }

  Future<bool> insertNotes({required NoteModel noteModel}) async{
      var mainDB = await getDB();
      int rowEffect = await mainDB.insert(NOTES_TABLE, noteModel.toMap());
      return rowEffect > 0;
  }

  Future<List<NoteModel>> fetchUsersNotes({required userId}) async{
    var mainDB = await getDB();
    var noteList = await mainDB.query(NOTES_TABLE, where: "$COLUMN_USER_ID = ?", whereArgs: [userId]);

    List<NoteModel> noteModelList = [];
    for(Map<String, dynamic> eachNote in noteList){
      noteModelList.add(NoteModel.fromMap(eachNote));
    }
    return noteModelList;
  }

  Future<bool> deleteNote({required int noteId}) async{
    var mainDB = await getDB();
    int deleted = await mainDB.delete(NOTES_TABLE, where: "$COLUMN_NOTES_ID = ?", whereArgs: [noteId]);
    return deleted > 0;
  }

  Future<bool> updateNote({required NoteModel noteModel}) async{
    var mainDB = await getDB();
    int updated = await mainDB.update(NOTES_TABLE, noteModel.toMap(), where: "$COLUMN_NOTES_ID = ?", whereArgs:  [noteModel.id]);
    return updated > 0;
  }

  Future<NoteModel> getSingleNote({required userId, required noteId}) async{
    var mainDB = await getDB();
    var notes = await mainDB.query(NOTES_TABLE, where: "$COLUMN_USER_ID = ? and $COLUMN_NOTES_ID = ?", whereArgs: [userId, noteId]);
    return NoteModel.fromMap(notes[0]);
  }
}