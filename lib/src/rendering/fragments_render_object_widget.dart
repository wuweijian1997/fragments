import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_fragments/src/fragments_draw/index.dart';
import 'package:flutter_fragments/src/models/index.dart';

class FragmentsRenderObjectWidget extends RepaintBoundary {
  final ui.Image image;
  final Size imageSize;
  final double progress;
  final int rowLength;
  final int columnLength;
  final Offset startingPoint;
  final FragmentsDrawDelegate delegate;

  FragmentsRenderObjectWidget({
    Key key,
    Widget child,
    this.image,
    this.progress,
    this.imageSize,
    this.rowLength,
    this.columnLength,
    this.startingPoint,
    this.delegate,
  }) : super(key: key, child: child);

  @override
  RenderRepaintBoundary createRenderObject(BuildContext context) {
    return _FragmentsRenderObject(
      image: image,
      delegate: delegate,
      imageSize: imageSize,
      rowLength: rowLength,
      columnLength: columnLength,
      startingPoint: startingPoint,
    );
  }

  @override
  void updateRenderObject(
      BuildContext context, _FragmentsRenderObject renderObject) {
    renderObject
      ..image = image
      ..delegate = delegate
      ..progress = progress
      ..rowLength = rowLength
      ..imageSize = imageSize
      ..columnLength = columnLength
      ..startingPoint = startingPoint;
  }
}

class _FragmentsRenderObject extends RenderRepaintBoundary {
  ui.Image _image;
  Size _imageSize;
  double _progress;
  List<List<Rect>> fragments;
  int _rowLength;
  int _columnLength;
  Offset _startingPoint;
  Coordinate _startingCoordinate;
  FragmentsDrawDelegate _delegate;

  _FragmentsRenderObject({
    image,
    imageSize,
    RenderBox child,
    int rowLength,
    int columnLength,
    Offset startingPoint,
    FragmentsDrawDelegate delegate,
  })  : _image = image,
        _delegate = delegate,
        _imageSize = imageSize,
        _rowLength = rowLength,
        _columnLength = columnLength,
        _startingPoint = startingPoint,
        super(child: child);

  @override
  void paint(PaintingContext context, Offset offset) {
    assert(_delegate != null);
    if (_image != null &&
        _imageSize != null &&
        _progress != 0 &&
        _progress != 1 &&
        _progress != null) {
      if (fragments == null) {
        fragments = initFragments(
          size: _imageSize,
          rowLength: _rowLength,
          columnLength: _columnLength,
          startingPoint: _startingPoint,
        );
      }
      if (_startingCoordinate == null) {
        _startingCoordinate = initCoordinate(
          size: _imageSize,
          rowLength: _rowLength,
          columnLength: _columnLength,
          startingPoint: _startingPoint,
        );
      }
      _delegate.draw(
        canvas: context.canvas,
        fragments: fragments,
        paintImage: _image,
        columnLength: _columnLength,
        rowLength: _rowLength,
        progress: _progress,
        startingCoordinate: _startingCoordinate,
      );
    } else {
      if (child != null) {
        context.paintChild(child, offset);
      }
    }
  }

  Coordinate initCoordinate({
    Size size,
    int rowLength,
    int columnLength,
    Offset startingPoint = Offset.zero,
  }) {
    double fragmentsWidth = size.width / rowLength;
    int x = ((startingPoint.dx ~/ fragmentsWidth)).clamp(0, rowLength);
    double fragmentsHeight = size.height / columnLength;
    int y = ((startingPoint.dy ~/ fragmentsHeight)).clamp(0, columnLength);
    return Coordinate(x: x, y: y);
  }

  List<List<Rect>> initFragments({
    Size size,
    int rowLength,
    int columnLength,
    Offset startingPoint = Offset.zero,
  }) {
    assert(startingPoint != null);
    assert(rowLength != 0 && columnLength != 0);
    double fragmentsWidth = size.width / rowLength;
    double fragmentsHeight = size.height / columnLength;
    List<List<Rect>> list = List(rowLength);
    for (int i = 0; i < rowLength; i++) {
      for (int j = 0; j < columnLength; j++) {
        if (list[i] == null) {
          list[i] = List(columnLength);
        }
        list[i][j] = Rect.fromLTWH(fragmentsWidth * i, fragmentsHeight * j,
            fragmentsWidth, fragmentsHeight);
      }
    }
    return list;
  }

  set progress(double value) {
    if (value == _progress) return;
    _progress = value;
    markNeedsPaint();
  }

  set imageSize(Size value) {
    if (value == _imageSize) return;
    _imageSize = value;
    markNeedsPaint();
  }

  set image(ui.Image value) {
    if (value == _image) return;
    _image = value;
    markNeedsPaint();
  }

  set columnLength(int value) {
    if (value == _columnLength) return;
    _columnLength = value;
    markNeedsPaint();
  }

  set rowLength(int value) {
    if (value == _rowLength) return;
    _rowLength = value;
    markNeedsPaint();
  }

  set startingPoint(Offset value) {
    if (value == _startingPoint) return;
    _startingPoint = value;
    _startingCoordinate = null;
    markNeedsPaint();
  }

  set delegate(FragmentsDrawDelegate value) {
    if(value == _delegate) return;
    _delegate = value;
    markNeedsPaint();
  }
}
