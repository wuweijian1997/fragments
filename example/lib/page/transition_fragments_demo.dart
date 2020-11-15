import 'package:example/widget/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fragments/flutter_fragments.dart';

class TransitionFragmentsDemo extends StatefulWidget {
  static final String title = "TransitionFragments";

  @override
  _TransitionFragmentsDemoState createState() => _TransitionFragmentsDemoState();
}

class _TransitionFragmentsDemoState extends State<TransitionFragmentsDemo> {
  FragmentsController controller = FragmentsController();
  Offset startingOffset = Offset.zero;

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
          child: Container(
            width: 400,
            height: 400,
            child: Fragments(
              fragmentsController: controller,
              startingOffset: startingOffset,
              duration: Duration(milliseconds: 5000),
              child: const FragmentsExample(),
            ),
          ),
        ),
      ),
    );
  }
}
