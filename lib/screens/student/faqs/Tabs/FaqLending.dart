import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FaqLending extends StatefulWidget {
  FaqLending({Key key}) : super(key: key);

  @override
  _FaqLendingState createState() => _FaqLendingState();
}

class _FaqLendingState extends State<FaqLending> {
  CollectionReference faqs = FirebaseFirestore.instance.collection('FAQs').where('section', isEqualTo: 'Lending Section');
  @override
  Widget build(BuildContext context) {
    return Container(

    );
  }
}