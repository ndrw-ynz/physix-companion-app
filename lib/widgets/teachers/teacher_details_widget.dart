import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TeacherDetailsWidget extends StatelessWidget {
  const TeacherDetailsWidget(
      {super.key,
      required this.itemNumber,
      required this.name,
      required this.email,
      required this.username,
      required this.password,
      required this.yearRegistered});

  final int itemNumber;
  final String name;
  final String email;
  final String username;
  final String password;
  final int yearRegistered;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(20.0),
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
                  Row(
                    children: <Widget>[
                      const SizedBox(width: 10),
                      Text("$itemNumber. ",
                          style: const TextStyle(
                              fontSize: 22.0, fontWeight: FontWeight.bold)),
                      const SizedBox(width: 10), // Space between texts
                      Text("$name",
                          style: const TextStyle(
                              fontSize: 18.0,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                  // Right side: Two Buttons
                  Row(
                    children: <Widget>[
                      IconButton(
                        onPressed: () =>
                            context.push("/admin_home/teachers/edit"),
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
                        Text("$email"),
                      ]),
                      const SizedBox(width: 10),
                      Row(children: <Widget>[
                        const Text(
                          "Username:",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 10),
                        Text("$username"),
                      ]),
                      const SizedBox(width: 10),
                      Row(children: <Widget>[
                        const Text(
                          "Password:",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 10),
                        Text("$password"),
                      ]),
                      const SizedBox(width: 10),
                      Row(children: <Widget>[
                        const Text("Year Registered:",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(width: 10),
                        Text("$yearRegistered"),
                      ])
                    ],
                  ))
            ]));
  }
}
