import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../widgets/students/student_details_widget.dart';

part "teacher_student_view_controller.dart";

class TeacherStudentViewScreen extends StatefulWidget {
  const TeacherStudentViewScreen({super.key});

  @override
  State<TeacherStudentViewScreen> createState() =>
      _TeacherStudentViewScreenState();
}

class _TeacherStudentViewScreenState extends TeacherStudentViewController {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Students List"),
        elevation: 0,
        backgroundColor: Colors.white,
        shape: const Border(
          bottom: BorderSide(color: Colors.black, width: 2.0), // Black outline
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push("/teacher_home/students/add"),
          )
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(
              top: 20.0, left: 42.0, right: 42.0, bottom: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Text("Student List", style: TextStyle(fontSize: 28.0)),
              const SizedBox(height: 12.0),
              Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 194, 194, 194),
                    borderRadius: BorderRadius.circular(10.0)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: _teacherQueryController,
                      decoration: InputDecoration(
                        hintText: "Search Student's Name",
                        hintStyle: const TextStyle(
                            color: Color.fromARGB(255, 194, 194, 194)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 8.0),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: () {
                            setState(() {});
                          },
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    Container(
                      padding: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: DropdownButton<String>(
                        value: selectedSection,
                        icon: const Icon(Icons.arrow_downward),
                        elevation: 16,
                        items: years
                            .map<DropdownMenuItem<String>>((String section) {
                          return DropdownMenuItem<String>(
                            value: section,
                            child: Text(section),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedSection = newValue!;
                          });
                        },
                        hint: const Text(
                          'Select section',
                          style: TextStyle(
                            color: Color.fromARGB(255, 0, 0,
                                0), // Change hint text color to black
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12.0),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
              StudentDetailsWidget(
                studentId: "lol",
                lastName: "mario",
                firstName: "juan",
                email: "dummy@gmail.com",
                username: "meok",
                password: "hello",
                sectionId: "some",
                sectionName: "9201",
                dateRegistered: Timestamp.now(),
              )
              // Expanded(
              //   child: ListView.builder(
              //     itemCount: filteredList.length,
              //     itemBuilder: (context, index) {
              //       final teacher = filteredList[index];
              //       return TeacherDetailsWidget(
              //         itemNumber: index + 1,
              //         uid: teacher["uid"],
              //         lastName: teacher["lastName"] ?? "None",
              //         firstName: teacher["firstName"] ?? "None",
              //         email: teacher['email'] ?? 'Unknown Email',
              //         username: teacher['username'] ?? 'Unknown Username',
              //         password: teacher['password'] ?? 'Unknown Password',
              //         dateRegistered: teacher['dateCreated'] ?? Timestamp.now(),
              //       );
              //     },
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
