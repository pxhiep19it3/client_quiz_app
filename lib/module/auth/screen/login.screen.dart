// ignore_for_file: use_build_context_synchronously

import 'package:client_quiz_app/common/routes.dart';
import 'package:client_quiz_app/common/widgets/basic_button.dart';
import 'package:client_quiz_app/module/auth/provider/auth.provider.dart';
import 'package:client_quiz_app/common/responsive/responsive_container.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final form = GlobalKey<FormState>();

  AuthProvider provider = AuthProvider();

  @override
  void initState() {
    super.initState();
    initData();
  }

  initData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userID', '');
    await prefs.setString('examID', '');
    await prefs.setString('exammeID', '');
    await prefs.setString('examCode', '');
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return ResponsiveContainer(
      large: LoginScreen(
        width: width * 0.5,
        provider: provider,
        form: form,
      ),
      small: LoginScreen(
        width: width * 0.8,
        provider: provider,
        form: form,
      ),
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen(
      {super.key,
      required this.width,
      required this.provider,
      required this.form});
  final double width;
  final AuthProvider provider;
  final GlobalKey<FormState> form;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: form,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Material Quiz App For School",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
              Image.asset(
                "assets/images/flutter.png",
                height: 350,
                width: 350,
              ),
              SizedBox(
                width: width,
                child: TextFormField(
                  controller: provider.examController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Chưa nhập mã bài thi!';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Ví dụ: FE123',
                      labelText: 'Nhập mã bài thi'),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: width,
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Chưa nhập số báo danh!';
                    }
                    return null;
                  },
                  controller: provider.exammeeControleer,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Ví dụ: 19IT152',
                      labelText: 'Nhập số báo danh'),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              BacsicButton(
                  onPressed: () async {
                    if (form.currentState!.validate()) {
                      await provider.login();
                      if (provider.isLogin == true) {
                        homePage(context);
                      } else {
                        final snackBar = SnackBar(
                          content: const Text('Thông tin đăng nhập sai!'),
                          action: SnackBarAction(
                            label: 'Hide',
                            onPressed: () {},
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    }
                  },
                  label: 'Đăng nhập',
                  width: 200)
            ],
          ),
        ),
      ),
    );
  }

  void homePage(BuildContext context) {
    Navigator.of(context)
        .pushNamedAndRemoveUntil(kHome, (Route<dynamic> route) => false);
  }
}
