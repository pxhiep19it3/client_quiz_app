import 'package:client_quiz_app/repo/user.repo.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  UserRepo repo = UserRepo();
  final TextEditingController _examController = TextEditingController();
  TextEditingController get examController => _examController;
  final TextEditingController _exammeeControleer = TextEditingController();
  TextEditingController get exammeeControleer => _exammeeControleer;
  bool? _isLogin;
  bool? get isLogin => _isLogin;
  Future<void> login() async {
    final prefs = await SharedPreferences.getInstance();

    await repo.login(_examController.text, _exammeeControleer.text);
    _isLogin = repo.isLogin;
    await repo.getExammeeID(_exammeeControleer.text);
    await repo.getExammID(_examController.text);
    await prefs.setString('userID', repo.userID!);
    await prefs.setString('examID', repo.examID!);
    await prefs.setString('exammeID', _exammeeControleer.text);
     await prefs.setString('examCode', _examController.text);
    notifyListeners();
  }
}
