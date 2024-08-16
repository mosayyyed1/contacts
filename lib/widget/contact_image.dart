import 'package:flutter/material.dart';

class ContactImage extends StatelessWidget {
  final String url;

  const ContactImage({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 65,
      backgroundImage: NetworkImage(url),
      backgroundColor: Colors.white,
    );
  }
}
