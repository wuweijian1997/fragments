import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_fragments/flutter_fragments.dart';
import 'package:flutter_fragments/src/fragments_draw/index.dart';
import 'package:flutter_fragments/src/rendering/index.dart';

class Fragments extends StatefulWidget {
  final Widget child;

  final FragmentsController fragmentsController;

  ///Starting point.range[(0, 0), (child.width, child.height)]
  final Offset startingOffset;
  final Duration duration;
  final FragmentsDrawDelegate delegate;

  Fragments({
    Key key,
    this.child,
    this.duration = const Duration(milliseconds: 1000),
    this.startingOffset = Offset.zero,
    @required this.fragmentsController,
    delegate,
  })  : this.delegate = delegate ?? DefaultFragmentsDraw(),
        super(key: key);

  @override
  _FragmentsState createState() => _FragmentsState();
}

class _FragmentsState extends State<Fragments>
    with SingleTickerProviderStateMixin {
  FragmentsController _fragmentsController;

  Offset get startingOffset => widget.startingOffset;

  Duration get duration => widget.duration;

  FragmentsDrawDelegate get delegate => widget.delegate;

  @override
  void initState() {
    super.initState();
    _fragmentsController = widget.fragmentsController;
    assert(_fragmentsController != null);
    _fragmentsController.animationController = AnimationController(
      vsync: this,
      duration: duration,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _fragmentsController.animationController,
        builder: (context, child) {
          return FragmentsRenderObjectWidget(
            key: _fragmentsController.globalKey,
            delegate: delegate,
            child: widget.child,
            startingOffset: startingOffset,
            image: _fragmentsController.image,
            progress: _fragmentsController.value,
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _fragmentsController.dispose();
    super.dispose();
  }
}