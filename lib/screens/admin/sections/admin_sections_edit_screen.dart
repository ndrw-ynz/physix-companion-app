import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:physix_companion_app/widgets/sections/section_form_widget.dart';

import '../../../commons.dart';

part "admin_sections_edit_controller.dart";

class AdminSectionsEditScreen extends StatefulWidget {
  const AdminSectionsEditScreen({super.key});

  @override
  State<AdminSectionsEditScreen> createState() =>
      _AdminSectionsEditScreenState();
}

class _AdminSectionsEditScreenState extends AdminSectionsEditController {
  @override
  Widget build(BuildContext context) {
    return SectionFormWidget(
      formMode: FormMode.edit,
      dateRegistered: Timestamp.now(),
    );
  }
}
