import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:physix_companion_app/services/auth_service.dart';

part "teacher_login_controller.dart";

class TeacherLoginScreen extends StatefulWidget {
  const TeacherLoginScreen({super.key});

  @override
  State<TeacherLoginScreen> createState() => _TeacherLoginScreenState();
}

class _TeacherLoginScreenState extends TeacherLoginController {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Logging in',
                style: TextStyle(color: Colors.white, fontSize: 30.0)),
            const SizedBox(height: 10.0),
            const Text('as',
                style: TextStyle(color: Colors.white, fontSize: 26.0)),
            const SizedBox(height: 10.0),
            const Text('TEACHER',
                style: TextStyle(color: Colors.white, fontSize: 36.0)),
            Container(
              padding: const EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 0.0),
              constraints: const BoxConstraints(maxWidth: 600, maxHeight: 400),
              width: double.infinity,
              height: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Username/Email",
                    style: TextStyle(color: Colors.white),
                  ),
                  TextField(
                    controller: _usernameController,
                    style: const TextStyle(color: Colors.black),
                    decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color: Colors.black,
                        )),
                  ),
                  const SizedBox(height: 10.0),
                  const Text(
                    "Password",
                    style: TextStyle(color: Colors.white),
                  ),
                  TextField(
                    controller: _passwordController,
                    obscureText: _isObscured,
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
                          icon: Icon(_isObscured
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _isObscured = !_isObscured;
                            });
                          },
                        )),
                  ),
                  const SizedBox(height: 30.0),
                  ElevatedButton(
                    onPressed: () => validateTeacherLogin(),
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 40),
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        backgroundColor: Colors.green),
                    child: const Text("Login",
                        style: TextStyle(color: Colors.white)),
                  ),
                  const SizedBox(height: 30.0),
                  TextButton(
                      onPressed: () =>
                          context.push("/teacher_login/forgot_password"),
                      style: TextButton.styleFrom(
                          minimumSize: const Size(double.infinity, 40)),
                      child: const Text(
                        "Forgot Password?",
                        style: TextStyle(color: Colors.white),
                      ))
                ],
              ),
            )
          ],
        )));
  }
}
