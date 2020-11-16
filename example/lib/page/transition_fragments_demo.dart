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
            child: const FragmentsExample(),
          ),
        ),
      ),
    );
  }
}
