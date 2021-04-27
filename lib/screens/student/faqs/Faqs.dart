import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nuts_activity_indicator/nuts_activity_indicator.dart';

class FAQS extends StatefulWidget {
  FAQS({Key key}) : super(key: key);

  @override
  _FAQSState createState() => _FAQSState();
}

class _FAQSState extends State<FAQS> {
  // List<Faq> _question = generateQuestion(15);

  CollectionReference faqs = FirebaseFirestore.instance.collection('FAQs');

  // Widget _buildFaqsPanel() {
  //   return ExpansionPanelList(
  //     expansionCallback: (int index, bool isExpanded) {
  //       setState(() {
  //         _question[index].isExpanded = !isExpanded;
  //       });
  //     },
  //     children: _question.map<ExpansionPanel>((Faq faq) {
  //       return ExpansionPanel(
  //           headerBuilder: (context, isExpanded) {
  //             return ListTile(
  //               title: Text(faq.headerValue),
  //             );
  //           },
  //           body: ListTile(
  //             title: Text(faq.expandedValue),
  //           ),
  //           isExpanded: faq.isExpanded,
  //         );
  //     }).toList(),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        elevation: 0.5,
        title: Text(
          "FAQ's",
          style: TextStyle(color: Colors.blue),
        ),
        backgroundColor: Colors.white,
        actions: <Widget>[
          FlatButton(onPressed: () {}, child: Text('Ask A Question'))
        ],
      ),
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
                    activeColor: Colors.blue,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Center(
                  child: Text(
                    'Loading...',
                    style: TextStyle(
                      color: Colors.blue,
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
                padding: const EdgeInsets.all(10),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        snapshot.data.docs[index]['faqQuestion'],
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        snapshot.data.docs[index]['faqAnswer'],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

// return SingleChildScrollView(
//             physics: BouncingScrollPhysics(),
//             child: Container(
//               child: Text('Yes'),
//             ),
//           );

// class Faq {
//   String expandedValue;
//   String headerValue;
//   bool isExpanded;

//   Faq({this.expandedValue, this.headerValue, this.isExpanded = false});
// }

// List<Faq> generateQuestion(int numberOfQuestions) {
//   return List.generate(numberOfQuestions, (index) {
//     return Faq(
//       headerValue: 'Question $index',
//       expandedValue: 'This is the answer to the question to be displayed',
//     );
//   });
// }
