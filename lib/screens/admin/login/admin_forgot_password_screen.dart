import 'package:flutter/material.dart';

class AdminForgotPasswordScreen extends StatelessWidget {
  const AdminForgotPasswordScreen({super.key});

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
              "Please contact the developers of this application to retrieve the password."),
          SizedBox(height: 20.0),
          Text("Email:"),
          Text("1. balatayo@cpu.edu.ph"),
          Text("2. payofilin.payofilin-21@cpu.edu.ph"),
          Text("3. tolentino@cpu.edu.ph"),
          Text("4. yanza@cpu.edu.ph")
        ],
      )),
    );
  }
}
