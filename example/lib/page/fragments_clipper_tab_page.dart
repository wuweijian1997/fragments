import 'package:example/model/index.dart';
import 'package:flutter/material.dart';

final _pages = [
  ClipTabModel(
      color: Color(0xFFcd344f),
      image: './assets/rem.jpg',
      title: 'This is red page!'),
  ClipTabModel(
      color: Color(0xFF638de3),
      image: './assets/rem02.jpg',
      title: 'This is blue page!'),
  ClipTabModel(
      color: Color(0xFFFF682D),
      image: './assets/rem.jpg',
      title: 'This is orange page!'),
];

class FragmentsClipTabPage extends StatefulWidget {
  static const String rName = "FragmentsClipTab";

  @override
  _FragmentsClipTabPageState createState() => _FragmentsClipTabPageState();
}

class _FragmentsClipTabPageState extends State<FragmentsClipTabPage>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
