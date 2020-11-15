import 'package:flutter/material.dart';
import 'package:flutter_fragments/flutter_fragments.dart';

class FragmentsDemo extends StatefulWidget {
  static final String title = "Fragments";

  @override
  _FragmentsDemoState createState() => _FragmentsDemoState();
}

class _FragmentsDemoState extends State<FragmentsDemo> {
  FragmentsController controller = FragmentsController();
  Offset startingPoint = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTapUp: (TapUpDetails detail) {
            setState(() {
              startingPoint = detail.localPosition;
            });
            controller.start();
          },
          child: Container(
            width: 400,
            height: 400,
            child: Fragments(
              rowLength: 10,
              columnLength: 10,
              fragmentsController: controller,
              startingPoint: startingPoint,
              delegate: const CustomFragmentsDraw(),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        color: Colors.red,
                        width: 200,
                        height: 100,
                      ),
                      Container(
                        color: Colors.blue,
                        width: 200,
                        height: 100,
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        color: Colors.green,
                        width: 200,
                        height: 100,
                      ),
                      Container(
                        color: Colors.yellow,
                        width: 200,
                        height: 100,
                      )
                    ],
                  ),
                  Image.asset(
                    './assets/rem.jpg',
                    width: 400,
                    height: 200,
                    fit: BoxFit.cover,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => controller.start(),
      ),
    );
  }
}
