import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expansion_card/expansion_card.dart';
import 'package:flutter/material.dart';
import 'package:nuts_activity_indicator/nuts_activity_indicator.dart';

class FaqLending extends StatefulWidget {
  FaqLending({Key key}) : super(key: key);

  @override
  _FaqLendingState createState() => _FaqLendingState();
}

class _FaqLendingState extends State<FaqLending> {
  Query faqs = FirebaseFirestore.instance
      .collection('FAQs')
      .where('section', isEqualTo: 'Lending Section');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[700],
      body: StreamBuilder(
        stream: faqs.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  'An error ocuurred while fetching data',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 20,
                  ),
                ),
              ),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: NutsActivityIndicator(
                    activeColor: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Center(
                  child: Text(
                    'Loading...',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
                ),
              ],
            );
          }
          return ListView.builder(
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(15),
                child: ExpansionCard(
                  // backgroundColor: Colors.blue,
                  borderRadius: 60,
                  title: Text(
                    snapshot.data.docs[index]['faqQuestion'],
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                  children: [
                    Text(
                      snapshot.data.docs[index]['faqAnswer'],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
