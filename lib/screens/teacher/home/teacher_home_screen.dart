import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../utils.dart';

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
        title: Text("Welcome, ${teacherDisplayName ?? "Teacher"}"),
        elevation: 0,
        backgroundColor: Colors.white,
        shape: const Border(
          bottom: BorderSide(color: Colors.black, width: 2.0),
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
              title: const Text("My Student's Progress"),
              onTap: () => context.push("/teacher_home/student_progress"),
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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 42.0),
          child: StreamBuilder<List<Map<String, dynamic>>>(
            stream: getSectionsWithStudentCounts(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }

              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text("No sections found"));
              }

              List<Map<String, dynamic>> sectionsWithCounts = snapshot.data!;

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Sections Handled",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: Colors.black, width: 1.5),
                    ),
                    child: DataTable(
                      columnSpacing: 20,
                      columns: const [
                        DataColumn(
                          label: Text(
                            "Section Name",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            "Student Count",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                      rows: sectionsWithCounts.map((sectionData) {
                        return DataRow(
                          cells: [
                            DataCell(Text(sectionData['sectionName'])),
                            DataCell(Text(sectionData['studentCount'].toString())),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

