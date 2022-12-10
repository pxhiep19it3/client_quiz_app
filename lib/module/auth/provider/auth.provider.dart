import 'package:client_quiz_app/repo/user.repo.dart';
import 'package:flutter/widgets.dart';

class AuthProvider extends ChangeNotifier {
  UserRepo repo = UserRepo();
  final TextEditingController _examController = TextEditingController();
  TextEditingController get examController => _examController;
  final TextEditingController _exammeeControleer = TextEditingController();
  TextEditingController get exammeeControleer => _exammeeControleer;
  bool? _isLogin;
  bool? get isLogin => _isLogin;
  Future<void> login() async {
    await repo.login(_examController.text, _exammeeControleer.text);
        _isLogin = repo.isLogin;
    notifyListeners();
  }
}
