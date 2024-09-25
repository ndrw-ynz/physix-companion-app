import 'package:flutter/material.dart';
import 'package:physix_companion_app/widgets/sections/section_form_widget.dart';

import '../../../commons.dart';

part "../../../controllers/admin/sections/admin_sections_edit_controller.dart";

class AdminSectionsEditScreen extends StatefulWidget {
  const AdminSectionsEditScreen({super.key});

  @override
  State<AdminSectionsEditScreen> createState() =>
      _AdminSectionsEditScreenState();
}

class _AdminSectionsEditScreenState extends AdminSectionsEditController {
  @override
  Widget build(BuildContext context) {
    return const SectionFormWidget(formMode: FormMode.edit);
  }
}
