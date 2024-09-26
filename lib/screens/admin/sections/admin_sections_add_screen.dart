import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:physix_companion_app/widgets/sections/section_form_widget.dart';

import '../../../commons.dart';

part "admin_sections_add_controller.dart";

class AdminSectionsAddScreen extends StatefulWidget {
  const AdminSectionsAddScreen({super.key});

  @override
  State<AdminSectionsAddScreen> createState() => _AdminSectionsAddScreenState();
}

class _AdminSectionsAddScreenState extends AdminSectionsAddController {
  @override
  Widget build(BuildContext context) {
    return SectionFormWidget(
      formMode: FormMode.add,
      dateRegistered: Timestamp.now(),
    );
  }
}
