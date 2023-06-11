import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterfirebase/controller/contact_controller.dart';
import 'package:flutterfirebase/view/add_contact.dart';

class Contact extends StatefulWidget {
  const Contact({super.key});

  @override
  State<Contact> createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  var cc = ContactController();

  @override
  void initState() {
    cc.getContact();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Contact List',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: StreamBuilder<List<DocumentSnapshot>>(
                  stream: cc.stream,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    final List<DocumentSnapshot> data = snapshot.data!;

                    return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: InkWell(
                           // onLongPress: () {},
                            child: Card(
                              elevation: 10,
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: Colors.blue,
                                  child: Text(
                                    data[index]['name']
                                        .substring(0, 1)
                                        .toUpperCase(),
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                title: Text(data[index]['name']),
                                subtitle: Text(data[index]['phone']),
                                trailing: Row(children: [
                                IconButton(
                                  icon: const Icon(Icons.update),
                                  onPressed: () {},
                                ),
                                 IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () { 
                                    cc.deleteContact(data[index]['id'].toString());
                                setState(() {
                                  cc.getContact();},
                                );}),
                                ],)            
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddContact(),
              ),
            );
          },
          child: const Icon(Icons.add),
        ));
  }
}
