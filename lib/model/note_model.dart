import 'package:floor/floor.dart';


// nama tabel
@Entity(tableName: "tb_note")
class NoteModel{
  // kolom id sebagai primary key
  // autogenerate = auto increment
  @PrimaryKey(autoGenerate: true)
  int? id;

  @ColumnInfo(name: "judul_note")
  String? judulNote;

  @ColumnInfo(name: "isi_note")
  String? isiNote;

  NoteModel({this.id, this.judulNote, this.isiNote});

  NoteModel.withoutId(this.judulNote, this.isiNote);
}