import 'package:flutter/material.dart';
import 'package:materi_tambahan1/pages/image_handling.dart';

import 'contacts_page.dart';


class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
      ),
      body: Column(
        children: [
          // image handling
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ImageHandling(),
                ),
              );
            },
            child: Text("Image Handling"),
          ),

          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ContactsPage(),
                ),
              );
            },
            child: Text("Contacts"),
          ),

        ],
      ),
    );
  }
}
