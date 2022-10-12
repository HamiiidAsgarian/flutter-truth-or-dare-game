import 'package:flutter/material.dart';
import 'package:truthordare/widgets/widgets.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen(
      {super.key,
      required this.defultNames,
      required this.onListChange,
      required this.title});
  final List<String> defultNames;
  final Function onListChange;
  final String title;

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  late List<String> names = [];

  @override
  void initState() {
    names = widget.defultNames;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color mainColor = Colors.amber;
    return Scaffold(
      backgroundColor: mainColor,
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        elevation: 0,
        backgroundColor: mainColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        child: Column(
          children: [
            AddNameSection(onAdd: (newName) {
              if (!names.contains(newName)) {
                setState(() {
                  names.add(newName);
                });
                widget.onListChange(names);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    backgroundColor: Colors.orangeAccent,
                    content: Text("This name already exists")));
              }
            }),
            const SizedBox(height: 15),
            NamesListSection(
                // key: Key("a"),
                names: names,
                onDelete: (itemName) {
                  setState(() {
                    names.removeAt(itemName);
                  });
                  widget.onListChange(names);
                }),
          ],
        ),
      ),
    );
  }
}

class NamesListSection extends StatefulWidget {
  const NamesListSection(
      {Key? key, required this.names, required this.onDelete})
      : super(key: key);

  final Function onDelete;
  final List<String> names;

  @override
  State<NamesListSection> createState() => _NamesListSectionState();
}

class _NamesListSectionState extends State<NamesListSection> {
  // late final List<dynamic> _localNames = widget.names;

  int cardsList = 0;

  @override
  void initState() {
    // print(" list init");
    listMaker();
    super.initState();
  }

  @override
  void didUpdateWidget(e) {
    // print(" update init");
    super.didUpdateWidget(e);
    while (cardsList < widget.names.length) {
      cardsList++;
    }
  }

  listMaker() async {
    // cardsList.clear();
    while (cardsList < widget.names.length) {
      await Future.delayed(const Duration(milliseconds: 200)).then((value) {
        setState(() {
          // print("${widget.names}sss");
          cardsList++;
        });
      });
    }
    return cardsList;
  }

  @override
  Widget build(BuildContext context) {
    // listMaker();
    return Expanded(
        child: ListView.builder(
            itemCount: cardsList,
            itemBuilder: (context, i) {
              return Dismissible(
                  key: ValueKey(widget.names[i] + i.toString()),
                  onDismissed: (direction) {
                    widget.onDelete(i);

                    setState(() {
                      cardsList--;
                      // widget.names.removeAt(i);
                    });
                  },
                  child: CustomAnimatedCard(
                      text: widget.names[i],
                      onClose: () {
                        widget.onDelete(i);
                        setState(() {
                          cardsList--;
                        });
                      }));
            }));
  }
}

class AddNameSection extends StatelessWidget {
  const AddNameSection({Key? key, required this.onAdd}) : super(key: key);
  final Function onAdd;
  @override
  Widget build(BuildContext context) {
    TextEditingController newNameController = TextEditingController();
    return SizedBox(
      height: 50,
      width: double.infinity,
      // color: Colors.amber,
      child: Row(
        children: [
          Expanded(
              child: TextField(
            controller: newNameController,
            decoration: const InputDecoration(
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(),
              labelText: 'Question',
            ),
          )),
          const SizedBox(
            width: 15,
          ),
          SizedBox(
              width: 50,
              height: double.infinity,
              child: CustomIconButton(
                  icon: const Icon(Icons.add),
                  onTap: () {
                    if (newNameController.text.isNotEmpty) {
                      onAdd(newNameController.text);
                    }
                  }))
        ],
      ),
    );
  }
}

class NextSection extends StatelessWidget {
  const NextSection({
    required this.onNext,
    Key? key,
  }) : super(key: key);
  final Function onNext;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 5),
      // color: Colors.red,
      child: Align(
        alignment: Alignment.centerRight,
        child: CustomIconButton(
          onTap: () {
            onNext();
          },
          icon: const Icon(Icons.arrow_forward_ios),
        ),
      ),
    );
  }
}
