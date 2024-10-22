import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../utils.dart';

class StudentDetailsWidget extends StatefulWidget {
  const StudentDetailsWidget(
      {super.key,
      required this.studentId,
      required this.lastName,
      required this.firstName,
      required this.email,
      required this.username,
      required this.password,
      required this.sectionId,
      required this.sectionName,
      required this.dateRegistered});
  final String studentId;
  final String lastName;
  final String firstName;
  final String email;
  final String username;
  final String password;
  final String sectionId;
  final String sectionName;
  final Timestamp dateRegistered;

  @override
  State<StudentDetailsWidget> createState() => _StudentDetailsWidgetState();
}

class _StudentDetailsWidgetState extends State<StudentDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(20.0),
        height: 200,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 2.0),
            borderRadius: BorderRadius.circular(10.0)),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      // Space between texts
                      const SizedBox(width: 25),
                      Text("${widget.lastName}, ${widget.firstName}",
                          style: const TextStyle(
                              fontSize: 16.0,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                  // Right side: Two Buttons
                  Row(
                    children: <Widget>[
                      IconButton(
                        onPressed: () =>
                            context.push("/teacher_home/students/edit", extra: {
                          "id": widget.studentId,
                          "firstName": widget.firstName,
                          "lastName": widget.lastName,
                          "email": widget.email,
                          "sectionId": widget.sectionId,
                          "dateRegistered": widget.dateRegistered,
                        }),
                        icon: const Icon(Icons.edit),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                        ),
                      ),
                      const SizedBox(width: 10), // Space between buttons
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.delete),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                  margin: const EdgeInsets.all(15.0),
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.grey[200]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(children: <Widget>[
                        const Text(
                          "Email:",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 10),
                        Text("${widget.email}"),
                      ]),
                      const SizedBox(width: 10),
                      Row(children: <Widget>[
                        const Text(
                          "Username:",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 10),
                        Text("${widget.username}"),
                      ]),
                      const SizedBox(width: 10),
                      Row(children: <Widget>[
                        const Text(
                          "Password:",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 10),
                        Text("${widget.password}"),
                      ]),
                      const SizedBox(width: 10),
                      Row(children: <Widget>[
                        const Text(
                          "Assigned Section:",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 10),
                        Text("${widget.sectionName}"),
                      ]),
                      const SizedBox(width: 10),
                      Row(children: <Widget>[
                        const Text("Date Registered:",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(width: 10),
                        Text(formatTimestamp(widget.dateRegistered)),
                      ])
                    ],
                  ))
            ]));
  }
}
