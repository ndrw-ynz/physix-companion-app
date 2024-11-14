import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:physix_companion_app/commons.dart';
import 'package:physix_companion_app/widgets/students/student_form_widget.dart';

part 'teacher_student_edit_controller.dart';

class TeacherStudentEditScreen extends StatefulWidget {
  const TeacherStudentEditScreen({super.key});

  @override
  State<TeacherStudentEditScreen> createState() =>
      _TeacherStudentEditScreenState();
}

class _TeacherStudentEditScreenState extends State<TeacherStudentEditScreen> {
  @override
  Widget build(BuildContext context) {
    return StudentFormWidget(
      formMode: FormMode.edit,
      dateRegistered: Timestamp.now(),
    );
  }
}
