import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
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
      this.dateCreated,
      this.status});
  final FormMode formMode;
  final String? uid;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? sectionId;
  final Timestamp? dateCreated;
  final bool? status;

  @override
  State<StudentFormWidget> createState() => _StudentFormWidgetState();
}

class _StudentFormWidgetState extends StudentFormController {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("${_getFormTypeDesc()} Student"),
            elevation: 0,
            backgroundColor: Colors.white,
            shape: const Border(
              bottom:
                  BorderSide(color: Colors.black, width: 2.0), // Black outline
            )),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 20.0, left: 42.0, right: 42.0, bottom: 20.0),
              child: Column(
                children: <Widget>[
                  Text("${_getFormTypeDesc()} Student",
                      style: const TextStyle(fontSize: 28.0)),
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
                        // First Name Field
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

                        // Last Name Field
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

                        // Email Field
                        if (widget.formMode == FormMode.add)
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
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
                                    helperText:
                                        'Username must be at least 6 characters before @',
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

                                    String username =
                                        value.substring(0, atIndex);
                                    if (username.length < 6) {
                                      return 'Username must be at least 6 characters';
                                    }

                                    return null;
                                  },
                                  // Enable auto-validation
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                ),
                                const SizedBox(height: 20),
                              ]),

                        // Section Field
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
                          style: const TextStyle(color: Colors.black),
                          items: dropdownSectionItems,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedSectionId = newValue!;
                            });
                          },
                        ),
                        const SizedBox(height: 20),

                        // Year Registered Field
                        if (widget.formMode == FormMode.add)
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
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
                            ],
                          ),

                        // Status Select
                        const Text(
                          "Status",
                          style: TextStyle(fontSize: 16.0),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    studentStatus = true;
                                  });
                                },
                                child: Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  decoration: BoxDecoration(
                                    color: studentStatus == true
                                        ? Colors.green
                                        : Colors.white,
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Active',
                                      style: TextStyle(
                                        color: studentStatus == true
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    studentStatus = false;
                                  });
                                },
                                child: Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  decoration: BoxDecoration(
                                    color: studentStatus == false
                                        ? Colors.red
                                        : Colors.white,
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Inactive',
                                      style: TextStyle(
                                        color: studentStatus == false
                                            ? Colors.white
                                            : Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
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
                              child: Text("${_getFormTypeDesc()} Student")),
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
  bool? studentStatus;

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
      studentStatus = widget.status;

      // Safely format dateCreated (now nullable)
      if (widget.dateCreated != null) {
        _dateController.text = formatTimestamp(widget.dateCreated!);
      } else {
        _dateController.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
      }
    } else {
      // For add mode, ensure the date is set properly and uid remains constant
      _dateController.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
      studentStatus = true;
    }
  }

  Future<void> _fetchAllSections() async {
    try {
      QuerySnapshot sectionSnapshot = await FirebaseFirestore.instance
          .collection('sections')
          .where("teacherId", isEqualTo: FirebaseAuth.instance.currentUser?.uid)
          .get();

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

  String _getFormTypeDesc() {
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
          title: Text('${_getFormTypeDesc()} Student'),
          content: Text(
              'Are you sure you want to ${_getFormTypeDesc().toLowerCase()} $studentName?'),
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
              child: Text(_getFormTypeDesc()),
            ),
          ],
        );
      },
    );
  }

  Future<void> _addStudentAccount() async {
    try {
      FirebaseApp app = await Firebase.initializeApp(
          name: 'Secondary', options: Firebase.app().options);

      UserCredential studentCredential =
          await FirebaseAuth.instanceFor(app: app)
              .createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: extractUsername(_emailController.text.trim()),
      );

      String studentUid = studentCredential.user!.uid;

      // Save student data in Firestore
      await FirebaseFirestore.instance
          .collection('students')
          .doc(studentUid)
          .set({
        'email': _emailController.text.trim(),
        'firstName': _firstNameController.text.trim(),
        'lastName': _lastNameController.text.trim(),
        'username': _emailController.text.trim(),
        'dateCreated': FieldValue.serverTimestamp(),
        'sectionId': selectedSectionId,
        'status': studentStatus ?? true,
      });

      await app.delete();
      print("Student account created successfully!");
    } catch (e) {
      print("Error adding student or re-logging teacher: $e");
    }
  }

  Future<void> _editStudentAccount() async {
    if (studentUid == null) {
      print("Error: No student UID provided");
      return;
    }

    try {
      // Update Firestore with the new email and new dateCreated
      await FirebaseFirestore.instance
          .collection('students')
          .doc(studentUid)
          .update({
        'firstName': _firstNameController.text.trim(),
        'lastName': _lastNameController.text.trim(),
        'sectionId': selectedSectionId!,
        'status': studentStatus ?? true,
      });
      print("Student account updated successfully in Firestore!");
    } catch (e) {
      print("Error editing student account: $e");
    }
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Student ${_getFormTypeDesc()}ed Successfully'),
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
