import '../common/url.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class UserRepo {
  bool? _isLogin;
  bool? get isLogin => _isLogin;
  Future<void> login(String examID, String exammeID) async {
    var url = Uri.parse(Url.login);
    var response = await http.post(url, body: {
      "examID": examID,
      "exammeID": exammeID,
    });

    var data = json.decode(response.body);
    if (data.toString() == "Success") {
      _isLogin = true;
    } else {
      _isLogin = false;
    }
  }
}
