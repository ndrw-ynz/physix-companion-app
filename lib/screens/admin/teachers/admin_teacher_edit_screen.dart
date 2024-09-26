import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:physix_companion_app/widgets/teachers/teacher_form_widget.dart';

import '../../../commons.dart';

part "admin_teacher_edit_controller.dart";

class AdminTeacherEditScreen extends StatefulWidget {
  const AdminTeacherEditScreen({super.key});

  @override
  State<AdminTeacherEditScreen> createState() => _AdminTeacherEditScreenState();
}

class _AdminTeacherEditScreenState extends State<AdminTeacherEditScreen> {
  @override
  Widget build(BuildContext context) {
    return TeacherFormWidget(
      formMode: FormMode.edit,
      dateRegistered: Timestamp.now(),
    );
  }
}
