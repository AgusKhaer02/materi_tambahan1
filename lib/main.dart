import 'package:flutter/material.dart';
import 'package:materi_tambahan1/pages/home_page.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Materi Tambahan 1",
      home: HomePage(),
    );
  }
}


