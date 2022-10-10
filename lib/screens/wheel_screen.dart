import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:mafia/screens/choice_screen.dart';
import 'package:mafia/theme.dart';

class WheelScreen extends StatefulWidget {
  const WheelScreen(
      {super.key,
      required this.names,
      required this.truthList,
      required this.dareList});
  final List<String> names;
  final List<String> truthList;
  final List<String> dareList;

  @override
  State<WheelScreen> createState() => _WheelScreenState();
}

class _WheelScreenState extends State<WheelScreen> {
  int randomPlayerIndex = 0;
  StreamController<int> selected = StreamController<int>();
  StreamController<int> selectedSmall = StreamController<int>();
  StreamController<int> selected2 = StreamController<int>();

  List<FortuneItem> fortuneItems = [];

  @override
  void initState() {
    super.initState();
    randomPlayerIndex = Random().nextInt(widget.names.length);
    for (var element in widget.names) {
      fortuneItems.add(
        FortuneItem(
            style: FortuneItemStyle(
                borderColor: Colors.white,
                borderWidth: 5,
                color: Colors
                    .primaries[Random().nextInt(Colors.primaries.length)]),
            child: Text(element, style: CustomTheme.titleMedium)),
      );
    }
    // selected.add(1);
  }

  @override
  void dispose() {
    selected.close();
    selectedSmall.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // List<FortuneItem> z = List<FortuneItem>.from(widget.names);
    // Color mainColor = Colors.amber;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(
          'Who\'s Next?',
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: FortuneWheel(
                  indicators: const [
                    FortuneIndicator(
                        alignment: Alignment.topCenter,
                        child: Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.white,
                          size: 70,
                        ))
                  ],
                  // alignment: Alignment.bottomCenter,
                  animateFirst: false,
                  physics: CircularPanPhysics(
                    duration: const Duration(seconds: 1),
                    curve: Curves.decelerate,
                  ),
                  onFling: () {
                    setState(() {
                      randomPlayerIndex =
                          Fortune.randomInt(0, widget.names.length);
                      print(randomPlayerIndex);
                      print(Random().nextInt(widget.names.length));
                      int randomPlayerIndexFixed =
                          randomPlayerIndexFixer(randomPlayerIndex);
                      print(randomPlayerIndexFixed);

                      // randomPlayerIndex < 0 ? randomPlayerIndex - 1 : 0;
                      selected.add(randomPlayerIndexFixed);
                      selectedSmall.add(randomPlayerIndexFixed);
                    });
                  },
                  selected: selected.stream,
                  items: fortuneItems,
                  onAnimationEnd: () {
                    String chosenOne =
                        widget.names[randomPlayerIndexFixer(randomPlayerIndex)];

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => ChoiceScreen(
                                chosenOne: chosenOne,
                                truthList: widget.truthList,
                                dareList: widget.dareList))));
                  }),
            ),
            Expanded(
              flex: 1,
              child: Stack(
                children: [
                  Center(
                    child: SizedBox(
                      width: 70,
                      height: 70,
                      child: IgnorePointer(
                        child: FortuneWheel(
                          indicators: const [],

                          animateFirst: false,

                          selected: selectedSmall.stream,
                          items: const [
                            FortuneItem(
                                style: FortuneItemStyle(
                                    color: Colors.redAccent,
                                    borderColor: Colors.white,
                                    borderWidth: 3),
                                child: SizedBox()),
                            FortuneItem(
                                style: FortuneItemStyle(
                                    color: Colors.greenAccent,
                                    borderColor: Colors.white,
                                    borderWidth: 3),
                                child: SizedBox()),
                            FortuneItem(
                                style: FortuneItemStyle(
                                    color: Colors.blueAccent,
                                    borderColor: Colors.white,
                                    borderWidth: 3),
                                child: SizedBox())
                          ],
                          // onAnimationEnd: () => print(widget.names[randomPlayerIndex]),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: GestureDetector(
                        child: const Icon(
                          Icons.play_arrow,
                          size: 50,
                          color: Color(0xFF263238),
                        ),
                        onTap: () {
                          setState(() {
                            randomPlayerIndex =
                                Fortune.randomInt(0, widget.names.length);
                          });
                          selected.add(randomPlayerIndex > 0
                              ? randomPlayerIndex - 1
                              : 0);
                          selectedSmall.add(randomPlayerIndex > 0
                              ? randomPlayerIndex - 1
                              : 0);
                        }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  randomPlayerIndexFixer(int randomPlayerIndex) {
    // print("z $randomPlayerIndex");
    int randomPlayerIndexFixed = randomPlayerIndex == 0 ? 0 : randomPlayerIndex;
    return randomPlayerIndexFixed;
  }
}


//  CupertinoButton(
//                 child: Text(" s"),
//                 onPressed: () {
//                   setState(() {
//                     selected2.add(Random().nextInt(widget.names.length - 1));
//                   });
//                 }),
//             myFortuneWheel(widget.names, selected2, () {
//               setState(() {
//                 selected2.add(0);
//               });
//             }),
// myFortuneWheel(
//     List<String> namesList, StreamController<int> selected, Function onFling) {
//   List<Color> colors = [
//     Colors.red,
//     Colors.green,
//     Colors.blue,
//     Colors.yellow,
//     Colors.pink,
//     Colors.purple,
//     Colors.amberAccent,
//     Colors.blue,
//     Colors.brown,
//     Colors.orange
//   ];
//   return SizedBox(
//     width: 500,
//     height: 500,
//     child: FortuneWheel(
//         onFling: () => onFling(),
//         animateFirst: false,
//         selected: selected.stream,
//         items: <FortuneItem>[
//           for (int i = 0; i < namesList.length; i++)
//             FortuneItem(
//                 style: FortuneItemStyle(
//                     borderColor: Colors.white,
//                     borderWidth: 5,
//                     color: i < 10 ? colors[i] : colors[i ~/ 10]
//                     // .primaries[Random().nextInt(Colors.primaries.length)]
//                     ),
//                 child: Text(namesList[i]))
//         ]),
//   );
// }
