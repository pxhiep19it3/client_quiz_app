import '../common/url.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ScoreRepo {
  Future<List> getScore(String examID, String exammeeID) async {
    List finalScore = [];
    var url = Uri.parse(Url.getScore);
    var response =
        await http.post(url, body: {"examID": examID, "exammeeID": exammeeID});

    finalScore = json.decode(response.body);
    return finalScore;
  }

  Future<void> insertScore(String finalScore, String userID) async {
    var url = Uri.parse(Url.insertScore);
    await http.post(url, body: {"userID": userID, "finalScore": finalScore});
  }
}
