import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({super.key});

  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
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
            const Text('ADMIN',
                style: TextStyle(color: Colors.white, fontSize: 36.0)),
            Container(
              padding: EdgeInsets.all(50.0),
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
                  const TextField(
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
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
                  const TextField(
                    obscureText: true,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(
                          Icons.lock_outline,
                          color: Colors.black,
                        )),
                  ),
                  const SizedBox(height: 30.0),
                  ElevatedButton(
                    onPressed: () => context.go("/admin_home"),
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 40),
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        backgroundColor: Colors.green),
                    child: const Text("Login",
                        style: TextStyle(color: Colors.white)),
                  ),
                  const SizedBox(height: 40.0),
                  TextButton(
                      onPressed: () =>
                          context.push("/admin_login/forgot_password"),
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
