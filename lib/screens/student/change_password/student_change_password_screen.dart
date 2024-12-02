import 'package:flutter/material.dart';

part "student_change_password_controller.dart";

class StudentChangePasswordScreen extends StatefulWidget {
  const StudentChangePasswordScreen({super.key});

  @override
  State<StudentChangePasswordScreen> createState() =>
      _StudentChangePasswordScreenState();
}

class _StudentChangePasswordScreenState
    extends StudentChangePasswordController {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Change Password"),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 0.0),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              "Old Password",
              style: TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 5.0),
            TextField(
              controller: _oldPasswordController,
              obscureText: _isOldPasswordObscured,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(
                    Icons.lock_outline,
                    color: Colors.black,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(_isOldPasswordObscured
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _isOldPasswordObscured = !_isOldPasswordObscured;
                      });
                    },
                  )),
            ),
            const SizedBox(height: 20.0),
            const Text(
              "New Password",
              style: TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 5.0),
            TextField(
              controller: _newPasswordController,
              obscureText: _isNewPasswordObscured,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(
                    Icons.lock_outline,
                    color: Colors.black,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(_isNewPasswordObscured
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _isNewPasswordObscured = !_isNewPasswordObscured;
                      });
                    },
                  )),
            ),
            const SizedBox(height: 15.0),
            ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    backgroundColor: const Color.fromARGB(255, 221, 219, 219)),
                child: Text("Confirm Password"))
          ],
        )),
      ),
    );
  }
}
