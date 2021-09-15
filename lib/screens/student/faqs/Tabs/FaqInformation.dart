import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FaqInformation extends StatefulWidget {
  FaqInformation({Key key}) : super(key: key);

  @override
  _FaqInformationState createState() => _FaqInformationState();
}

class _FaqInformationState extends State<FaqInformation> {
  CollectionReference faqs = FirebaseFirestore.instance.collection('FAQs').where('section', isEqualTo: 'Information Section');
  @override
  Widget build(BuildContext context) {
    return Container(

    );
  }
}