import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../commons.dart';
import '../../utils.dart';

class StudentFormWidget extends StatefulWidget {
  const StudentFormWidget(
      {super.key,
        required this.formMode,
        this.uid,
        this.firstName,
        this.lastName,
        this.email,
        this.sectionId,
        this.dateCreated});
  final FormMode formMode;
  final String? uid;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? sectionId;
  final Timestamp? dateCreated;

  @override
  State<StudentFormWidget> createState() => _StudentFormWidgetState();
}

class _StudentFormWidgetState extends StudentFormController {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("${_getModeTypeDesc()} Student"),
            elevation: 0,
            backgroundColor: Colors.white,
            shape: const Border(
              bottom: BorderSide(color: Colors.black, width: 2.0), // Black outline
            )),
        body: SingleChildScrollView(  // Wrap the entire body in a SingleChildScrollView
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 20.0, left: 42.0, right: 42.0, bottom: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("${_getModeTypeDesc()} Student",
                      style: TextStyle(fontSize: 28.0)),
                  Container(
                    margin: const EdgeInsets.all(15.0),
                    padding: const EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 2.0),
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.grey[200]),
                    child: Column(
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
                            // Add helper text to show the requirement
                            helperText: 'Username must be at least 6 characters before @',
                          ),
                          // Add validation
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Email is required';
                            }

                            // Check if email contains @ and validate username length
                            int atIndex = value.indexOf('@');
                            if (atIndex == -1) {
                              return 'Invalid email format';
                            }

                            String username = value.substring(0, atIndex);
                            if (username.length < 6) {
                              return 'Username must be at least 6 characters';
                            }

                            return null;
                          },
                          // Enable auto-validation
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          "Section",
                          style: TextStyle(fontSize: 16.0),
                        ),
                        const SizedBox(height: 10),
                        DropdownButton<String>(
                          value: selectedSectionId,
                          hint: const Text('Select an option'),
                          icon: const Icon(Icons.arrow_drop_down),
                          isExpanded: true,
                          dropdownColor: Colors.white54,
                          style: const TextStyle(color: Colors.black),
                          items: dropdownSectionItems,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedSectionId = newValue!;
                            });
                          },
                        ),
                        const SizedBox(height: 20),
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
                              child: Text("${_getModeTypeDesc()} Student")),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}


abstract class StudentFormController extends State<StudentFormWidget> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  String? selectedSectionId;
  List<DropdownMenuItem<String>> dropdownSectionItems = [];
  String? studentUid;


  @override
  void initState() {
    super.initState();

    // Print uid to track its value
    studentUid = widget.uid;
    print("Initial UID: ${widget.uid}");

    // Initialize the date controller with the current date
    _dateController.text = DateFormat('yyyy-MM-dd').format(DateTime.now());

    _fetchAllSections();

    if (widget.formMode == FormMode.edit) {
      // Ensure the uid isn't getting changed unintentionally
      print("Editing student with UID: ${widget.uid}");

      // Initialize with existing data if in edit mode
      _firstNameController.text = widget.firstName ?? '';
      _lastNameController.text = widget.lastName ?? '';
      _emailController.text = widget.email ?? '';
      selectedSectionId = widget.sectionId;

      // Safely format dateCreated (now nullable)
      if (widget.dateCreated != null) {
        _dateController.text = formatTimestamp(widget.dateCreated!);
      } else {
        _dateController.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
      }
    } else {
      // For add mode, ensure the date is set properly and uid remains constant
      _dateController.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
    }
  }



  Future<void> _fetchAllSections() async {
    try {
      QuerySnapshot sectionSnapshot =
          await FirebaseFirestore.instance.collection('sections').get();

      List<DropdownMenuItem<String>> items = sectionSnapshot.docs.map((doc) {
        String sectionName = doc['sectionName'];

        return DropdownMenuItem<String>(
          value: doc.id,
          child: Text(sectionName),
        );
      }).toList();

      // Update the dropdown items
      setState(() {
        dropdownSectionItems = items;
      });
    } catch (e) {
      print("Error fetching sections: $e");
    }
  }

  String _getModeTypeDesc() {
    String result;
    switch (widget.formMode){
      case FormMode.add:
        result = "Add";
        break;
      case FormMode.edit:
        result = "Edit";
        break;
    }
    return result;
  }

  void _showConfirmationDialog(BuildContext context, String studentName) {
    // Validate email before showing confirmation
    String email = _emailController.text;
    int atIndex = email.indexOf('@');
    if (atIndex < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Username in email must be at least 6 characters long'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('${_getModeTypeDesc()} Student'),
          content: Text(
              'Are you sure you want to ${_getModeTypeDesc()} $studentName?'),
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
                  _addStudentAccount();
                } else if (widget.formMode == FormMode.edit) {
                  _editStudentAccount();
                }
                Navigator.of(context).pop();
                _showSuccessDialog(context);
              },
              child: Text(_getModeTypeDesc()),
            ),
          ],
        );
      },
    );
  }

  Future<void> _addStudentAccount() async {
    try {
      // Save current teacher credentials before adding a student
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        print("Error: No teacher currently logged in.");
        return;
      }

      // Fetch the teacher's email and password
      String teacherEmail = currentUser.email!;
      String teacherPassword = await _getTeacherPassword(currentUser.uid);

      // Create the student account
      UserCredential studentCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: extractUsername(_emailController.text.trim()),  // Example username-based password generator
      );

      String studentUid = studentCredential.user!.uid;

      // Save student data in Firestore
      await FirebaseFirestore.instance.collection('students').doc(studentUid).set({
        'uid': studentUid,
        'email': _emailController.text.trim(),
        'firstName': _firstNameController.text.trim(),
        'lastName': _lastNameController.text.trim(),
        'username': _emailController.text.trim(),
        'password': extractUsername(_emailController.text.trim()), // DO NOT store plain passwords
        'dateCreated': FieldValue.serverTimestamp(),
        'sectionId': selectedSectionId,
      });

      print("Student account created successfully!");

      // Re-login the teacher
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: teacherEmail,
        password: teacherPassword,
      );

      print("Teacher re-logged in successfully!");
    } catch (e) {
      print("Error adding student or re-logging teacher: $e");
    }
  }



  Future<void> _editStudentAccount() async {
    if (studentUid == null) {
      print("Error: No student UID provided");
      return;
    }

    // Store teacher's credentials
    User? currentTeacher = FirebaseAuth.instance.currentUser;
    if (currentTeacher == null) {
      print("Error: No teacher currently logged in.");
      return;
    }

    String teacherEmail = currentTeacher.email!;
    String teacherPassword;
    try {
      teacherPassword = await _getTeacherPassword(currentTeacher.uid); // Retrieve the teacher's password
    } catch (e) {
      print("Error fetching teacher password: $e");
      return;
    }

    try {
      // Fetch current student data from Firestore
      DocumentSnapshot studentDoc = await FirebaseFirestore.instance
          .collection('students')
          .doc(studentUid)
          .get();

      if (!studentDoc.exists) {
        print("Error: Student document does not exist.");
        return;
      }
      String currentEmail = studentDoc.get('email');
      String studentPassword = studentDoc.get('password'); // Fetch stored password

      // Re-authenticate the student using their current credentials
      UserCredential studentCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: currentEmail, password: studentPassword);

      User? studentUser = studentCredential.user;
      if (studentUser == null) {
        print("Error: Unable to fetch student user.");
        return;
      }

      // Update email in Firebase Authentication
      await studentUser.updateEmail(_emailController.text.trim());
      print("Email updated in Firebase Auth!");

      // Update Firestore with the new email and new dateCreated
      await FirebaseFirestore.instance
          .collection('students')
          .doc(studentUid)
          .update({
        'email': _emailController.text.trim(),
        'firstName': _firstNameController.text.trim(),
        'lastName': _lastNameController.text.trim(),
        'sectionId': selectedSectionId!,
        'dateCreated': FieldValue.serverTimestamp(), // Set the current timestamp when edited
      });
      print("Student account updated successfully in Firestore!");

      // Re-login as the teacher to maintain session
      await FirebaseAuth.instance.signOut(); // Ensure a clean sign-in process
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: teacherEmail,
        password: teacherPassword,
      );
      print("Teacher re-logged in successfully!");

    } catch (e) {
      print("Error editing student account: $e");
    }
  }



  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Student ${_getModeTypeDesc()}ed Successfully'),
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

  Future<String> _getTeacherPassword(String uid) async {
    try {
      DocumentSnapshot teacherDoc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
      if (teacherDoc.exists) {
        return teacherDoc.get('password'); // Assumes password is stored in plaintext
      } else {
        throw Exception("Teacher document does not exist.");
      }
    } catch (e) {
      print("Error fetching teacher password: $e");
      throw Exception("Unable to fetch teacher password.");
    }
  }
}

