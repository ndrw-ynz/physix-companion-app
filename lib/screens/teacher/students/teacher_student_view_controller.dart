part of "teacher_student_view_screen.dart";

abstract class TeacherStudentViewController
    extends State<TeacherStudentViewScreen> {
  final _teacherQueryController = TextEditingController();
  List<String> years = [];

  String? selectedSection;
}
