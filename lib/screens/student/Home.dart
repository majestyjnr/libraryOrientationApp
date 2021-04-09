import 'package:LibraryOrientationApp/screens/screens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool innerBoxIsScrolled = true;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 8,
      child: Scaffold(
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/uew.png'),
                  ),
                ),
                child: Text(
                  '',
                ),
              ),
              ListTile(
                title: Text('About The App'),
                leading: Icon(
                  CupertinoIcons.news,
                  color: Colors.red,
                ),
                onTap: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (context) {
                  //   return AboutMethodist();
                  // }));
                },
              ),
              Divider(
                height: 0,
              ),
              ListTile(
                title: Text('About The Developers'),
                leading: Icon(
                  CupertinoIcons.news,
                  color: Colors.red,
                ),
                onTap: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (context) {
                  //   return AboutMethodist();
                  // }));
                },
              ),
            ],
          ),
        ),
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                brightness: Brightness.light,
                title: Text(
                  'Library Orientation App',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 20,
                  ),
                ),
                iconTheme: IconThemeData(color: Colors.blue),
                actions: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Image(image: AssetImage('assets/images/uew.png')),
                  ),
                ],
                pinned: true,
                floating: true,
                forceElevated: innerBoxIsScrolled,
                backgroundColor: Colors.white,
                centerTitle: true,
                elevation: 1,
                bottom: TabBar(
                  indicatorColor: Colors.blue,
                  isScrollable: true,
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  tabs: <Widget>[
                    Tab(
                      text: 'Acquisition',
                    ),
                    Tab(
                      text: 'Circulation',
                    ),
                    Tab(
                      text: 'Info Help Desk',
                    ),
                    Tab(
                      text: 'Lending',
                    ),
                    Tab(
                      text: 'Quick Reference',
                    ),
                    Tab(
                      text: 'Reference',
                    ),
                    Tab(
                      text: 'Security',
                    ),
                    Tab(
                      text: 'Special Reserve',
                    ),
                  ],
                ),
              ),
            ];
          },
          body: TabBarView(
            children: [
              AcquisitionSection(),
              CirculationSection(),
              InformationHelpDeskSection(),
              LendingSection(),
              QuickReferenceSection(),
              ReferenceSection(),
              SecuritySection(),
              SpecialReserveSection(),
            ],
          ),
        ),
      ),
    );
  }
}
