import 'package:flutter/material.dart';

class FragmentsExample extends StatelessWidget {
  const FragmentsExample();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              color: Colors.red,
              width: 200,
              height: 100,
            ),
            Container(
              color: Colors.blue,
              width: 200,
              height: 100,
            )
          ],
        ),
        Row(
          children: [
            Container(
              color: Colors.green,
              width: 200,
              height: 100,
            ),
            Container(
              color: Colors.yellow,
              width: 200,
              height: 100,
            )
          ],
        ),
        Image.asset(
          './assets/rem.jpg',
          width: 400,
          height: 200,
          fit: BoxFit.cover,
        )
      ],
    );
  }
}
