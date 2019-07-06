import 'package:flutter/material.dart';

import 'contact_list.dart';
import 'contact_model.dart';

class ContactPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _buildContactList() {
      return <ContactModel>[
        const ContactModel(
            name: 'Romain Hoogmoed', email: 'romain.hoogmoed@example.com'),
        const ContactModel(
            name: 'Emilie Olsen', email: 'emilie.olsen@example.com'),
        const ContactModel(
            name: 'Nishant Srivastava',
            email: 'nishant.srivastava@example.com'),
        const ContactModel(
            name: 'Romain Hoogmoed', email: 'romain.hoogmoed@example.com'),
        const ContactModel(
            name: 'Emilie Olsen', email: 'emilie.olsen@example.com'),
        const ContactModel(
            name: 'Nishant Srivastava',
            email: 'nishant.srivastava@example.com'),
        const ContactModel(
            name: 'Romain Hoogmoed', email: 'romain.hoogmoed@example.com'),
        const ContactModel(
            name: 'Emilie Olsen', email: 'emilie.olsen@example.com'),
        const ContactModel(
            name: 'Nishant Srivastava',
            email: 'nishant.srivastava@example.com'),
      ];
    }

    return Container(
      child: Center(
        child: ContactListView(_buildContactList()),
      ),
    );
  }
}
