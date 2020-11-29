import 'package:any_tab/any_tab.dart';
import 'package:example/delegate/index.dart';
import 'package:example/model/index.dart';
import 'package:example/widget/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fragments/flutter_fragments.dart';

class FragmentsAnyTabPage extends StatefulWidget {
  static const String rName = 'FragmentsClipperTab';

  @override
  _FragmentsAnyTabPageState createState() =>
      _FragmentsAnyTabPageState();
}

class _FragmentsAnyTabPageState extends State<FragmentsAnyTabPage>
    with SingleTickerProviderStateMixin {
  AnyTabController anyTabController;
  ScreenshotController screenShotController = ScreenshotController();

  @override
  void initState() {
    super.initState();
    anyTabController = AnyTabController(vsync: this, length: 3);
    anyTabController.addStatusListener((status) {
      if (status == SlideStatus.dragStart) {
        screenShotController.generateImage(null);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnyTab(
        anyTabController: anyTabController,
        anyTabDelegate: FragmentsAnyTabDelegate(
          screenshotController: screenShotController,
          tabs: [
            for (AnyTabModel model in pages)
              AnyTabItem(
                model: model,
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    screenShotController.dispose();
    super.dispose();
  }
}

final List<AnyTabModel> pages = [
  AnyTabModel(
      color: Color(0xFFcd344f),
      image: './assets/rem.jpg',
      title: 'This is first page!'),
  AnyTabModel(
      color: Color(0xFF638de3),
      image: './assets/rem02.jpg',
      title: 'This is second page!'),
  AnyTabModel(
      color: Color(0xFFFF682D),
      image: './assets/eat_sydney_sm.jpg',
      title: 'This is third page!'),
];