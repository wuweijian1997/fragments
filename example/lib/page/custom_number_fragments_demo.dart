import 'package:example/widget/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fragments/flutter_fragments.dart';

class CustomNumberFragmentsDemo extends StatefulWidget {
  static final String title = "CustomNumberFragments";

  @override
  _CustomNumberFragmentsDemoState createState() => _CustomNumberFragmentsDemoState();
}

class _CustomNumberFragmentsDemoState extends State<CustomNumberFragmentsDemo> {
  FragmentsController controller = FragmentsController();
  Offset startingOffset = Offset.zero;


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTapUp: (TapUpDetails detail) {
            setState(() {
              startingOffset = detail.localPosition;
            });
            controller.start();
          },
          child: Fragments(
            fragmentsController: controller,
            startingOffset: startingOffset,
            duration: Duration(milliseconds: 3000),
            delegate: DefaultFragmentsDraw(rowLength: 50, columnLength: 50),
            child: const FragmentsExample(),
          ),
        ),
      ),
    );
  }
}
