import 'package:counter_app/constants/colors.dart';
import 'package:counter_app/screens/dashboard/dashboard.dart';
import 'package:counter_app/screens/login_register/index.dart';
import 'package:counter_app/screens/login_register/user_login.dart';
import 'package:counter_app/screens/login_register/user_register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        routes: {
          '/dashboard': (_) => Dashboard(),
          '/login_index': (_) => LoginIndex(),
          '/login': (_) => UserLogin(),
          '/register': (_) => UserRegister(),
        },
        home: CheckToken(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class CheckToken extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TokenState();
  }
}

class _TokenState extends State<CheckToken> {
  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('user_token');

    await Future.delayed(Duration(seconds: 2));

    if (token == null || token.isEmpty) {
      Navigator.pushReplacementNamed(context, '/login_index');
    } else {
      Navigator.pushReplacementNamed(context, '/dashboard');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WhiteColor,
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
