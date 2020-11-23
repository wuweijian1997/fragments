# flutter_fragments
flutter fragment effect

## Getting Started
Add this to your package's pubspec.yaml file:
```
dependencies:
  flutter_fragments: ^0.03
```
## example
### Default effect

```
class FragmentsDemo extends StatefulWidget {
  static final String title = "Fragments";

  @override
  _FragmentsDemoState createState() => _FragmentsDemoState();
}

class _FragmentsDemoState extends State<FragmentsDemo> {
  FragmentsController controller = FragmentsController();
  Offset startingOffset = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTapUp: (TapUpDetails detail) {
            setState(() {
              startingOffset = detail.localPosition;
            });
            controller.start();
          },
          child: Container(
            width: 300,
            height: 300,
            child: Fragments(
              fragmentsController: controller,
              startingOffset: startingOffset,
              delegate: DefaultFragmentsDraw(disableTransition: true),
              child: const FragmentsExample(),
            ),
          ),
        ),
      ),
    );
  }
}
```
![demo1.gif](https://github.com/wuweijian1997/fragments/blob/main/example/demo1.gif)
### Transition effects.
```
Fragments(
  fragmentsController: controller,
  startingOffset: startingOffset,
  duration: Duration(milliseconds: 3000),
  child: const FragmentsExample(),
),
```
![demo2.gif](https://github.com/wuweijian1997/fragments/blob/main/example/demo2.gif)

### Number of custom fragment
```
Fragments(
  fragmentsController: controller,
  startingOffset: startingOffset,
  duration: Duration(milliseconds: 3000),
  delegate: DefaultFragmentsDraw(rowLength: 25, columnLength: 25),
  child: const FragmentsExample(),
),
```

