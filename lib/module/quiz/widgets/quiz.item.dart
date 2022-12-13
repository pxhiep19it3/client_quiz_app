import 'package:client_quiz_app/module/quiz/widgets/answer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../model/question.dart';
import '../provider/home.provider.dart';

class QuizItem extends StatelessWidget {
  const QuizItem({super.key, required this.index, required this.question});
  final int index;
  final Question question;
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: ((context, model, child) {
        return InkWell(
          onTap: () {
            model.setFlag(index);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.flag_circle,
                    color:
                        question.isFlaged ?? false ? Colors.red : Colors.green,
                  ),
                  const Text(
                    "Đặt cờ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
              Text(
                "Quiz ${index + 1}: ${question.question}",
                maxLines: 3,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              CustomAnswer(
                index: index,
                question: question,
                isFlaged: question.isFlaged!,
                questionContent: question.question ?? '',
                score: question.score!,
                selectAnswer: model.selectAnswer,
              )
            ],
          ),
        );
      }),
    );
  }
}
