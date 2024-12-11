import 'package:flutter/material.dart';

class StudentForgotPasswordScreen extends StatefulWidget {
  const StudentForgotPasswordScreen({super.key});

  @override
  State<StudentForgotPasswordScreen> createState() =>
      _StudentForgotPasswordScreenState();
}

class _StudentForgotPasswordScreenState
    extends State<StudentForgotPasswordScreen> {
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
          Text(
              "Please contact your physics teacher to retrieve your password."),
        ],
      )),
    );
  }
}
