import 'package:flutter/material.dart';

import 'contact_model.dart';

class ContactListItem extends StatelessWidget {
  final ContactModel contactModel;

  ContactListItem(this.contactModel);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Text(contactModel.name[0]),
      ),
      title: Text(contactModel.name),
      subtitle: Text(contactModel.email),
    );
  }
}
