import 'package:example/model/index.dart';
import 'package:flutter/material.dart';

class AnyTabItem extends StatelessWidget {
  final AnyTabModel model;
  final double percentage;

  AnyTabItem({this.model, percentage, Key key})
      : this.percentage = percentage ?? 1,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: model.color,
      height: double.infinity,
      child: Opacity(
        opacity: percentage,
        child: Container(
          alignment: Alignment.center,
          transform: Matrix4.translationValues(0, 20 * (1 - percentage), 0.0),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    model.image,
                  ))),
          child: Text(model.title),
        ),
      ),
    );
  }
}
