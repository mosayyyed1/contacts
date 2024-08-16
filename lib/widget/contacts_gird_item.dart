import 'package:flutter/material.dart';

import '../models/contact.dart';
import 'contact_image.dart';

class ContactTile extends StatelessWidget {
  final Contact contact;

  const ContactTile({super.key, required this.contact});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/contactDetails', arguments: contact);
      },
      child: Column(
        children: [
          ContactImage(url: contact.imgUrl),
          Text(
            contact.name,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Text(
            contact.phone,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
