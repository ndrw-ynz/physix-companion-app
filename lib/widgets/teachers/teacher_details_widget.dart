import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:physix_companion_app/utils.dart';

class TeacherDetailsWidget extends StatefulWidget {
  const TeacherDetailsWidget(
      {super.key,
      required this.itemNumber,
      required this.uid,
      required this.lastName,
      required this.firstName,
      required this.email,
      required this.username,
      required this.dateRegistered,
      required this.status});

  final int itemNumber;
  final String uid;
  final String lastName;
  final String firstName;
  final String email;
  final String username;
  final Timestamp dateRegistered;
  final bool? status;

  @override
  State<TeacherDetailsWidget> createState() => _TeacherDetailsWidgetState();
}

class _TeacherDetailsWidgetState extends State<TeacherDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
        height: 180,
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                      Row(
                        children: <Widget>[
                          const SizedBox(width: 10),
                          Text("${widget.itemNumber}. ",
                              style: const TextStyle(
                                  fontSize: 22.0, fontWeight: FontWeight.bold)),
                          const SizedBox(width: 10), // Space between texts
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
                            context.push("/admin_home/teachers/edit", extra: {
                          "uid": widget.uid,
                          "firstName": widget.firstName,
                          "lastName": widget.lastName,
                          "email": widget.email,
                          "dateRegistered": widget.dateRegistered,
                          "status": widget.status ?? false
                        }),
                        icon: const Icon(Icons.edit),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                        ),
                      )
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
                        const Text("Date Registered:",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(width: 10),
                        Text(formatTimestamp(widget.dateRegistered)),
                        //Text(yearRegistered.toDate().year.toString()),
                      ])
                    ],
                  ))
            ]));
  }
}
