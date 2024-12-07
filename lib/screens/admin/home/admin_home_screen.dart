import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:physix_companion_app/services/auth_service.dart';

part "admin_home_controller.dart";

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends AdminHomeController {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Welcome, ADMIN"),
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
                  'ADMIN',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.person_2_outlined),
                title: const Text('Teacher Info'),
                onTap: () => context.push("/admin_home/teachers"),
              ),
              ListTile(
                leading: const Icon(Icons.book_outlined),
                title: const Text('Section Info'),
                onTap: () => context.push("/admin_home/sections"),
              ),
              ListTile(
                leading: const Icon(Icons.lock_reset),
                title: const Text('Change Password'),
                onTap: () => context.push("/admin_home/change_password"),
              ),
              ListTile(
                leading: const Icon(Icons.exit_to_app_outlined),
                title: const Text('Logout'),
                onTap: () => logOut(),
              ),
            ],
          ),
        ),
        body: Center(
            child: Padding(
          padding: const EdgeInsets.only(left: 42.0, right: 42.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildTile(context, Icons.person, "Teachers",
                  "$teacherCount Teacher(s)", "/admin_home/teachers"),
              const SizedBox(height: 25.0),
              _buildTile(context, Icons.person, "Sections",
                  "$sectionCount Section(s)", "/admin_home/sections"),
              const SizedBox(height: 25.0),
              _buildTile(context, Icons.person, "Students",
                  "$studentCount Student(s)", "/admin_home"),
            ],
          ),
        )));
  }

  Widget _buildTile(BuildContext context, IconData icon, String label,
      String description, String location) {
    return ListTile(
      leading: Icon(icon, size: 40),
      title: Text(label,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      subtitle: Text(description),
      onTap: () => context.push(location),
      contentPadding:
          const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      tileColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: const BorderSide(color: Colors.black, width: 1.5),
      ),
    );
  }
}
