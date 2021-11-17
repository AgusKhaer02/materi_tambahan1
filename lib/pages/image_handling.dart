import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

typedef void OnPickImageCallback(
    double? maxWidth, double? maxHeight, int? quality);

class ImageHandling extends StatefulWidget {
  const ImageHandling({Key? key}) : super(key: key);

  @override
  _ImageHandlingState createState() => _ImageHandlingState();
}

class _ImageHandlingState extends State<ImageHandling> {
  final ImagePicker picker = ImagePicker();
  String? path;
  Uint8List? imageBytes;
  List<String>? listImagePath = List.empty(growable: true);//ini untuk initial value dari list nya;

  pickCameraMultiple() async {
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    path = image!.path;
    imageBytes = await File(path!).readAsBytes();
    // tambahkan ke listImageBytes
    listImagePath!.add(path!);
    setState(() {});
  }

  pickGallery() async {
    // buka aplikasi galery bawaan
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    //  hasil response dari aplikasi gallery akan mengambil pathnya
    path = image!.path;
    //  kemudian untuk pathnya akan di konversikan ke dalam format Uint8List
    imageBytes = await File(path!).readAsBytes();
    // render halaman ulang
    setState(() {});
  }

  captureCamera() async {
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    path = image!.path;
    imageBytes = await File(path!).readAsBytes();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print("setState");
    return Scaffold(
      appBar: AppBar(
        title: Text("Image Handling"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ElevatedButton(
            onPressed: () {
              pickGallery();
            },
            child: Text("Pick from Gallery"),
          ),
          ElevatedButton(
            onPressed: () {
              captureCamera();
            },
            child: Text("Pick from Camera"),
          ),
          ElevatedButton(
            onPressed: () {
              pickCameraMultiple();
            },
            child: Text("Add image from Camera"),
          ),
          SizedBox(
            height: 40,
          ),
          (imageBytes != null)
              ? Image.memory(
                  imageBytes!,
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                )
              : SizedBox(),
          (listImagePath != null)
              ? Expanded(
                  child: ListView.builder(
                    itemCount: listImagePath!.length,
                    itemBuilder: (context, index) {
                      return Image.file(
                        File(listImagePath![index]),
                        width: 200,
                        height: 200,
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                )
              : SizedBox(),
        ],
      ),
    );
  }
}
