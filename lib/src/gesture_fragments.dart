import 'package:flutter/material.dart';
import 'package:flutter_fragments/flutter_fragments.dart';

class GestureFragments extends StatefulWidget {
  final Widget child;
  final FragmentsDrawDelegate delegate;

  GestureFragments({
    required this.child,
    FragmentsDrawDelegate? delegate,
  }) : this.delegate = delegate ?? RadialFragmentsDraw();

  @override
  _GestureFragmentsState createState() => _GestureFragmentsState();
}

class _GestureFragmentsState extends State<GestureFragments>
    with SingleTickerProviderStateMixin {
  late FragmentsController fragmentsController;

  Offset startingOffset = Offset.zero;

  Widget get child => widget.child;
  FragmentsDrawDelegate get delegate => widget.delegate;
  @override
  void initState() {
    super.initState();
    fragmentsController = FragmentsController(vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: (TapUpDetails detail) {
        setState(() {
          startingOffset = detail.localPosition;
        });
        fragmentsController.start();
      },
      child: Fragments(
        child: child,
        delegate: delegate,
        startingOffset: startingOffset,
        animation: fragmentsController.animation,
        screenshotController: fragmentsController.screenshotController,
      ),
    );
  }

  @override
  void dispose() {
    fragmentsController.dispose();
    super.dispose();
  }
}
