import 'package:example/widget/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fragments/flutter_fragments.dart';

class FragmentsDemo extends StatefulWidget {
  static final String title = "Fragments";
  final FragmentsDrawDelegate delegate;

  FragmentsDemo({required this.delegate});

  @override
  _FragmentsDemoState createState() => _FragmentsDemoState();
}

class _FragmentsDemoState extends State<FragmentsDemo> {
  Offset startingOffset = Offset.zero;
  FragmentsDrawDelegate get delegate => widget.delegate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 300,
          height: 300,
          child: Stack(
            children: [
              // Container(width: 300, height: 300, color: Colors.black,),
              GestureFragments(
                delegate: delegate,
                child: const FragmentsExample(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
