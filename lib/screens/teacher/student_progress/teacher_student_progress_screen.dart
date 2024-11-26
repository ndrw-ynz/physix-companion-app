import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:physix_companion_app/widgets/students/basic_student_progress_details_widget.dart';

part "teacher_student_progress_controller.dart";

class TeacherStudentProgressScreen extends StatefulWidget {
  const TeacherStudentProgressScreen({super.key});

  @override
  State<TeacherStudentProgressScreen> createState() =>
      _TeacherStudentProgressScreenState();
}

class _TeacherStudentProgressScreenState extends TeacherStudentProgressController {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Students Progress"),
        elevation: 0,
        backgroundColor: Colors.white,
        shape: const Border(
          bottom: BorderSide(color: Colors.black, width: 2.0), // Black outline
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(
              top: 20.0, left: 42.0, right: 42.0, bottom: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Text("Student Progress", style: TextStyle(fontSize: 28.0)),
              const SizedBox(height: 12.0),

              // Search and Filter Section with Grey Background
              Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 194, 194, 194),
                  // Grey background
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Search Input Field
                    TextField(
                      controller: _studentQueryController,
                      decoration: InputDecoration(
                        hintText: "Search Student's Name",
                        hintStyle: const TextStyle(
                            color: Color.fromARGB(255, 194, 194, 194)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 8.0),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: () {
                            setState(() {
                              if (_studentQueryController.text.isEmpty) {
                                _fetchAllStudents();
                              } else {
                                _filterStudentSearch();
                              }
                            });
                          },
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12.0),

                    // Row for Section, Lesson, and Difficulty Dropdowns
                    Row(
                      children: [
                        // Section Dropdown
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: DropdownButton<String>(
                              value: selectedSection,
                              icon: const Icon(Icons.arrow_downward),
                              elevation: 16,
                              items: sections.map<DropdownMenuItem<String>>((String section) {
                                return DropdownMenuItem<String>(
                                  value: section,
                                  child: Text(section),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedSection = newValue!;
                                  _filterStudentSearch();
                                });
                              },
                              hint: const Text(
                                'Section',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8.0),

                        // Lesson Dropdown
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: DropdownButton<int>(
                              value: selectedLessonNumber, // Default value set in initState
                              icon: const Icon(Icons.arrow_downward),
                              elevation: 16,
                              items: List.generate(9, (index) => index + 1).map<DropdownMenuItem<int>>((int lesson) {
                                return DropdownMenuItem<int>(
                                  value: lesson,
                                  child: Text('Lesson $lesson'),
                                );
                              }).toList(),
                              onChanged: (int? newValue) {
                                setState(() {
                                  selectedLessonNumber = newValue;
                                  _fetchLessonAttempts();
                                });
                              },
                              hint: const Text('Lesson'),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8.0),

                        // Difficulty Dropdown
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: DropdownButton<String>(
                              value: selectedDifficulty, // Default value set in initState
                              icon: const Icon(Icons.arrow_downward),
                              elevation: 16,
                              items: ['Easy', 'Medium', 'Hard'].map<DropdownMenuItem<String>>((String difficulty) {
                                return DropdownMenuItem<String>(
                                  value: difficulty,
                                  child: Text(difficulty),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedDifficulty = newValue;
                                  _filterStudentSearch();
                                });
                              },
                              hint: const Text('Difficulty'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
              Expanded(
                child: ListView.builder(
                  itemCount: filteredList.length,
                  itemBuilder: (context, index) {
                    final student_progress = filteredList[index];

                    // Initialize default values
                    int lessonNumber = selectedLessonNumber ?? 0;  // Default to selected lesson number
                    String difficulty = selectedDifficulty ?? "Easy";  // Default to selected difficulty
                    bool isAccomplished = false;

                    // Filter lesson attempts based on selected lesson number and difficulty
                    for (var attempt in lessonAttempts) {
                      // Debugging: Print the document ID and the student IDs being compared
                      print('Comparing Student ID: ${student_progress['id']} with Attempt Student ID: ${attempt['studentId']}');
                      print('Attempt Document ID: ${attempt['id']}');

                      if (attempt['studentId'] == student_progress['id'] &&
                          attempt['difficulty'] == difficulty) {

                        // Debugging: Print out the attempt data
                        print('Attempt Data for Student ${student_progress['firstName']} ${student_progress['lastName']}: $attempt');

                        // Check if any of the filtered attempts are accomplished
                        if (attempt['isAccomplished'] == true) {
                          print('Found Accomplished Attempt: ${attempt['isAccomplished']}');
                          isAccomplished = true;
                          break;  // If any is accomplished, no need to check further
                        }
                      }
                    }

                    // Return the widget for each student with an onTap to navigate
                    return GestureDetector(
                      onTap: () {
                        context.go(
                          '/teacher_home/student_progress/attempts',
                          extra: {
                            'studentId': student_progress['id'],  // Pass student ID
                            'firstName': student_progress['firstName'],  // Pass student's first name
                            'lastName': student_progress['lastName'],  // Pass student's last name
                            'lessonNumber': lessonNumber,  // Pass the lesson number
                            'difficulty': difficulty,  // Pass the difficulty level
                          },
                        );
                      },

                      child: BasicStudentProgressDetailsWidget(
                        itemNumber: index + 1,
                        lastName: student_progress["lastName"] ?? "None",
                        firstName: student_progress["firstName"] ?? "None",
                        difficulty: difficulty,
                        lessonNumber: lessonNumber,
                        isAccomplished: isAccomplished,  // Show accomplished status
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
