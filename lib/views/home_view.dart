import 'package:flutter/material.dart';

import '../database/db_helper.dart';
import '../models/contact.dart';
import '../widget/add_contact_sheet.dart';
import '../widget/contacts_gird.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<Contact> _contacts = [];

  @override
  void initState() {
    super.initState();
    _fetchContacts();
  }

  Future<void> _fetchContacts() async {
    var dbHelper = DatabaseHelper();
    List<Contact> contacts = await dbHelper.getContacts();
    setState(() {
      _contacts = contacts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => const AddContactSheet(),
          ).then((_) => _fetchContacts());
        },
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add, size: 40),
      ),
      appBar: AppBar(
        title: const Text(
          'My Contacts',
          style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        foregroundColor: Colors.blue,
        backgroundColor: Colors.white,
      ),
      body: _contacts.isEmpty
          ? const Center(child: Text('No Contacts Available'))
          : ContactsGrid(contacts: _contacts),
    );
  }
}
