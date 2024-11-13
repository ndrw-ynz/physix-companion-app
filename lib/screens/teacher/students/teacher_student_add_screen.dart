import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:physix_companion_app/commons.dart';
import 'package:physix_companion_app/widgets/students/student_form_widget.dart';

part 'teacher_student_add_controller.dart';

class TeacherStudentAddScreen extends StatefulWidget {
  const TeacherStudentAddScreen({super.key});

  @override
  State<TeacherStudentAddScreen> createState() =>
      _TeacherStudentAddScreenState();
}

class _TeacherStudentAddScreenState extends State<TeacherStudentAddScreen> {
  @override
  Widget build(BuildContext context) {
    return StudentFormWidget(
      formMode: FormMode.add,
      dateRegistered: Timestamp.now(),
    );
  }
}
