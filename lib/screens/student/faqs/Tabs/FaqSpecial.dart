import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FaqSpecial extends StatefulWidget {
  FaqSpecial({Key key}) : super(key: key);

  @override
  _FaqSpecialState createState() => _FaqSpecialState();
}

class _FaqSpecialState extends State<FaqSpecial> {
    CollectionReference faqs = FirebaseFirestore.instance.collection('FAQs').where('section', isEqualTo: 'Special Section');
  @override
  Widget build(BuildContext context) {
    return Container(

    );
  }
}