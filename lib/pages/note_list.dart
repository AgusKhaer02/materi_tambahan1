import 'package:flutter/material.dart';
import 'package:materi_tambahan1/app_database.dart';
import 'package:materi_tambahan1/model/note_model.dart';

class NoteList extends StatefulWidget {
  const NoteList({Key? key}) : super(key: key);

  @override
  _NoteListState createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Daftar Note"),
      ),
      body: buildFeatureNote(),
    );
  }

  Widget buildFeatureNote() {
    return FutureBuilder(
        future: getAllNote(),
        builder: (context, AsyncSnapshot<List<NoteModel>> data) {
          if (data.hasData) {
            return listViewBuilder(data);
          } else if (data.hasError) {
            return Center(
              child: Text("Terjadi Error"),
            );
          } else {
            return CircularProgressIndicator();
          }
        });
  }

  Future<List<NoteModel>> getAllNote() async {
    final db = await $FloorAppDatabase.databaseBuilder("db_note.db").build();
    return await db.noteDao.getAllNote();
  }

  Widget listViewBuilder(AsyncSnapshot<List<NoteModel>> data) {
    // print(data.data?.length);
    return Column(
      children: [
        Container(
          height: 200,
          child: ListView.builder(
              itemCount: data.data?.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Text(data.data![index].judulNote.toString()),
                        Text(data.data![index].isiNote.toString()),
                      ],
                    ),
                  ),
                );
              },
          ),
        ),
      ],
    );
  }
}
