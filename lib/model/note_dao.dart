import 'package:floor/floor.dart';

import 'note_model.dart';

// setiap query yang akan dieksekusikan,masuknya ke dao
@dao
abstract class NoteDao{
  @insert
  Future<List<int>> insertNote(List<NoteModel> note);

  @Query("SELECT * FROM tb_note")
  Future<List<NoteModel>> getAllNote();

  @Query("DELETE FROM tb_note WHERE id = (:idNote)")
  Future<void> deleteNote(String idNote);
}