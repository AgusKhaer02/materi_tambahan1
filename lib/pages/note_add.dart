import 'package:flutter/material.dart';
import 'package:materi_tambahan1/app_database.dart';
import 'package:materi_tambahan1/model/note_model.dart';

class NoteAddScreen extends StatelessWidget {
  const NoteAddScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: NoteAdd(),
      theme: ThemeData.dark(),
    );
  }
}

class NoteAdd extends StatefulWidget {
  const NoteAdd({Key? key}) : super(key: key);

  @override
  _NoteAddState createState() => _NoteAddState();
}

class _NoteAddState extends State<NoteAdd> {
  TextEditingController _judul = TextEditingController();
  TextEditingController _isiNote = TextEditingController();
  var database;

  @override
  void initState() {
    super.initState();

    //proses untuk membuat databasenya
    initializeDB();
  }

  Future<List<int>> addNote(NoteModel model) async {
    return await database.noteDao.insertNote([model]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Note"),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              controller: _judul,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(),
                labelText: "Judul Note",
              ),
            ),
            SizedBox(
              height: 8,
            ),
            TextField(
              controller: _isiNote,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(),
                labelText: "Isi Note",
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if(_judul.text.toString().isNotEmpty || _isiNote.text.toString().isNotEmpty){
                  populateData();
                }else{
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Semua kolom harus diisi"),));
                }

              },
              child: Text("Simpan"),
            ),
          ],
        ),
      ),
    );
  }

  // membuat database yang mengakses function dari Class FloorAppdatabase
  Future<void> initializeDB() async {
    database = await $FloorAppDatabase.databaseBuilder("db_note.db").build();
  }

  void populateData() async {
    NoteModel model =
        NoteModel.withoutId(_judul.text.toString(), _isiNote.text.toString());
    // print(model.id);
    // print(model.judulNote);
    // print(model.isiNote);

    var status = await addNote(model);
    if (status.length > 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Note berhasil disimpan"),
        ),
      );
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Note gagal disimpan"),
        ),
      );
    }
  }
}
