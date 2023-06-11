import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutterfirebase/model/contact_model.dart';

class ContactController {
  final contactCollection = FirebaseFirestore.instance.collection('contacts');

  final StreamController<List<DocumentSnapshot>> streamController =
      StreamController<List<DocumentSnapshot>>.broadcast();

  //untuk menanmpung data
  Stream<List<DocumentSnapshot>> get stream => streamController.stream;

  Future<void> addContact(ContactModel ctmodel) async {
    final contact = ctmodel.toMap();

    final DocumentReference docRef = await contactCollection.add(contact);

    final String docId = docRef.id;

    final ContactModel contactModel = ContactModel(
        id: docId,
        name: ctmodel.name,
        phone: ctmodel.phone,
        email: ctmodel.email,
        address: ctmodel.address);

    await docRef.update(contactModel.toMap());
  }

  Future getContact() async {
    final contact = await contactCollection.get();
    streamController.sink.add(contact.docs);
    return contact.docs;
  }

  Future updateContact(String docId, ContactModel contactModel) async {
    final ContactModel updateContactModel = ContactModel(
      name: contactModel.name,
      email: contactModel.email,
      phone: contactModel.phone,
      address: contactModel.address,
      //city: contactModel.city,
      id: docId
      );

    final DocumentSnapshot documentSnapshot = await contactCollection.doc(docId).get();
    if (!documentSnapshot.exists){
      print('Contact with ID $docId does not exist');
      return;
    }
    final updatedContact = updateContactModel.toMap();
    await contactCollection.doc(docId).update(updatedContact);
    await getContact();
    print('Updated contact with ID: $docId');
  }

  Future deleteContact(String docId) async {
    final contact = await contactCollection.doc(docId).delete();
    return contact;
  }
}
