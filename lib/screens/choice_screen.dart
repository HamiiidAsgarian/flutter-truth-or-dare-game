// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:math' as math;
import 'dart:developer' as dev;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mafia/models.dart';

class ChoiceScreen extends StatefulWidget {
  const ChoiceScreen(
      {required this.chosenOne,
      super.key,
      required this.truthList,
      required this.dareList});
  final String chosenOne;
  final List<String> truthList;
  final List<String> dareList;

  @override
  State<ChoiceScreen> createState() => _ChoiceScreenState();
}

class _ChoiceScreenState extends State<ChoiceScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animCntrl;

  late Animation<double> animation;
  late QuestionCard chosenCard = QuestionCard(type: CardType.undefined);
  @override
  void initState() {
    dev.log("Choices for ${widget.chosenOne}");
    _animCntrl = AnimationController(
        value: 2.5,
        reverseDuration: const Duration(milliseconds: 300),
        vsync: this,
        lowerBound: .9,
        upperBound: 2.5,
        duration: const Duration(milliseconds: 300));
    _animCntrl.reverse();

    _animCntrl.addListener((() => setState(() {
          // print(_animCntrl.value);
        })));

    super.initState();
  }

  void runAnimationForward() {
    setState(() {
      _animCntrl.forward();
    });
  }

  @override
  void dispose() {
    _animCntrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          title: Text('Truth Or Dare',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Colors.white)),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Theme.of(context).colorScheme.background,
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          // color: const Color.fromARGB(255, 178, 220, 255),
          child: Column(children: [
            Text(
              "It's your turn ${widget.chosenOne}!",
              style: TextStyle(color: Theme.of(context).colorScheme.outline),
            ),
            Text(
              "Select one of these cards",
              style: TextStyle(color: Theme.of(context).colorScheme.outline),
            ),
            Expanded(
                child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    // color: Colors.red,
                    height: MediaQuery.of(context).size.height / 1.5,
                    width: MediaQuery.of(context).size.width / 1.5,
                    child: Opacity(
                      opacity: ((_animCntrl.value - 0.9) / 1.6),
                      child: Stack(
                        // overflow: Overflow.visible,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        children: [
                          RotationTransition(
                              turns: AlwaysStoppedAnimation(
                                  ((_animCntrl.value - 0.9) / 1.6)),
                              child: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height / 1.5,
                                width: MediaQuery.of(context).size.width / 1.5,
                                child: OptionCard(
                                  onTap: () {
                                    // _animCntrl.reverse();
                                    Navigator.pop(context);
                                  },
                                  cardType: chosenCard,
                                  // cardQuestion: '',
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
                Align(
                    alignment: Alignment(
                        (_animCntrl.value - 0.04), (_animCntrl.value)),
                    child: OptionCard(
                      onTap: () {
                        runAnimationForward();
                        onTapQuestionCard(CardType.truth);
                      },
                      cardType: QuestionCard.truth(),
                      // cardQuestion: widget.truthList[
                      //     Random().nextInt(widget.truthList.length - 1)],
                    )),
                Align(
                    alignment: Alignment(
                        -(_animCntrl.value - 0.04), (_animCntrl.value)),
                    child: OptionCard(
                        // cardQuestion: widget.dareList[
                        //     Random().nextInt(widget.dareList.length - 1)],
                        onTap: () {
                          runAnimationForward();
                          onTapQuestionCard(CardType.dare);
                        },
                        cardType: QuestionCard.dare())),
                Align(
                    alignment: Alignment(
                        -(_animCntrl.value - 0.04), -(_animCntrl.value - 0.04)),
                    child: OptionCard(
                        // cardQuestion: widget.truthList[
                        //     Random().nextInt(widget.truthList.length - 1)],
                        onTap: () {
                          runAnimationForward();
                          onTapQuestionCard(CardType.truth);
                        },
                        cardType: QuestionCard.truth())),
                Align(
                    alignment: Alignment(
                        (_animCntrl.value - 0.04), -(_animCntrl.value - 0.04)),
                    child: OptionCard(
                        // cardQuestion: widget.dareList[
                        //     Random().nextInt(widget.dareList.length - 1)],
                        onTap: () {
                          runAnimationForward();
                          onTapQuestionCard(CardType.dare);
                        },
                        cardType: QuestionCard.dare())),
              ],
            ))
          ]),
        ));
  }

  onTapQuestionCard(CardType newCardTpe) {
    print(widget.truthList.toString() + widget.dareList.toString());
    String message = "Undefined";
    if (newCardTpe == CardType.truth && widget.truthList.isNotEmpty) {
      print("truth");
      message =
          widget.truthList[math.Random().nextInt(widget.truthList.length)];
    } else if (newCardTpe == CardType.dare && widget.dareList.isNotEmpty) {
      print("dare");

      message = widget.dareList[math.Random().nextInt(widget.dareList.length)];
    }

    setState(() {
      chosenCard = QuestionCard(type: newCardTpe, question: message);
    });
  }
}

class OptionCard extends StatelessWidget {
  const OptionCard({
    required this.onTap,
    super.key,
    required this.cardType,
  });
  final Function onTap;
  final QuestionCard cardType;
  // final String cardQuestion;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                width: 5, color: Theme.of(context).colorScheme.outline)),
        height: MediaQuery.of(context).size.height / 2.6,
        width: MediaQuery.of(context).size.width / 2.6,
        child: Stack(children: [
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: cardType.question != null
                  ? MainAxisAlignment.spaceAround
                  : MainAxisAlignment.center,
              children: [
                FittedBox(
                  child: Icon(
                    cardType.type == CardType.truth
                        ? Icons.question_mark
                        : Icons.warning,
                    size: 100,
                    color: Theme.of(context).colorScheme.outline,
                  ),
                ),
                Text(
                  cardType.question ?? "",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.outline,
                      fontSize: 25),
                )
              ],
            ),
          ),
          Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                describeEnum(cardType.type!),
                style: TextStyle(
                    color: Theme.of(context).colorScheme.outline, fontSize: 25),
              ))
        ]),
      ),
    );
  }
}

// class CardType {
//   final String question;

//   CardType.truth(this.question) {}

//   // enum{}
// }

// abstract class Card {
//   final String question;
//   final CardType type;
//   Card({required this.question, required this.type});
// }

