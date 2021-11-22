import 'package:floor/floor.dart';
import 'package:materi_tambahan1/model/note_dao.dart';
import 'package:materi_tambahan1/model/note_model.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'app_database.g.dart';
// memberitahu kepada compiler untuk melakukan Appdatabase sesuai dengan perlakuan dari Database
@Database(version: 1,entities: [NoteModel])
abstract class AppDatabase extends FloorDatabase{
  NoteDao get noteDao;

}