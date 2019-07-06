import 'package:flutter/material.dart';

import 'contact_list_item.dart';
import 'contact_model.dart';

class ContactListView extends StatelessWidget {
  final List<ContactModel> contactList;

  ContactListView(this.contactList);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(vertical: 9.0),
      children: buildContactList(),
    );
  }

  List<ContactListItem> buildContactList() {
    //map转换
    return contactList.map((contact) => ContactListItem(contact)).toList();
  }
}
