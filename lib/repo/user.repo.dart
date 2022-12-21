import 'package:client_quiz_app/model/examme.dart';

import '../common/url.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class UserRepo {
  bool? _isLogin;
  bool? get isLogin => _isLogin;

  String? _userID;
  String? get userID => _userID;

  String? _examID;
  String? get examID => _examID;

  Future<void> login(String code, String eID) async {
    var url = Uri.parse(Url.login);
    var response = await http.post(url, body: {
      "eID": eID,
      "code": code,
    });

    var data = json.decode(response.body);
    if (data.toString() == "Success") {
      _isLogin = true;
    } else {
      _isLogin = false;
    }
  }

  Future<List<Examme>> getExamme(String eID) async {
    var url = Uri.parse(Url.getExamme);
    var res = await http.post(url, body: {"eID": eID});
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      return body.map((e) => Examme.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load!');
    }
  }

  Future<void> getExammeeID(eID) async {
    var url = Uri.parse(Url.getExammeeID);
    var response = await http.post(url, body: {
      "eID": eID,
    });

    _userID = json.decode(response.body);
  }
   Future<void> getExammID(code) async {
    var url = Uri.parse(Url.getExamID);
    var response = await http.post(url, body: {
      "code": code,
    });

    _examID = json.decode(response.body);
  }
}
