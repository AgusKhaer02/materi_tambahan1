import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';

class DetailContact extends StatelessWidget {
  final Contact contact;

  const DetailContact({Key? key, required this.contact}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Contact"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("ID = ${contact.identifier}"),
          Text("Display Name = ${contact.displayName}"),
          Text("Given Name = ${contact.givenName}"),
          Text("Middle Name = ${contact.middleName}"),
          Text("Prefix = ${contact.prefix}"),
          Text("Suffix = ${contact.suffix}"),
          Text("Family Name = ${contact.familyName}"),
          Text("Company = ${contact.company}"),
          Text("Job Title = ${contact.jobTitle}"),
          Text("Andoir Account Type RAW = ${contact.androidAccountTypeRaw}"),
          Text("Andoir Account Name = ${contact.androidAccountName}"),
          Expanded(
            child: ListView.builder(
              itemCount: contact.phones!.length,
              itemBuilder: (context,index) {
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(contact.phones![index].label!),
                      Text(contact.phones![index].value!),
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
