import 'package:example/widget/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fragments/flutter_fragments.dart';

class FragmentsDemo extends StatefulWidget {
  static final String title = "Fragments";
  final FragmentsDrawDelegate delegate;

  FragmentsDemo({@required this.delegate});

  @override
  _FragmentsDemoState createState() => _FragmentsDemoState();
}

class _FragmentsDemoState extends State<FragmentsDemo> with SingleTickerProviderStateMixin {
  FragmentsController controller;
  Offset startingOffset = Offset.zero;
  FragmentsDrawDelegate get delegate => widget.delegate;
  AnimationController animationController;
  @override
  void initState() {
    super.initState();
    controller = FragmentsController(delegate: widget.delegate);
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
          child: Container(
            width: 300,
            height: 300,
            child: Stack(
              children: [
                Container(width: 300, height: 300, color: Colors.black,),
                Fragments(
                  fragmentsController: controller,
                  startingOffset: startingOffset,
                  child: const FragmentsExample(),
                  duration: Duration(milliseconds: 3000),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
