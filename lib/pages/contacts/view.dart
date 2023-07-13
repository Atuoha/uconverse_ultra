import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'widgets/contacts_list.dart';
import 'controller.dart';

class ContactsPage extends GetView<ContactsController> {
  const ContactsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: const ContactList(),
    );
  }
}

// appbar
AppBar _buildAppBar() {
  return AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: Colors.transparent,
    title: const Text(
      'Select Contact',
      style: TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: 16,
      ),
    ),
    leading: Builder(
      builder: (context) => GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: const Icon(
          Icons.chevron_left,
          color: Colors.grey,
        ),
      ),
    ),
    actions: const [
      IconButton(
        onPressed: null,
        icon: Icon(
          Icons.search,
        ),
      )
    ],
  );
}
