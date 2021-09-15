import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FaqReference extends StatefulWidget {
  FaqReference({Key key}) : super(key: key);

  @override
  _FaqReferenceState createState() => _FaqReferenceState();
}

class _FaqReferenceState extends State<FaqReference> {
  CollectionReference faqs = FirebaseFirestore.instance.collection('FAQs').where('section', isEqualTo: 'Reference Section');
  @override
  Widget build(BuildContext context) {
    return Container(

    );
  }
}