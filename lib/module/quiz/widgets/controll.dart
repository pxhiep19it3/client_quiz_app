import 'package:client_quiz_app/module/quiz/provider/home.provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/routes.dart';

class Controll extends StatelessWidget {
  const Controll(
      {super.key,
      required this.width,
      required this.isSmall,
      required this.isMedium});
  final double width;
  final bool isSmall;
  final bool isMedium;

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, model, child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GridView.count(
              crossAxisCount: isSmall == false && isMedium == true
                  ? 3
                  : isSmall
                      ? 2
                      : 5,
              shrinkWrap: true,
              children: List.generate(
                model.questions.length,
                (index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      children: [
                        SizedBox(
                          height: 50,
                          width: 100,
                          child: ElevatedButton(
                              onPressed: () {
                                model.animateToIndex(index);
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      model.questions[index].userRep == null
                                          ? const Color(0xfff0f0f0)
                                          : const Color(0xff1ba1e2)),
                              child: Text(
                                "${index + 1}",
                                style: const TextStyle(
                                    fontSize: 20, color: Colors.black),
                              )),
                        ),
                        model.questions[index].isFlaged ?? false
                            ? const Padding(
                                padding: EdgeInsets.only(left: 35),
                                child: Icon(
                                  Icons.flag,
                                  color: Color(0xffF8CB2E),
                                ),
                              )
                            : const Text(""),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              width: width,
              height: 42,
              child: ElevatedButton(
                  onPressed: () {
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text('Thông báo'),
                        content: const Text('Bạn có chắc chắn nộp bài?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Tiếp tục làm bài'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  kResult, (Route<dynamic> route) => false);
                            },
                            child: const Text('Nộp bài'),
                          ),
                        ],
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffdb524c),
                  ),
                  child: const Text("NỘP BÀI")),
            ),
          ],
        );
      },
    );
  }
}
