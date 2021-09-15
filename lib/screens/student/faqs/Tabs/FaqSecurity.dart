import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FaqSecurity extends StatefulWidget {
  FaqSecurity({Key key}) : super(key: key);

  @override
  _FaqSecurityState createState() => _FaqSecurityState();
}

class _FaqSecurityState extends State<FaqSecurity> {
  CollectionReference faqs = FirebaseFirestore.instance.collection('FAQs').where('section', isEqualTo: 'Security Section');
  @override
  Widget build(BuildContext context) {
    return Container(
     
    );
  }
}