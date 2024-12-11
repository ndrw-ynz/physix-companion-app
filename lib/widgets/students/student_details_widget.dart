import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../utils.dart';

class StudentDetailsWidget extends StatefulWidget {
  const StudentDetailsWidget(
      {super.key,
      required this.itemNumber,
      required this.uid,
      required this.lastName,
      required this.firstName,
      required this.email,
      required this.username,
      required this.sectionId,
      required this.sectionName,
      required this.dateCreated,
      this.status});

  final int itemNumber;
  final String uid;
  final String lastName;
  final String firstName;
  final String email;
  final String username;
  final String sectionId;
  final String sectionName;
  final Timestamp dateCreated;
  final bool? status;

  @override
  State<StudentDetailsWidget> createState() => _StudentDetailsWidgetState();
}

class _StudentDetailsWidgetState extends State<StudentDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 2.0),
            borderRadius: BorderRadius.circular(10.0)),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          const SizedBox(width: 10),
                          Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: (widget.status ?? false)
                                  ? Colors.green
                                  : Colors.red,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            (widget.status ?? false) ? "Active" : "Inactive",
                            style: TextStyle(
                              color: (widget.status ?? false)
                                  ? Colors.green
                                  : Colors.red,
                              fontSize: 14.0,
                            ),
                          ),
                        ],
                      ),
                      // Second Row: Item Number and Name
                      Row(
                        children: <Widget>[
                          const SizedBox(width: 10),
                          Text("${widget.itemNumber}. ",
                              style: const TextStyle(
                                  fontSize: 22.0, fontWeight: FontWeight.bold)),
                          const SizedBox(width: 10),
                          Text("${widget.lastName}, ${widget.firstName}",
                              style: const TextStyle(
                                  fontSize: 18.0,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  ),
                  // Right side: Two Buttons
                  Row(
                    children: <Widget>[
                      IconButton(
                        onPressed: () =>
                            context.push("/teacher_home/students/edit", extra: {
                          "uid": widget.uid,
                          "firstName": widget.firstName,
                          "lastName": widget.lastName,
                          "email": widget.email,
                          "sectionId": widget.sectionId,
                          "dateCreated": widget.dateCreated,
                          "status": widget.status ?? false,
                        }),
                        icon: const Icon(Icons.edit),
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Wrap(
                          direction: Axis.horizontal,
                          alignment: WrapAlignment.start,
                          children: <Widget>[
                            const Text(
                              "Email:",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 10),
                            Text(widget.email),
                          ]),
                      const SizedBox(width: 10),
                      Wrap(
                          direction: Axis.horizontal,
                          alignment: WrapAlignment.start,
                          children: <Widget>[
                            const Text(
                              "Username:",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 10),
                            Text(widget.username),
                          ]),
                      const SizedBox(width: 10),
                      Wrap(
                          direction: Axis.horizontal,
                          alignment: WrapAlignment.start,
                          children: <Widget>[
                            const Text(
                              "Assigned Section:",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 10),
                            Text(widget.sectionName),
                          ]),
                      const SizedBox(width: 10),
                      Wrap(
                          direction: Axis.horizontal,
                          alignment: WrapAlignment.start,
                          children: <Widget>[
                            const Text("Date Registered:",
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            const SizedBox(width: 10),
                            Text(formatTimestamp(widget.dateCreated)),
                          ])
                    ],
                  ))
            ]));
  }
}
