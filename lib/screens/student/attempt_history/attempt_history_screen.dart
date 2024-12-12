import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:physix_companion_app/widgets/students/attempt_history_widget.dart';

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
          title: const Text("Game History"),
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
                    // Query parameters for searching
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Lesson Selection
                        Container(
                          padding:
                              const EdgeInsets.fromLTRB(10.0, 2.5, 10.0, 2.5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5.0),
                            border: const Border.fromBorderSide(
                                BorderSide(color: Colors.black, width: 1.5)),
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
                                _fetchAttemptHistory();
                              });
                            },
                            hint: const Text(
                              'Select Lesson',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        // Difficulty
                        Container(
                          padding:
                              const EdgeInsets.fromLTRB(10.0, 2.5, 10.0, 2.5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5.0),
                              border: const Border.fromBorderSide(
                                  BorderSide(color: Colors.black, width: 1.5))),
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
                                _fetchAttemptHistory();
                              });
                            },
                            hint: const Text(
                              'Select Difficulty',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12.0),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        icon: const Icon(Icons.search, color: Colors.black),
                        label: const Text(
                          "Search",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          setState(() {
                            _fetchAttemptHistory();
                          });
                        },
                        iconAlignment: IconAlignment.start,
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Colors.white,
                          side:
                              const BorderSide(color: Colors.black, width: 1.5),
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12.0),
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
