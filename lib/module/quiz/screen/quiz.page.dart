import 'package:client_quiz_app/common/responsive/responsive_container.dart';
import 'package:client_quiz_app/common/routes.dart';
import 'package:client_quiz_app/common/widgets/basic_button.dart';
import 'package:client_quiz_app/module/quiz/provider/home.provider.dart';
import 'package:client_quiz_app/module/quiz/widgets/information.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/controll.dart';
import '../widgets/quiz.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    HomeProvider provider = HomeProvider();
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return ResponsiveContainer(
      large: HomeScreen(
        provider: provider,
        width: width,
        height: height,
        isSmall: false,
        isMedium: false,
      ),
      medium: HomeScreen(
        provider: provider,
        width: width,
        height: height,
        isSmall: false,
        isMedium: true,
      ),
      small: HomeScreen(
        provider: provider,
        width: width,
        height: height,
        isSmall: true,
        isMedium: false,
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen(
      {super.key,
      required this.provider,
      required this.width,
      required this.height,
      required this.isSmall,
      required this.isMedium});
  final HomeProvider provider;
  final double width;
  final double height;
  final bool isSmall;
  final bool isMedium;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeProvider provider = HomeProvider();
  @override
  void initState() {
    super.initState();
    initData();
  }

  initData() async {
    provider.getQuestion();
    provider.getExamme();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => provider,
        builder: (context, child) {
          return Consumer<HomeProvider>(
            builder: ((context, value, child) {
              return Scaffold(
                  body: value.examme.doneTest == false
                      ? Center(
                          child: value.questions.isNotEmpty
                              ? Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: Container(
                                          width: widget.width * 0.95,
                                          height: widget.height * 0.1,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: const Color(0xff1a1b26)),
                                          child: Information(
                                            isSmall: widget.isSmall,
                                          )),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: widget.width * 0.7,
                                          color: const Color(0xfffcffff),
                                          height: widget.height * 0.85,
                                          child: const Quiz(),
                                        ),
                                        Container(
                                          width: widget.width * 0.25,
                                          height: widget.height * 0.85,
                                          decoration: BoxDecoration(
                                              color: const Color(0xffffffff),
                                              border: Border.all(
                                                  color:
                                                      const Color(0XffD0C9C0)),
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: Controll(
                                            isSmall: widget.isSmall,
                                            width: widget.width,
                                            isMedium: widget.isMedium,
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                )
                              : value.isLoading == false
                                  ? const CircularProgressIndicator()
                                  : ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).pushNamed(kLogin);
                                      },
                                      child: const Text('Trở về đăng nhập')))
                      : Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text('Bạn đã hoàn thành bài thi!'),
                              const SizedBox(
                                height: 20,
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pushNamed(kResult);
                                  },
                                  child: const Text('Xem điểm'))
                            ],
                          ),
                        ));
            }),
          );
        });
  }
}
