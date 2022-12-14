import 'package:client_quiz_app/model/question.dart';
import 'package:client_quiz_app/repo/question.repo.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../model/answer.dart';
import '../../../model/exam_result.dart';
import '../../../model/examme.dart';
import '../../../repo/user.repo.dart';

class HomeProvider extends ChangeNotifier {
  QuestionRepo repo = QuestionRepo();

  List<Question> _questions = [];
  List<Question> get questions => _questions;

  String? _userID;
  String? get userID => _userID;

  String? _examID;
  String? get examID => _examID;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  void getQuestion() async {
    final prefs = await SharedPreferences.getInstance();
    _userID = prefs.getString('userID');
    _examID = prefs.getString('examID');
    _questions = await repo.getQuestion(_userID ?? '');
    notifyListeners();
  }

  final ScrollController _controller = ScrollController();
  ScrollController get controller => _controller;
  void animateToIndex(int index) {
    _controller.animateTo(
      index * 380,
      duration: const Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
    notifyListeners();
  }

  void setFlag(int index) async {
    _questions[index].isFlaged = !(_questions[index].isFlaged ?? false);
    await repo.setFlag(
        _questions[index].isFlaged == true ? 1 : 0, _questions[index].id!);
    notifyListeners();
  }

  void selectAnswer(int id, Answer answer, bool? isFlag, double score) async {
    int index = _questions.indexWhere((e) => e.id == id);
    ExamResult an = ExamResult(
        questionID: id,
        answerID: answer.id,
        isCorrect: answer.isCorrect ? 1 : 0);
    if (_questions[index].userRep == null) {
      _questions[index].userRep = an;
      notifyListeners();
      await repo.insertExamResult(id, answer.id, answer.isCorrect ? 1 : 0,
          int.parse(_userID!), int.parse(_examID!), score);
    } else {
      await repo.updateExamResult(id, an.answerID!, answer.isCorrect ? 1 : 0,
          answer.isCorrect ? score : 0);
    }
    _questions[index].userRep = an;
    notifyListeners();
  }

  UserRepo repoUser = UserRepo();
  Examme _examme = Examme();
  Examme get examme => _examme;
  void getExamme() async {
    final prefs = await SharedPreferences.getInstance();
    String? eID = prefs.getString('exammeID');
    List<Examme> tmp = [];
    if (eID != '') {
      _isLoading = false;
      tmp = await repoUser.getExamme(eID!);
      for (var i = 0; i < tmp.length; i++) {
        _examme = tmp[0];
      }
    }
    await prefs.setInt('time', _examme.timeTest ?? 0);
    await prefs.setString('name', _examme.fullName ?? '');
    await prefs.setString('bod', _examme.bod ?? '');
    notifyListeners();
  }
}
