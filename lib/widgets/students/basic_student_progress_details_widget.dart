import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BasicStudentProgressDetailsWidget extends StatefulWidget {
  const BasicStudentProgressDetailsWidget({
    super.key,
    required this.itemNumber,
    required this.lastName,
    required this.firstName,
    required this.difficulty,
    required this.lessonNumber,
    required this.isAccomplished,
  });

  final int itemNumber;
  final String lastName;
  final String firstName;
  final String difficulty;
  final int lessonNumber;
  final bool isAccomplished;

  @override
  State<BasicStudentProgressDetailsWidget> createState() =>
      _BasicStudentDetailsWidgetState();
}

class _BasicStudentDetailsWidgetState extends State<BasicStudentProgressDetailsWidget> {
  // Helper method to determine color based on difficulty
  Color _getDifficultyColor(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case "easy":
        return Colors.green;
      case "medium":
        return Colors.orange;
      case "hard":
        return Colors.red;
      default:
        return Colors.black;
    }
  }

  // Helper method to determine color based on accomplishment
  Color _getStatusColor(bool isAccomplished) {
    return isAccomplished ? Colors.green : Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 2.0),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Row with Item Number, Full Name, Lesson Number, and Difficulty
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    "${widget.itemNumber}.",
                    style: const TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    "${widget.lastName}, ${widget.firstName}",
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Text(
                    "Lesson ${widget.lessonNumber}",
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 4.0),
                    decoration: BoxDecoration(
                      color: _getDifficultyColor(widget.difficulty),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Text(
                      widget.difficulty,
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Row with Status
          Row(
            children: <Widget>[
              const Text(
                "Status:",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(width: 10),
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                decoration: BoxDecoration(
                  color: _getStatusColor(widget.isAccomplished),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Text(
                  widget.isAccomplished ? "Accomplished" : "Not Accomplished",
                  style: const TextStyle(
                    fontSize: 14.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

