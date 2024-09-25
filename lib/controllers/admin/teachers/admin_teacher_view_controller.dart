part of '../../../screens/admin/teachers/admin_teacher_view_screen.dart';

abstract class AdminTeacherViewController
    extends State<AdminTeacherViewScreen> {
  String? selectedYear;
  List<String> years = [];

  @override
  void initState() {
    super.initState();
    // Generate a list of years from the current year to a specified future year
    int currentYear = DateTime.now().year;
    for (int i = 0; i <= 10; i++) {
      years.add((currentYear + i).toString());
    }
  }
}
