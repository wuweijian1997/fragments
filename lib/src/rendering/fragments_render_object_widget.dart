import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_fragments/src/fragments_draw/index.dart';

class FragmentsRenderObjectWidget extends RepaintBoundary {
  final ui.Image? image;
  final double progress;
  final Offset startingOffset;
  final FragmentsDrawDelegate delegate;

  FragmentsRenderObjectWidget({
    Key? key,
    required Widget child,
    this.image,
    required this.progress,
    required this.startingOffset,
    required this.delegate,
  }) : super(key: key, child: child);

  @override
  RenderRepaintBoundary createRenderObject(BuildContext context) {
    return _FragmentsRenderObject(
      image: image,
      delegate: delegate,
      startingOffset: startingOffset,
    );
  }

  @override
  void updateRenderObject(
      BuildContext context, _FragmentsRenderObject renderObject) {
    renderObject
      ..image = image
      ..delegate = delegate
      ..progress = progress
      ..startingOffset = startingOffset;
  }
}

class _FragmentsRenderObject extends RenderRepaintBoundary {
  ui.Image? _image;
  double _progress = 0;
  Offset _startingOffset;
  FragmentsDrawDelegate _delegate;

  _FragmentsRenderObject({
    ui.Image? image,
    RenderBox? child,
    required Offset startingOffset,
    required FragmentsDrawDelegate delegate,
  })  : _image = image,
        _delegate = delegate,
        _startingOffset = startingOffset,
        super(child: child);

  @override
  void paint(PaintingContext context, Offset offset) {
    if (_image != null &&
        _progress != 0 &&
        _progress != 1 &&
        _image != null) {
      _delegate.draw(
        canvas: context.canvas,
        paintImage: _image!,
        progress: _progress,
        startingOffset: _startingOffset,
      );
    } else {
      if (child != null) {
        context.paintChild(child!, offset);
      }
    }
  }

  set progress(double value) {
    if (value == _progress) return;
    _progress = value;
    markNeedsPaint();
  }

  set image(ui.Image? value) {
    if (value == _image) return;
    _image = value;
    markNeedsPaint();
  }

  set startingOffset(Offset value) {
    if (value == _startingOffset) return;
    _startingOffset = value;
    markNeedsPaint();
  }

  set delegate(FragmentsDrawDelegate value) {
    if (value == _delegate) return;
    _delegate = value;
    markNeedsPaint();
  }
}
