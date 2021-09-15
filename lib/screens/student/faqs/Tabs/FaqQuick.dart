import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FaqQuick extends StatefulWidget {
  FaqQuick({Key key}) : super(key: key);

  @override
  _FaqQuickState createState() => _FaqQuickState();
}

class _FaqQuickState extends State<FaqQuick> {
    CollectionReference faqs = FirebaseFirestore.instance.collection('FAQs').where('section', isEqualTo: 'Quick Section');
  @override
  Widget build(BuildContext context) {
    return Container(

    );
  }
}