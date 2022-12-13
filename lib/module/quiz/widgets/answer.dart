import 'package:client_quiz_app/model/question.dart';
import 'package:client_quiz_app/module/quiz/provider/home.provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../model/answer.dart';

class CustomAnswer extends StatelessWidget {
  const CustomAnswer(
      {super.key,
      required this.index,
      required this.question,
      required this.isFlaged,
      required this.questionContent,
      required this.score,
      required this.selectAnswer});
  final int index;
  final Question question;
  final bool isFlaged;
  final String questionContent;
  final double score;
  final Function selectAnswer;
  

  bool getSelect(Answer cur, index) {
    if (question.userRep == null) {
      return false;
    }
    return cur.id == question.userRep!.answerID;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: ((context, model, child) {
        return ListView.builder(
            itemCount: question.answers!.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                splashColor: Colors.blueAccent,
                onTap: () {
                  selectAnswer(
                      question.id!, question.answers![index], isFlaged, score);
                },
                child: AnswerItem(
                    item: question.answers![index],
                    index: index,
                    select: getSelect(question.answers![index], index)),
              );
            });
      }),
    );
  }
}

class AnswerItem extends StatelessWidget {
  const AnswerItem(
      {super.key,
      required this.item,
      required this.index,
      required this.select});
  final Answer item;
  final int index;
  final bool select;

  @override
  Widget build(BuildContext context) {
    List<String> label = ['A', 'B', 'C', 'D'];
    return Container(
      margin: const EdgeInsets.all(7.0),
      child: Row(
        children: [
          Container(
            height: 40.0,
            width: 40.0,
            decoration: BoxDecoration(
              color: select ? Colors.green : Colors.transparent,
              border: Border.all(
                  width: 1.0, color: select ? Colors.green : Colors.grey),
              borderRadius: const BorderRadius.all(Radius.circular(2.0)),
            ),
            child: Center(
              child: Text(label[index],
                  style: TextStyle(
                      color: select ? Colors.white : Colors.black,
                      fontSize: 18.0)),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                item.text,
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                maxLines: 3,
              ),
            ),
          )
        ],
      ),
    );
  }
}
