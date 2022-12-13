import 'package:client_quiz_app/repo/score.repo.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ResultProvider extends ChangeNotifier {
  ScoreRepo repo = ScoreRepo();

  double _finalScore = 0;
  double get finalScore => _finalScore;

  String _examCode = '';
  String get examCode => _examCode;

  String _fullName = '';
  String get fullName => _fullName;

  String _bod = '';
  String get bod => _bod;

  String _exammeeID = '';
  String get exammeeID => _exammeeID;

  void getScore() async {
    final prefs = await SharedPreferences.getInstance();
    String userID = prefs.getString('userID')!;
    String examID = prefs.getString('examID')!;
    _examCode = prefs.getString('examCode')!;
    _fullName = prefs.getString('name')!;
    _bod = prefs.getString('bod')!;
    _exammeeID = prefs.getString('exammeID')!;
    List listScore = await repo.getScore(examID, userID);
    for (var i = 0; i < listScore.length; i++) {
      _finalScore += double.parse(listScore[i]);
    }
    insertScore(userID);
    notifyListeners();
  }

  void insertScore(String userID) async {
    await repo.insertScore(_finalScore.toString(), userID);
    notifyListeners();
  }
}
