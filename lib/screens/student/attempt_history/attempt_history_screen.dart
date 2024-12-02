import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:physix_companion_app/widgets/students/attempt_history_widget.dart';

import '../../../utils.dart';

part "attempt_history_controller.dart";

class AttemptHistoryScreen extends StatefulWidget {
  const AttemptHistoryScreen({super.key});

  @override
  State<AttemptHistoryScreen> createState() => _AttemptHistoryScreenState();
}

class _AttemptHistoryScreenState extends AttemptHistoryController {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Game History List"),
          elevation: 0,
          backgroundColor: Colors.white,
          shape: const Border(
            bottom:
                BorderSide(color: Colors.black, width: 2.0), // Black outline
          )),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(
              top: 20.0, left: 42.0, right: 42.0, bottom: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
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
                      controller: _historyQueryController,
                      decoration: InputDecoration(
                        hintText: "Search",
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
                            setState(() {
                              _fetchAttemptHistory();
                            });
                          },
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    // Query parameters for searching
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Lesson Selection
                        Container(
                          padding: const EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: DropdownButton<String>(
                            value: selectedLesson,
                            icon: const Icon(Icons.arrow_downward),
                            elevation: 16,
                            items: lessons
                                .map<DropdownMenuItem<String>>((String lesson) {
                              return DropdownMenuItem<String>(
                                value: lesson,
                                child: Text(lesson),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedLesson = newValue!;
                              });
                            },
                            hint: const Text(
                              'Select Lesson',
                              style: TextStyle(
                                color: Color.fromARGB(255, 0, 0,
                                    0), // Change hint text color to black
                              ),
                            ),
                          ),
                        ),
                        // Difficulty
                        Container(
                          padding: const EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: DropdownButton<String>(
                            value: selectedDifficulty,
                            icon: const Icon(Icons.arrow_downward),
                            elevation: 16,
                            items: difficulties.map<DropdownMenuItem<String>>(
                                (String difficulty) {
                              return DropdownMenuItem<String>(
                                value: difficulty,
                                child: Text(difficulty),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedDifficulty = newValue!;
                              });
                            },
                            hint: const Text(
                              'Select Difficulty',
                              style: TextStyle(
                                color: Color.fromARGB(255, 0, 0,
                                    0), // Change hint text color to black
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12.0),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
              Expanded(
                child: ListView.builder(
                  itemCount: queryHistoryList.length,
                  itemBuilder: (context, index) {
                    return AttemptHistoryWidget(
                        attemptInfo: queryHistoryList[index]);
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
