import 'package:client_quiz_app/common/responsive/responsive_container.dart';
import 'package:client_quiz_app/module/result/provider/result.provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({super.key});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  ResultProvider provider = ResultProvider();

  @override
  void initState() {
    super.initState();
    initData();
  }

  initData() async {
    provider.getScore();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return ResponsiveContainer(
      small: ResultScreen(
        width: width * 0.7,
        provider: provider,
      ),
      large: ResultScreen(
        width: width * 0.3,
        provider: provider,
      ),
      medium: ResultScreen(
        width: width * 0.5,
        provider: provider,
      ),
    );
  }
}

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key, required this.width, required this.provider});
  final double width;
  final ResultProvider provider;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => provider,
      builder: (context, child) {
        return Consumer<ResultProvider>(
          builder: ((context, value, child) {
            return Scaffold(
              backgroundColor: Colors.white,
              body: Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                    const Text(
                      "Material Quiz App For School",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Image.network(
                      "https://adamosoft.com/blog/wp-content/uploads/2019/04/Flutter.png",
                      height: 300,
                      width: 450,
                    ),
                    SizedBox(
                      width: width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Mã bài thi',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          Text(provider.examCode,
                              style: const TextStyle(fontSize: 20)),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('SBD',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20)),
                          Text(provider.exammeeID,
                              style: const TextStyle(fontSize: 20)),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Họ và tên',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20)),
                          Text(provider.fullName,
                              style: const TextStyle(fontSize: 20)),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Ngày sinh',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20)),
                          Text(provider.bod,
                              style: const TextStyle(fontSize: 20)),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Điểm',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20)),
                          Text(provider.finalScore.toString(),
                              style: const TextStyle(fontSize: 20)),
                        ],
                      ),
                    ),
                  ])),
            );
          }),
        );
      },
    );
  }
}
