import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:physix_companion_app/utils.dart';

import '../../commons.dart';

class TeacherFormWidget extends StatefulWidget {
  const TeacherFormWidget({
    super.key,
    required this.formMode,
    this.uid,
    this.firstName,
    this.lastName,
    this.email,
    required this.dateRegistered,
  });
  final FormMode formMode;
  final String? uid;
  final String? firstName;
  final String? lastName;
  final String? email;
  final Timestamp dateRegistered;

  @override
  State<TeacherFormWidget> createState() => _TeacherFormWidgetState();
}

class _TeacherFormWidgetState extends TeacherFormController {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("${_getModeTypeDesc()} Teacher"),
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
          child: Column(children: <Widget>[
            Text("${_getModeTypeDesc()} Teacher",
                style: TextStyle(fontSize: 28.0)),
            Container(
                margin: const EdgeInsets.all(15.0),
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 2.0),
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.grey[200]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      "First Name",
                      style: TextStyle(fontSize: 16.0),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _firstNameController,
                      style: const TextStyle(color: Colors.black),
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Last Name",
                      style: TextStyle(fontSize: 16.0),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _lastNameController,
                      style: const TextStyle(color: Colors.black),
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Email",
                      style: TextStyle(fontSize: 16.0),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _emailController,
                      style: const TextStyle(color: Colors.black),
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Year Registered",
                      style: TextStyle(fontSize: 16.0),
                    ),
                    TextFormField(
                      controller: _dateController,
                      style: const TextStyle(color: Colors.black),
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.grey,
                        border: OutlineInputBorder(),
                      ),
                      readOnly: true,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Username and Password are auto-generated*",
                      style: TextStyle(
                          fontSize: 12.0,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 15),
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {
                            _showConfirmationDialog(context,
                                "${_firstNameController.text} ${_lastNameController.text}");
                          },
                          style: ButtonStyle(),
                          child: Text("${_getModeTypeDesc()} Teacher")),
                    )
                  ],
                ))
          ]),
        )));
  }
}

abstract class TeacherFormController extends State<TeacherFormWidget> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Set the initial value of the date to today's date
    _dateController.text = DateFormat('yyyy-MM-dd').format(DateTime.now());

    if (widget.formMode == FormMode.edit) {
      // Initialize with existing data if in edit mode
      _firstNameController.text = widget.firstName ?? '';
      _lastNameController.text = widget.lastName ?? '';
      _emailController.text = widget.email ?? '';
      _dateController.text = formatTimestamp(widget.dateRegistered);
    } else {
      // Set default values for add mode
      _dateController.text = formatTimestamp(Timestamp.now());
    }
  }

  String _getModeTypeDesc() {
    String result;
    switch (widget.formMode) {
      case FormMode.add:
        result = "Add";
        break;
      case FormMode.edit:
        result = "Edit";
        break;
    }
    return result;
  }

  void _showConfirmationDialog(BuildContext context, String teacherName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('${_getModeTypeDesc()} Teacher'),
          content: Text(
              'Are you sure you want to ${_getModeTypeDesc()} $teacherName?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (widget.formMode == FormMode.add) {
                  _addTeacherAccount();
                } else if (widget.formMode == FormMode.edit) {
                  _editTeacherAccount();
                }
                Navigator.of(context).pop();
                _showAddSuccessDialog(context);
              },
              child: Text(_getModeTypeDesc()),
            ),
          ],
        );
      },
    );
  }

  Future<void> _addTeacherAccount() async {
    // username - > firstname + lastname
    // password -> email head
    try {
      // Create user in Firebase Authentication
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _emailController.text.trim(),
              password: extractUsername(_emailController.text.trim()));
      // EXTRACT THE INFORMATION FROM PASSWORD

      String uid = userCredential.user!.uid;

      // Save additional teacher data in Firestore
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'uid': uid,
        'role': "teacher",
        'email': _emailController.text.trim(),
        'firstName': _firstNameController.text.trim(),
        'lastName': _lastNameController.text.trim(),
        'username': _emailController.text.trim(),
        'password': extractUsername(_emailController.text.trim()),
        'dateCreated': FieldValue.serverTimestamp(),
      });

      print("Teacher account created successfully!");
    } catch (e) {
      print("Error creating teacher account: $e");
    }
  }

  Future<void> _editTeacherAccount() async {
    if (widget.uid == null) {
      print("Error: No teacher uid provided");
      return;
    }

    try {
      // Update the teacher's data in Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.uid)
          .update({
        'firstName': _firstNameController.text.trim(),
        'lastName': _lastNameController.text.trim(),
        'email': _emailController.text.trim(),
        'username': _emailController.text.trim(),
        'dateRegistered': _dateController.text.trim(),
      });

      print("Teacher account updated successfully!");
    } catch (e) {
      print("Error updating teacher account: $e");
    }
  }

  void _showAddSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Teacher ${_getModeTypeDesc()}ed Successfully'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                context.pop();
              },
              child: const Text('Continue'),
            ),
          ],
        );
      },
    );
  }
}
