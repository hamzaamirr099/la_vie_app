import 'package:flutter/material.dart';
import 'package:la_vie/core/shared/components.dart';
import 'package:la_vie/core/widgets/default_button.dart';
import '../../../../models/exam_model.dart';

class ExamScreen extends StatefulWidget {
  @override
  State<ExamScreen> createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> {
  //define the data
  List<Question> questionList = getQuestions();
  int currentQuestionIndex = 0;
  int score = 0;
  Answer? selectedAnswer;

  int flag = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          const Text(
            "Course Exam",
            style: TextStyle(
                color: Colors.black, fontSize: 19, fontWeight: FontWeight.bold),
          ),
          questionWidget(),
          answerList(),
          Row(
            children: [
              Expanded(
                child: previousButton(),
              ),
              SizedBox(
                width: 20.0,
              ),
              Expanded(
                child: nextButton(),
              ),
            ],
          ),
        ]),
      ),
    );
  }

  questionWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          // color: Colors.red,
          child: Row(
            children: [
              const Text(
                "Question",
                style: TextStyle(fontSize: 36.0, fontWeight: FontWeight.w500),
              ),
              Text(
                "${currentQuestionIndex + 1}",
                style: const TextStyle(color: Colors.green, fontSize: 36.0),
              ),
              Text(
                "/${questionList.length.toString()}",
                style: const TextStyle(fontSize: 20.0, color: Colors.grey),
              ),
            ],
          ),
        ),
        const SizedBox(height: 30),
        Text(
          questionList[currentQuestionIndex].questionText,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  answerList() {
    return Column(
      children: questionList[currentQuestionIndex]
          .answersList
          .map(
            (e) => answerButton(e),
          )
          .toList(),
    );
  }

  Widget answerButton(Answer answer) {
    // bool isSelected = answer == selectedAnswer;

    // print(answer.isClicked);
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8),
      height: 60,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.green, width: 2.0),
        borderRadius: BorderRadius.circular(10.0),
      ),

      child: InkWell(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  answer.answerText,
                  style: const TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 15.0),
                ),
              ),
              // const Spacer(),
              answer.isClicked == 1
                  ? Icon(
                      Icons.radio_button_checked_outlined,
                      color: Colors.green,
                      size: 30.0,
                    )
                  : Icon(
                      Icons.radio_button_unchecked_outlined,
                      color: Colors.green,
                      size: 30.0,
                    )
            ],
          ),
        ),
        onTap: () {
          setState(() {
            if (answer.isClicked == 0) {
              if (flag == 0) {
                answer.isClicked = 1;
                flag = 1;
                if (answer.isCorrect) {
                  score++;
                } else {
                  if (score <= 0) {
                    score = 0;
                  } else {
                    score--;
                  }
                }
              } else {
                showToastMessage(message: "Uncheck the selection first");
              }
            } else {
              answer.isClicked = 0;
              flag = 0;
            }
          });
        },
      ),
      // child: ElevatedButton(
      //   child: Text(answer.answerText),
      //
      //   onPressed: () {
      //     if (selectedAnswer == null) {
      //       if (answer.isCorrect) {
      //         score++;
      //       }
      //       setState(() {
      //         selectedAnswer = answer;
      //       });
      //     }
      //   },
      // ),
    );
  }

  nextButton() {
    bool isLastQuestion = false;
    if (currentQuestionIndex == questionList.length - 1) {
      isLastQuestion = true;
    }

    return DefaultButton(
      childWidget: Text(
        isLastQuestion ? "Submit" : "Next",
        style: TextStyle(color: Colors.white),
      ),
      borderRadius: 10.0,
      // style: ElevatedButton.styleFrom(
      //   shape: const StadiumBorder(),
      //   primary: Colors.blueAccent,
      //   onPrimary: Colors.white,
      // ),
      onPressed: () {
        if (isLastQuestion) {
          //display score

          showDialog(context: context, builder: (_) => showScoreDialog());
        } else {
          //next question
          setState(() {
            flag = 0;
            selectedAnswer = null;
            currentQuestionIndex++;
          });
        }
      },
    );
  }

  previousButton() {
    bool isFirstQuestion = false;
    if (currentQuestionIndex == 0) {
      isFirstQuestion = true;
    }

    return isFirstQuestion
        ? Container()
        : DefaultButton(
            childWidget: const Text(
              "Previous",
              style: TextStyle(color: Colors.white),
            ),
            borderRadius: 10.0,
            // style: ElevatedButton.styleFrom(
            //   shape: const StadiumBorder(),
            //   primary: Colors.blueAccent,
            //   onPrimary: Colors.white,
            // ),
            onPressed: () {
              setState(() {
                // flag = 0;
                selectedAnswer = null;
                currentQuestionIndex--;
              });
            },
          );
  }

  showScoreDialog() {
    bool isPassed = false;

    if (score >= questionList.length * 0.6) {
      //pass if 60 %
      isPassed = true;
    }
    String title = isPassed ? "Passed " : "Failed";

    return AlertDialog(
      title: Text(
        title + " | Score is $score",
        style: TextStyle(color: isPassed ? Colors.green : Colors.redAccent),
      ),
      content: ElevatedButton(
        child: const Text("Back to home", style: TextStyle(color: Colors.white),),
        onPressed: () {
          Navigator.pop(context);
          Navigator.pop(context);
          setState(() {
            flag = 0;
            currentQuestionIndex = 0;
            score = 0;
            selectedAnswer = null;
          });
        },
      ),
    );
  }
}
