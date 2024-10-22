import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:physix_companion_app/widgets/teachers/teacher_form_widget.dart';

import '../../../commons.dart';

part 'admin_teacher_add_controller.dart';

class AdminTeacherAddScreen extends StatefulWidget {
  const AdminTeacherAddScreen({super.key});

  @override
  State<AdminTeacherAddScreen> createState() => _AdminTeacherAddScreenState();
}

class _AdminTeacherAddScreenState extends AdminTeacherAddController {
  @override
  Widget build(BuildContext context) {
    return TeacherFormWidget(
      formMode: FormMode.add,
      dateRegistered: Timestamp.now(),
    );
  }
}
