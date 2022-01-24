import 'package:flutter/material.dart';
import 'package:flutter_fragments/flutter_fragments.dart';
import 'package:flutter_fragments/src/rendering/index.dart';

class Fragments extends StatefulWidget {
  final Widget child;

  final ScreenshotController screenshotController;
  final FragmentsDrawDelegate delegate;
  final Animation<double> animation;

  ///Starting point.range[(0, 0), (child.width, child.height)]
  final Offset startingOffset;

  Fragments({
    Key? key,
    required this.child,
    required this.animation,
    FragmentsDrawDelegate? delegate,
    this.startingOffset = Offset.zero,
    required this.screenshotController,
  })  : this.delegate = delegate ?? RadialFragmentsDraw(),
        super(key: key);

  @override
  _FragmentsState createState() => _FragmentsState();
}

class _FragmentsState extends State<Fragments>
    with SingleTickerProviderStateMixin {
  ScreenshotController get screenshotController => widget.screenshotController;

  Offset get startingOffset => widget.startingOffset;

  FragmentsDrawDelegate get delegate => widget.delegate;

  Animation<double> get animation => widget.animation;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          return FragmentsRenderObjectWidget(
            key: screenshotController.globalKey,
            delegate: delegate,
            child: widget.child,
            startingOffset: startingOffset,
            image: screenshotController.image,
            progress: animation.value,
          );
        },
      ),
    );
  }
}
