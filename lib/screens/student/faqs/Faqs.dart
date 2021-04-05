import 'package:flutter/material.dart';

class FAQS extends StatefulWidget {
  FAQS({Key key}) : super(key: key);

  @override
  _FAQSState createState() => _FAQSState();
}

class _FAQSState extends State<FAQS> {
  List<Faq> _question = generateQuestion(15);

  Widget _buildFaqsPanel() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _question[index].isExpanded = !isExpanded;
        });
      },
      children: _question.map<ExpansionPanel>((Faq faq) {
        return ExpansionPanel(
            headerBuilder: (context, isExpanded) {
              return ListTile(
                title: Text(faq.headerValue),
              );
            },
            body: ListTile(
              title: Text(faq.expandedValue),
            ),
            isExpanded: faq.isExpanded,
          );
      }).toList(),
    );
  }

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
          FlatButton(onPressed: (){}, child: Text('Ask A Question'))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: _buildFaqsPanel(),
        ),
      ),
    );
  }
}

class Faq {
  String expandedValue;
  String headerValue;
  bool isExpanded;

  Faq({this.expandedValue, this.headerValue, this.isExpanded = false});
}

List<Faq> generateQuestion(int numberOfQuestions) {
  return List.generate(numberOfQuestions, (index) {
    return Faq(
      headerValue: 'Question $index',
      expandedValue: 'This is the answer to the question to be displayed',
    );
  });
}
