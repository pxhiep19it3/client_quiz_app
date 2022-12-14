import 'package:client_quiz_app/module/quiz/widgets/clock.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/home.provider.dart';

class Information extends StatelessWidget {
  const Information({super.key, required this.isSmall});
  final bool isSmall;

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(builder: (context, model, child) {
      return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            !isSmall
                ? Text(
                    model.examme.eID!.toUpperCase(),
                    style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  )
                : Container(),
            !isSmall
                ? const VerticalDivider(
                    color: Colors.white,
                  )
                : Container(),
            Text(model.examme.fullName!.toUpperCase(),
                style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold)),
            !isSmall
                ? const VerticalDivider(
                    color: Colors.white,
                  )
                : Container(),
            !isSmall
                ? Text(model.examme.bod!.toUpperCase(),
                    style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold))
                : Container(),
            const VerticalDivider(
              color: Colors.white,
            ),
            const Clock(),
          ]);
    });
  }
}

