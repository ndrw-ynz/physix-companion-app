import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

part "teacher_home_controller.dart";

class TeacherHomeScreen extends StatefulWidget {
  const TeacherHomeScreen({super.key});

  @override
  State<TeacherHomeScreen> createState() => _TeacherHomeScreenState();
}

class _TeacherHomeScreenState extends TeacherHomeController {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Welcome, TEACHER"),
          elevation: 0,
          backgroundColor: Colors.white,
          shape: const Border(
            bottom:
                BorderSide(color: Colors.black, width: 2.0), // Black outline
          ),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.grey,
                ),
                child: Text(
                  'TEACHER',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.person_2_outlined),
                title: const Text('Students List'),
                onTap: () => context.push("/teacher_home/students"),
              ),
              ListTile(
                leading: const Icon(Icons.book_outlined),
                title: const Text('Section Progress'),
                onTap: () => {},
              ),
              ListTile(
                leading: const Icon(Icons.lock_reset),
                title: const Text('Change Password'),
                onTap: () => context.push("/teacher_home/change_password"),
              ),
              ListTile(
                leading: const Icon(Icons.exit_to_app_outlined),
                title: const Text('Logout'),
                onTap: () => logOut(),
              ),
            ],
          ),
        ),
        body: const Center(
            child: Padding(
                padding: const EdgeInsets.only(left: 42.0, right: 42.0),
                child: Text("Center"))));
  }
}
