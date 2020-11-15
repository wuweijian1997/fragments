import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_fragments/flutter_fragments.dart';
import 'package:flutter_fragments/src/fragments_draw/index.dart';
import 'package:flutter_fragments/src/rendering/index.dart';

class Fragments extends StatefulWidget {
  final Widget child;

  /// Horizontal quantity
  final int rowLength;

  /// Vertical quantity
  final int columnLength;

  final FragmentsController fragmentsController;

  ///Starting point.range[(0, 0), (child.width, child.height)]
  final Offset startingPoint;
  final Duration duration;
  final FragmentsDrawDelegate delegate;

  Fragments({
    Key key,
    this.child,
    this.rowLength,
    this.columnLength,
    this.duration = const Duration(milliseconds: 1000),
    this.startingPoint = Offset.zero,
    @required this.fragmentsController,
    this.delegate = const TransitionFragmentsDraw(),
  })  : assert(rowLength > 0),
        assert(columnLength > 0),
        super(key: key);

  @override
  _FragmentsState createState() => _FragmentsState();
}

class _FragmentsState extends State<Fragments>
    with SingleTickerProviderStateMixin {
  FragmentsController _fragmentsController;

  int get rowLength => widget.rowLength;

  int get columnLength => widget.columnLength;

  Offset get startingPoint => widget.startingPoint;

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
            rowLength: rowLength,
            columnLength: columnLength,
            startingPoint: startingPoint,
            image: _fragmentsController.image,
            progress: _fragmentsController.value,
            imageSize: _fragmentsController.imageSize,
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
