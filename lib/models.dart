enum CardType { dare, truth, undefined }

class QuestionCard {
  QuestionCard({this.question, this.type});

  final CardType? type;

  final String? question;

  factory QuestionCard.truth({String? truthMessage}) {
    return QuestionCard(question: truthMessage, type: CardType.truth);
  }
  factory QuestionCard.dare({String? dareMessage}) {
    return QuestionCard(question: dareMessage, type: CardType.dare);
  }
}
