import 'package:flutter/material.dart';

class TeacherForgotPasswordScreen extends StatefulWidget {
  const TeacherForgotPasswordScreen({super.key});

  @override
  State<TeacherForgotPasswordScreen> createState() =>
      _TeacherForgotPasswordScreenState();
}

class _TeacherForgotPasswordScreenState
    extends State<TeacherForgotPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Forgot Password?",
            style: TextStyle(fontSize: 32.0),
          ),
          SizedBox(height: 20.0),
          Text("Please contact your administrator to retrieve your password."),
        ],
      )),
    );
  }
}
