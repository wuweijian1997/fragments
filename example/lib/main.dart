import 'package:flutter/material.dart';
import 'package:example/page/index.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final List<PageModel> list = [
    PageModel(title: FragmentsDemo.title, child: FragmentsDemo()),
    PageModel(title: TransitionFragmentsDemo.title, child: TransitionFragmentsDemo()),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        body: HomePage(
          list: list,
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final List<PageModel> list;

  HomePage({this.list});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: list.length,
        itemBuilder: (_, int index) {
          PageModel model = list[index];
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                return model.child;
              }));
            },
            child: Card(
              shadowColor: Colors.blue[200],
              elevation: 10,
              margin: EdgeInsets.only(top: 10),
              color: Colors.pink,
              child: Container(
                height: 100,
                alignment: Alignment.center,
                child: Text(
                  model?.title ?? "unKnow",
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class PageModel {
  final String title;
  final Widget child;

  PageModel({this.title, this.child});
}
