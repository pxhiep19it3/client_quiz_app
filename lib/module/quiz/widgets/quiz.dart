import 'package:client_quiz_app/module/quiz/provider/home.provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'quiz.item.dart';

class Quiz extends StatelessWidget {
  const Quiz({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Consumer<HomeProvider>(
      builder: ((context, model, child) {
        return ListView.builder(
            controller: model.controller,
            itemCount: model.questions.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: height * 0.45,
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xffD0C9C0)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: SingleChildScrollView(
                            child: QuizItem(
                          index: index,
                          question: model.questions[index],
                        )),
                      ),
                    ),
                  ],
                ),
              );
            });
      }),
    );
  }
}
