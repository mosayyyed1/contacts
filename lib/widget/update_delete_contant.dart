import 'package:contact_app/widget/save_botton.dart';
import 'package:flutter/material.dart';

import '../database/database_helper.dart';
import '../models/contact.dart';
import '../views/home_view.dart';
import 'contact_image.dart';
import 'contact_text_field.dart';
import 'delete_botton.dart';

class UpdateDelete extends StatefulWidget {
  final Contact contact;

  const UpdateDelete({super.key, required this.contact});

  @override
  State<UpdateDelete> createState() => _UpdateDeleteState();
}

class _UpdateDeleteState extends State<UpdateDelete> {
  TextEditingController? nameController;
  TextEditingController? phoneController;
  TextEditingController? imgController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.contact.name);
    phoneController = TextEditingController(text: widget.contact.phone);
    imgController = TextEditingController(text: widget.contact.imgUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.contact.name),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0).copyWith(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            children: [
              ContactImage(url: widget.contact.imgUrl),
              LabeledTextField(
                labelText: 'Contact Name',
                onChanged: (val) => widget.contact.name = val,
              ),
              LabeledTextField(
                labelText: 'Phone Number',
                onChanged: (val) => widget.contact.phone = val,
              ),
              LabeledTextField(
                labelText: 'Img Url',
                onChanged: (val) => widget.contact.imgUrl = val,
              ),
              const SizedBox(height: 15),
              SaveButton(
                onSave: () async {
                  await DatabaseHelper().getContacts;
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => const HomeView()),
                      (Route<dynamic> route) => false);
                },
              ),
              const SizedBox(height: 10),
              DeleteButton(
                onDelete: () async {
                  await DatabaseHelper().deleteContact(widget.contact.id!);
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => const HomeView()),
                      (Route<dynamic> route) => false);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
