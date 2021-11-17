import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({Key? key}) : super(key: key);

  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  late List<Contact> contacts;
  bool contactIsGranted = false;

  // mengambil kontak
  Future<List<Contact>> getAllContacts() async {
    contacts = await ContactsService.getContacts();
    return contacts;
  }

  Future<void> _askPermissions() async {
    // memanggil method getContactPermission,
    // di dalamnya terdapat proses request permission
    PermissionStatus permissionStatus = await getContactPermission();
    // apakah hasil request dari getCOntactPermission itu berstatus granted?
    //granted = disetujui
    if (permissionStatus == PermissionStatus.granted) {
      setState(() {
        contactIsGranted = true;
      });
    } else {
      setState(() {
        contactIsGranted = false;
      });
      handleInvalidPermissions(permissionStatus);
    }
  }

  Future<PermissionStatus> getContactPermission() async {
    // ketahui statusnya dulu
    // pertama kali aplikasi di jalankan, status permissionnya belum diketahui
    PermissionStatus permission = await Permission.contacts.status;
    // jika permission tidak granted dan ditolak secara permanen
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.permanentlyDenied) {
      // maka lakukan request permission
      PermissionStatus permissionStatus = await Permission.contacts.request();

      return permissionStatus;
    } else {
      // sebaliknya, return permission tidak perlu lagi request karna statusnya sudah granted
      return permission;
    }
  }

  void handleInvalidPermissions(PermissionStatus permissionStatus) {
    if (permissionStatus == PermissionStatus.denied) {
      final snackBar = SnackBar(content: Text("Access to contact data denied"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (permissionStatus == PermissionStatus.permanentlyDenied) {
      final snackBar =
          SnackBar(content: Text("Contact data is not available on device"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  void initState() {
    _askPermissions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contacts"),
      ),
      body: Column(
        children: [
          (contactIsGranted == true)
              // future builder = widget yang digunakan untuk membuat proses loading
              ? FutureBuilder(
                  // function getAllContacts yang akan dijadikan sebagai penentu apakah nilai itu ada atau tidak
                  future: getAllContacts(),
                  // builder ini akan
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      //tampilkan list kontak ketika snapshot memiliki data
                      return ShowContacts(
                        contacts: contacts,
                      );
                    } else if (snapshot.hasError) {
                      //pesan error ketika snapshot mengalami galat/error
                      return Center(
                        child: Text("Failed to load contacts"),
                      );
                    }

                    // selain dari kedua kondisi, tampilkan loading
                    // laoading tetap terus berjalan smpai snapshot mendapatkan response dari contact atau error
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                )
              : Center(
                  child: Text("Contact is not granted"),
                ),
        ],
      ),
    );
  }
}

class ShowContacts extends StatelessWidget {
  final List<Contact> contacts;

  const ShowContacts({
    Key? key,
    required this.contacts,
  }) : super(key: key);

  String showNumberOrName(int index){
    //cek apakah kontaknya tidak null
    if(contacts[index] != null){
      // cek apakah nilai dari displayname tidak null dan tidak kosong
      if(contacts[index].displayName != null && contacts[index].displayName!.isNotEmpty){
        // tampilkan namanya
        return contacts[index].displayName.toString();
      }else{
        // jika tidak ada nama, cek apakah terdapat nomor telepon?
        if(contacts[index].phones != null && contacts[index].phones!.isNotEmpty){
          //jika iya, maka tampilkan nomor telepon sebagai penggantinya dari nama kontak
          return contacts[index].phones!.map((e) => e.value ).toString();
        } else{
          // kalo tidak muncul pesan no number
          return "No Number";
        }
      }
    } else{
      // pesan error yang didapat ketika nilai contacts adalah null
      return "Data is null";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          return Container(
            child: Text(showNumberOrName(index)),
          );
        },
      ),
    );
  }
}
