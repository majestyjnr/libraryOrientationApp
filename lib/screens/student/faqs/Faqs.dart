import 'package:LibraryOrientationApp/screens/screens.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expansion_card/expansion_card.dart';
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
      backgroundColor: Colors.blue[700],
      appBar: AppBar(
        brightness: Brightness.light,
        elevation: 0.5,
        title: Text(
          "FAQ's",
          style: TextStyle(color: Colors.blue),
        ),
        backgroundColor: Colors.white,
        actions: <Widget>[
          FlatButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return AskQuestion();
                }));
              },
              child: Text('Ask A Question'))
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
                  // leading: Text(index.toString()),
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

// Padding(
//                 padding: const EdgeInsets.all(13),
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: Colors.blue,
//                     borderRadius: BorderRadius.all(
//                       Radius.circular(15),
//                     ),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(15),
//                     child: Column(
//                       children: [
//                         Text(
//                           snapshot.data.docs[index]['faqQuestion'],
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 17,
//                           ),
//                         ),
//                         SizedBox(
//                           height: 15,
//                         ),
//                         Text(
//                           snapshot.data.docs[index]['faqAnswer'],
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 16,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               );

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
