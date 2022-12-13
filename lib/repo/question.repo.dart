import 'package:client_quiz_app/model/question.dart';

import '../common/url.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/answer.dart';
import '../model/exam_result.dart';

class QuestionRepo {
  List<Map<dynamic, dynamic>> newlistq = [];
  List<Map<dynamic, dynamic>> newlist = [];
  List<Map<dynamic, dynamic>> userRepList = [];

  Future<List<Question>> getQuestion(String eID) async {
    var urlResult = Uri.parse(Url.getExammeResult);
    var resResult = await http.post(urlResult, body: {"exammeeID": eID});
    var urlQuestion = Uri.parse(Url.getExammeQuestion);
    var urlAnswer = Uri.parse(Url.getAnswer);
    var resQuestion = await http.post(urlQuestion, body: {"exammeeID": eID});
    if (resResult.statusCode == 200 && resQuestion.statusCode == 200) {
      List<dynamic> bodyResult = jsonDecode(resResult.body);
      List<dynamic> bodyQuestion = jsonDecode(resQuestion.body);

      userRepList =
          bodyResult.map((dynamic e) => e as Map<dynamic, dynamic>).toList();

      newlistq =
          bodyQuestion.map((dynamic e) => e as Map<dynamic, dynamic>).toList();
      for (var i = 0; i < newlistq.length; i++) {
        var item = newlistq[i];

        var resAnswer = await http
            .post(urlAnswer, body: {"questionID": item['questionID']});

        if (resAnswer.statusCode == 200) {
          List<dynamic> bodyAnswer = jsonDecode(resAnswer.body);
          for (var res in bodyAnswer) {
            newlist.add(<dynamic, dynamic>{
              'ID': res['ID'],
              'questionID': item['questionID'],
              'content': res['content'],
              'isCorrect': res['isCorrect'],
            });
          }
        }
      }

      List<Question> qs = [];
      for (var i = 0; i < newlistq.length; i++) {
        var item = newlistq[i];
        List<Map<dynamic, dynamic>> t = newlist.where((element) {
          return element['questionID'] == item['questionID'];
        }).toList();

        List<Answer> ans = t.map((e) {
          return Answer(
              text: e['content'].toString(),
              isCorrect: int.parse(e['isCorrect']) == 1,
              id: int.parse(e['ID']));
        }).toList();

        List<Map<dynamic, dynamic>>? t1 = userRepList
            .where((e) => e['questionID'] == item['questionID'])
            .toList();

        ExamResult? t2;
        t2 = t1.isNotEmpty
            ? ExamResult(
                questionID: int.parse(t1[0]['questionID']),
                answerID: int.parse(t1[0]['answerID']),
                examID: int.parse(t1[0]['examID']),
                exammeeID: int.parse(t1[0]['exammeeID']))
            : null;
        qs.add(Question(
            id: int.parse(item['questionID']),
            question: item['question'].toString(),
            answers: ans,
            isFlaged: int.parse(item['isFlag']) == 1,
            userRep: t2,
            score: double.parse(item['score'])));
      }
      return qs;
    } else {
      throw Exception('Failed to load!');
    }
  }

  Future<void> setFlag(int isFlag, int questionID) async {
    var url = Uri.parse(Url.setFlag);
    await http.post(url, body: {
      "isFlag": isFlag.toString(),
      "questionID": questionID.toString(),
    });
  }

  Future<void> insertExamResult(int questionID, int answerID, int isCorrect,
      int exammeeID, int examID, double score) async {
    var url = Uri.parse(Url.insertExamResult);
    await http.post(url, body: {
      "questionID": questionID.toString(),
      "answerID": answerID.toString(),
      "isCorrect": isCorrect.toString(),
      "exammeeID": exammeeID.toString(),
      "examID": examID.toString(),
      "score": score.toString()
    });
  }

  Future<void> updateExamResult(
      int questionID, int answerID, int isCorrect, double score) async {
    var url = Uri.parse(Url.updateExamResult);
    await http.post(url, body: {
      "questionID": questionID.toString(),
      "answerID": answerID.toString(),
      "isCorrect": isCorrect.toString(),
      "score": score.toString()
    });
  }

  Future<void> updateTime(int id, int timeTest) async {
    var url = Uri.parse(Url.updateTime);
    await http.post(url, body: {
      "ID": id.toString(),
      "timeTest": timeTest.toString(),
    });
  }


}
