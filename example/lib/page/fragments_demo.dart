import 'package:example/widget/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fragments/flutter_fragments.dart';

class FragmentsDemo extends StatefulWidget {
  static final String title = "Fragments";

  @override
  _FragmentsDemoState createState() => _FragmentsDemoState();
}

class _FragmentsDemoState extends State<FragmentsDemo> {
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
          child: Fragments(
            fragmentsController: controller,
            startingOffset: startingOffset,
            delegate: DefaultFragmentsDraw(disableTransition: true),
            child: const FragmentsExample(),
          ),
        ),
      ),
    );
  }
}
