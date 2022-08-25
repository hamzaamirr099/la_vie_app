class Question {
  final String questionText;
  final List<Answer> answersList;

  Question(this.questionText, this.answersList);
}

class Answer {
  final String answerText;
  final bool isCorrect;
  int isClicked;

  Answer(this.answerText, this.isCorrect, this.isClicked);
}

List<Question> getQuestions() {
  List<Question> list = [];
  //ADD questions and answer here

  list.add(Question(
    "What is the user experience?",
    [
      Answer("The user experience is how the developer feels about a user.", false, 0),
      Answer("The user experience is how the user feels about interacting with or experiencing a product.", true, 0),
      Answer("The user experience is the attitude the UX designer has about a product.", true, 0),
    ],
  ));

  list.add(Question(
    "What is the user experience?",
    [
      Answer("The user experience is how the developer feels about a user.", false, 0),
      Answer("The user experience is how the user feels about interacting with or experiencing a product.", true, 0),
      Answer("The user experience is the attitude the UX designer has about a product.", true, 0),
    ],
  ));
  list.add(Question(
    "What is the user experience?",
    [
      Answer("The user experience is how the developer feels about a user.", false, 0),
      Answer("The user experience is how the user feels about interacting with or experiencing a product.", true, 0),
      Answer("The user experience is the attitude the UX designer has about a product.", true, 0),
    ],
  ));
  list.add(Question(
    "What is the user experience?",
    [
      Answer("The user experience is how the developer feels about a user.", false, 0),
      Answer("The user experience is how the user feels about interacting with or experiencing a product.", true, 0),
      Answer("The user experience is the attitude the UX designer has about a product.", true, 0),
    ],
  ));

  list.add(Question(
    "What is the user experience?",
    [
      Answer("The user experience is how the developer feels about a user.", false, 0),
      Answer("The user experience is how the user feels about interacting with or experiencing a product.", true, 0),
      Answer("The user experience is the attitude the UX designer has about a product.", true, 0),
    ],
  ));

  list.add(Question(
    "What is the user experience?",
    [
      Answer("The user experience is how the developer feels about a user.", false, 0),
      Answer("The user experience is how the user feels about interacting with or experiencing a product.", true, 0),
      Answer("The user experience is the attitude the UX designer has about a product.", true, 0),
    ],
  ));

  list.add(Question(
    "What is the user experience?",
    [
      Answer("The user experience is how the developer feels about a user.", false, 0),
      Answer("The user experience is how the user feels about interacting with or experiencing a product.", true, 0),
      Answer("The user experience is the attitude the UX designer has about a product.", true, 0),
    ],
  ));

  list.add(Question(
    "What is the user experience?",
    [
      Answer("The user experience is how the developer feels about a user.", false, 0),
      Answer("The user experience is how the user feels about interacting with or experiencing a product.", true, 0),
      Answer("The user experience is the attitude the UX designer has about a product.", true, 0),
    ],
  ));

  list.add(Question(
    "What is the user experience?",
    [
      Answer("The user experience is how the developer feels about a user.", false, 0),
      Answer("The user experience is how the user feels about interacting with or experiencing a product.", true, 0),
      Answer("The user experience is the attitude the UX designer has about a product.", true, 0),
    ],
  ));

  list.add(Question(
    "What is the user experience?",
    [
      Answer("The user experience is how the developer feels about a user.", false, 0),
      Answer("The user experience is how the user feels about interacting with or experiencing a product.", true, 0),
      Answer("The user experience is the attitude the UX designer has about a product.", true, 0),
    ],
  ));






  return list;
}
