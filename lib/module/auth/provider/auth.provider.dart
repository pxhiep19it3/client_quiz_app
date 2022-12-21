import 'package:client_quiz_app/repo/user.repo.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  UserRepo repo = UserRepo();
  final TextEditingController _examCodeController = TextEditingController();
  TextEditingController get examCodeController => _examCodeController;
  final TextEditingController _eIDController = TextEditingController();
  TextEditingController get eIDController => _eIDController;
  bool? _isLogin;
  bool? get isLogin => _isLogin;
  Future<void> login() async {
    final prefs = await SharedPreferences.getInstance();
    await repo.login(_examCodeController.text, _eIDController.text);
    _isLogin = repo.isLogin;
    await repo.getExammeeID(_eIDController.text);
    await repo.getExammID(_examCodeController.text);
    await prefs.setString('userID', repo.userID!);
    await prefs.setString('examID', repo.examID!);
    await prefs.setString('exammeID', _eIDController.text);
    await prefs.setString('examCode', _examCodeController.text);
    notifyListeners();
  }
}
