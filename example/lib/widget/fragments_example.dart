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
              width: 150,
              height: 75,
              child: Icon(Icons.favorite),
            ),
            Container(
              color: Colors.blue,
              width: 150,
              height: 75,
              child: Icon(Icons.pages),
            )
          ],
        ),
        Row(
          children: [
            Container(
              color: Colors.green,
              width: 150,
              height: 75,
              child: Icon(Icons.settings),
            ),
            Container(
              color: Colors.yellow,
              width: 150,
              height: 75,
              child: Icon(Icons.animation),
            )
          ],
        ),
        Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              './assets/rem.jpg',
              width: 300,
              height: 150,
              fit: BoxFit.cover,
            ),
            Text('Logic', style: TextStyle(fontSize: 40),),
          ],
        )
      ],
    );
  }
}
