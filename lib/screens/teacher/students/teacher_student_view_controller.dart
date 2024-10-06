part of "teacher_student_view_screen.dart";

abstract class TeacherStudentViewController
    extends State<TeacherStudentViewScreen> {
  final _teacherQueryController = TextEditingController();

  String? selectedSectionId;
  List<DropdownMenuItem<String>> dropdownSectionItems = [];

  @override
  void initState() {
    super.initState();

    _fetchAllSections();
  }

  Future<void> _fetchAllSections() async {
    try {
      Map<String, dynamic>? teacherProfile = await getUserProfile();

      QuerySnapshot sectionSnapshot = await FirebaseFirestore.instance
          .collection('sections')
          .where("teacherId", isEqualTo: teacherProfile!["id"])
          .get();

      List<DropdownMenuItem<String>> items = sectionSnapshot.docs.map((doc) {
        String sectionId = doc.id;
        String sectionName = doc['sectionName'];

        return DropdownMenuItem<String>(
          value: sectionId,
          child: Text(sectionName),
        );
      }).toList();

      // Update the dropdown items
      setState(() {
        dropdownSectionItems = items;
        selectedSectionId = dropdownSectionItems.isNotEmpty
            ? dropdownSectionItems[0].value
            : null;
      });
    } catch (e) {
      print("Error fetching sections: $e");
    }
  }
}
