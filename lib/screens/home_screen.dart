import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

part '../controllers/home_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('PhysIX Companion App',
                style: TextStyle(color: Colors.white, fontSize: 36.0)),
            const SizedBox(height: 25.0),
            const Text('Login as',
                style: TextStyle(color: Colors.white, fontSize: 24.0)),
            const SizedBox(height: 25.0),
            Container(
                padding: const EdgeInsets.all(25.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0)),
                constraints:
                    const BoxConstraints(maxWidth: 300, maxHeight: 300),
                width: double.infinity,
                height: double.infinity,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => context.go("/admin_login"),
                          style: ElevatedButton.styleFrom(
                              minimumSize: const Size(double.infinity, 0),
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)))),
                          child: const Text("Admin"),
                        ),
                      ),
                      const SizedBox(height: 40.0),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => {},
                          style: ElevatedButton.styleFrom(
                              minimumSize: const Size(double.infinity, 0),
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)))),
                          child: const Text("Teacher"),
                        ),
                      ),
                      const SizedBox(height: 40.0),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              minimumSize: const Size(double.infinity, 0),
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)))),
                          child: const Text("Student"),
                        ),
                      ),
                    ]))
          ],
        ),
      ),
    );
  }
}
