import 'dart:async';

import 'package:client_quiz_app/common/routes.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../repo/question.repo.dart';

class Clock extends StatefulWidget {
  const Clock({super.key});

  @override
  State<Clock> createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  late int _maxSeconds = 0;
  int _currentSecond = 0;
  late Timer _timer;
  bool _lowTime = false;
  String? exammeID;
  bool nextPage = false;

  String get _timerText {
    const secondsPerMinute = 60;
    final secondsLeft = _maxSeconds - _currentSecond;
    final formattedMinutesLeft =
        (secondsLeft ~/ secondsPerMinute).toString().padLeft(2, '0');
    final formattedSecondsLeft =
        (secondsLeft % secondsPerMinute).toString().padLeft(2, '0');

    return '$formattedMinutesLeft : $formattedSecondsLeft';
  }

  @override
  void initState() {
    super.initState();
    initData();
  }

  initData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _maxSeconds = prefs.getInt('time')!;
      exammeID = prefs.getString('userID');
    });
    _startTimer();
    _setColor();
    _setTime();
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  void _startTimer() {
    Timer.periodic(const Duration(seconds: 1), (Timer t) async {
      _timer = t;
      if (t.tick >= _maxSeconds) t.cancel();
      setState(() {
        _currentSecond = t.tick;
      });
    });
  }

  void _setColor() {
    const duration = Duration(seconds: 1);
    _timer = Timer.periodic(duration, (Timer timer) {
      const secondsPerMinute = 60;
      final secondsLeft = _maxSeconds - _currentSecond;
      final formattedMinutesLeft =
          (secondsLeft ~/ secondsPerMinute).toString().padLeft(2, '0');
      int? tenMinutes = int.parse(formattedMinutesLeft);
      if (tenMinutes <= 5) {
        setState(() {
          _lowTime = !_lowTime;
        });
      }

      if (tenMinutes == 0 && secondsLeft == 1) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil(kResult, (Route<dynamic> route) => false);
      }
    });
  }

  void _setTime() async {
    const duration = Duration(seconds: 60);
    _timer = Timer.periodic(duration, (Timer timer) async {
      const secondsPerMinute = 60;
      final secondsLeft = _maxSeconds - _currentSecond;
      final formattedMinutesLeft =
          (secondsLeft ~/ secondsPerMinute).toString().padLeft(2, '0');
      var currentMinutes = int.parse(formattedMinutesLeft);

      setState(() {
        currentMinutes = currentMinutes - 1;
      });
      var repo = QuestionRepo();
      await repo.updateTime(int.parse(exammeID!), (currentMinutes + 1) * 60);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        _timerText,
        style: TextStyle(
            fontSize: 60,
            fontWeight: FontWeight.bold,
            color: _lowTime ? Colors.red : const Color(0xff646FD4)),
      ),
    );
  }
}
