import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../commons.dart';
import '../../utils.dart';

class StudentFormWidget extends StatefulWidget {
  const StudentFormWidget(
      {super.key,
      required this.formMode,
      this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.sectionId,
      required this.dateRegistered});
  final FormMode formMode;
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? sectionId;
  final Timestamp dateRegistered;

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
              bottom:
                  BorderSide(color: Colors.black, width: 2.0), // Black outline
            )),
        body: Center(
            child: Padding(
          padding: const EdgeInsets.only(
              top: 20.0, left: 42.0, right: 42.0, bottom: 20.0),
          child: Column(children: <Widget>[
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
                ))
          ]),
        )));
  }
}

abstract class StudentFormController extends State<StudentFormWidget> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  String? selectedSectionId;
  List<DropdownMenuItem<String>> dropdownSectionItems = [];

  @override
  void initState() {
    super.initState();
    _dateController.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
    _fetchAllSections();

    if (widget.formMode == FormMode.edit) {
      // Initialize with existing data if in edit mode
      _firstNameController.text = widget.firstName ?? '';
      _lastNameController.text = widget.lastName ?? '';
      _emailController.text = widget.email ?? '';
      selectedSectionId = widget.sectionId;
      _dateController.text = formatTimestamp(widget.dateRegistered);
    } else {
      _dateController.text = formatTimestamp(Timestamp.now());
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
    return widget.formMode == FormMode.add ? "Add" : "Edit";
  }

  void _showConfirmationDialog(BuildContext context, String studentName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('${_getModeTypeDesc()} Teacher'),
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
                  // _addStudentAccount();
                } else if (widget.formMode == FormMode.edit) {
                  // _editStudentAccount();
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
}
