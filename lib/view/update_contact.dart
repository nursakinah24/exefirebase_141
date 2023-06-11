/* import 'package:flutter/material.dart';
import 'package:flutterfirebase/controller/contact_controller.dart';
import 'package:flutterfirebase/model/contact_model.dart';

class EditContact extends StatefulWidget {
  final ContactModel contact;

  EditContact({required this.contact});

  @override
  State<EditContact> createState() => _EditContactState();
}

class _EditContactState extends State<EditContact> {
  var contactController = ContactController();
  final _formKey = GlobalKey<FormState>();
  late String name;
  late String phone;
  late String email;
  late String address;

  @override
  void initState() {
    super.initState();
    name = widget.contact.name;
    phone = widget.contact.phone;
    email = widget.contact.email;
    address = widget.contact.address;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Contact'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Name',
                ),
                initialValue: name,
                onChanged: (value) => name = value,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Phone',
                ),
                initialValue: phone,
                onChanged: (value) => phone = value,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Email',
                ),
                initialValue: email,
                onChanged: (value) => email = value,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Address',
                ),
                initialValue: address,
                onChanged: (value) => address = value,
              ),
              ElevatedButton(
                onPressed: () {
                  ContactModel updatedContact = ContactModel(
                    name: name,
                    phone: phone,
                    email: email,
                    address: address,
                  );
                  contactController.updatedContact();
                  Navigator.pop(context);
                },
                child: const Text('Update Contact'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
 */