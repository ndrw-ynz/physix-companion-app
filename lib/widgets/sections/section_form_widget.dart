import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:physix_companion_app/utils.dart';

import '../../commons.dart';

class SectionFormWidget extends StatefulWidget {
  const SectionFormWidget(
      {super.key,
      required this.formMode,
      this.sectionName,
      this.teacherUid,
      required this.dateRegistered,
      this.sectionId});
  final FormMode formMode;
  final String? sectionId;
  final String? sectionName;
  final String? teacherUid;
  final Timestamp dateRegistered;

  @override
  State<SectionFormWidget> createState() => _SectionFormWidgetState();
}

class _SectionFormWidgetState extends SectionFormController {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("${_getModeTypeDesc()} Section"),
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
            Text("${_getModeTypeDesc()} Section",
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
                      "Stub Code",
                      style: TextStyle(fontSize: 16.0),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _sectionController,
                      style: const TextStyle(color: Colors.black),
                      decoration: const InputDecoration(
                        filled: true,
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      "Assigned Teacher",
                      style: TextStyle(fontSize: 16.0),
                    ),
                    const SizedBox(height: 10),
                    DropdownButton<String>(
                      value: selectedTeacherUid,
                      hint: const Text('Select an option'),
                      icon: const Icon(Icons.arrow_drop_down),
                      isExpanded: true,
                      dropdownColor: Colors.white54,
                      style: const TextStyle(color: Colors.black),
                      items: dropdownItems,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedTeacherUid = newValue!;
                        });
                      },
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      "Date Registered",
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
                    const SizedBox(height: 15),
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {
                            _showConfirmationDialog(
                                context, _sectionController.text);
                          },
                          style: ButtonStyle(),
                          child: Text("${_getModeTypeDesc()} Section")),
                    )
                  ],
                ))
          ]),
        )));
  }
}

abstract class SectionFormController extends State<SectionFormWidget> {
  final TextEditingController _sectionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  String? selectedTeacherUid;
  List<DropdownMenuItem<String>> dropdownItems = [];

  @override
  void initState() {
    super.initState();
    _dateController.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
    _fetchAllTeachers();

    if (widget.formMode == FormMode.edit) {
      // Initialize with existing data if in edit mode
      _sectionController.text = widget.sectionName ?? '';
      selectedTeacherUid = widget.teacherUid;
      _dateController.text = formatTimestamp(widget.dateRegistered);
    } else {
      _dateController.text = formatTimestamp(Timestamp.now());
    }
  }

  Future<void> _fetchAllTeachers() async {
    try {
      QuerySnapshot teacherSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('role', isEqualTo: 'teacher')
          .get();

      List<DropdownMenuItem<String>> items = teacherSnapshot.docs.map((doc) {
        String teacherName = "${doc['lastName']}, ${doc['firstName']}";
        String uid = doc['uid'];

        return DropdownMenuItem<String>(
          value: uid,
          child: Text(teacherName),
        );
      }).toList();

      // Update the dropdown items
      setState(() {
        dropdownItems = items;
      });
    } catch (e) {
      print("Error fetching teachers: $e");
    }
  }

  Future<void> _addSection() async {
    try {
      DocumentReference sectionRef =
          FirebaseFirestore.instance.collection('sections').doc();

      // Set section data
      await sectionRef.set({
        'sectionName': _sectionController.text.trim(),
        'teacherId': selectedTeacherUid!,
        'dateCreated': FieldValue.serverTimestamp(),
      });

      print("Section added successfully!");
    } catch (e) {
      print("Error adding section: $e");
    }
  }

  Future<void> _editSection() async {
    try {
      // Reference to the existing section document using sectionId
      DocumentReference sectionRef = FirebaseFirestore.instance
          .collection('sections')
          .doc(widget.sectionId);

      // Update the section data
      await sectionRef.update({
        'sectionName': _sectionController.text.trim(),
        'teacherId': selectedTeacherUid!,
        'dateModified': FieldValue.serverTimestamp(), // Update modified date
      });

      print("Section updated successfully!");
    } catch (e) {
      print("Error updating section: $e");
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

  void _showConfirmationDialog(BuildContext context, String stubCode) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('${_getModeTypeDesc()} Section'),
          content:
              Text('Are you sure you want to ${_getModeTypeDesc()} $stubCode?'),
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
                  _addSection();
                } else if (widget.formMode == FormMode.edit) {
                  _editSection();
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

  void _showAddSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Section ${_getModeTypeDesc()}ed Successfully'),
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
