import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mafia/screens/players_screen.dart';
import 'package:mafia/screens/questions_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  List<String> names = ['no name'];
  List<String> truths = [
    'Who is Your Arch enemy?',
    'What is your ugliest bodypart?',
    'Which friend do you hate the most?',
    'What is your dumbest question that you have ever asked teacher?'
  ];
  List<String> dares = [
    'Drink Pot water',
    'Call 991 and screem your name',
    'Eat raw fish',
    'Bully the scools bully'
  ];

  @override
  void initState() {
    getLocalNames();
    getLocalDares();
    getLocalTruths();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      // appBar: AppBar(
      //     elevation: 0,
      //     backgroundColor: Theme.of(context).colorScheme.background,
      //     title: Text(
      //       "Truth or Dare",
      //       style: TextStyle(
      //           fontWeight: FontWeight.bold,
      //           fontSize: 50,
      //           color: Theme.of(context).colorScheme.outline),
      //     ),
      //     centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 50),
        child: Column(children: [
          Text(
            "Truth or Dare",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MainButton(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => PlayersScreen(
                                    truthList: truths,
                                    dareList: dares,
                                    onListChange:
                                        (List<String> newNames) async {
                                      setState(() {
                                        names = newNames;
                                      });
                                      setLocalNames();
                                    },
                                    defultNames: names,
                                  ))));
                    },
                    text: "Start",
                    textStyle: Theme.of(context).textTheme.titleMedium!,
                    color: Theme.of(context).colorScheme.outline,
                    icon: Icons.start),
                MainButton(
                    textStyle: Theme.of(context).textTheme.titleMedium!,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => QuestionsScreen(
                                  title: 'Truths',
                                  defultNames: truths,
                                  onListChange: (List<String> newList) {
                                    setState(() {
                                      truths = newList;
                                    });
                                    setLocalTruths();
                                  }))));
                    },
                    text: "Make Truth",
                    color: Theme.of(context).colorScheme.secondary,
                    icon: Icons.add),
                MainButton(
                    textStyle: Theme.of(context).textTheme.titleMedium!,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => QuestionsScreen(
                                  title: "Dares",
                                  defultNames: dares,
                                  onListChange: (List<String> newList) {
                                    setState(() {
                                      dares = newList;
                                    });
                                    setLocalDares();
                                  }))));
                    },
                    text: "Make dare",
                    color: Theme.of(context).colorScheme.secondary,
                    icon: Icons.add),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomIconButton(
                icon: const Icon(Icons.settings),
                onTap: () {},
              ),
              CustomIconButton(
                icon: const Icon(Icons.share),
                onTap: () {},
              ),
            ],
          )
        ]),
      ),
    );
  }

  getLocalNames() async {
    final prefs = await _prefs;
    // setState(() {
    names = prefs.getStringList("names") ?? [];
    // });
    log("get Local Names success => $names");
  }

  setLocalNames() async {
    final prefs = await _prefs;

    await prefs.setStringList("names", names).then((value) {
      log("set Local Names success = > $names");
      return names;
    });
  }

  getLocalTruths() async {
    final prefs = await _prefs;
    // setState(() {
    truths = prefs.getStringList("truths") ?? [];
    // });
    log("get Local truths success => $truths");
  }

  setLocalTruths() async {
    final prefs = await _prefs;

    await prefs.setStringList("truths", truths).then((value) {
      log("set Local truths success = > $truths");
      return truths;
    });
  }

  getLocalDares() async {
    final prefs = await _prefs;

    dares = prefs.getStringList("dares") ?? [];

    log("get Local dares success => $dares");
  }

  setLocalDares() async {
    final prefs = await _prefs;

    await prefs.setStringList("dares", dares).then((value) {
      log("set Local dares success = > $dares");
      return dares;
    });
  }
}
