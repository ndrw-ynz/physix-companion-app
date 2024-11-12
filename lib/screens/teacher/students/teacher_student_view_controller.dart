part of "teacher_student_view_screen.dart";

abstract class TeacherStudentViewController
    extends State<TeacherStudentViewScreen> {
  final TextEditingController _studentQueryController = TextEditingController();
  List<Map<String, dynamic>> studentList = [];
  List<Map<String, dynamic>> filteredList = [];
  List<String> sections = [];

  String? selectedSection;

  @override
  void initState() {
    super.initState();

    _fetchAllStudents();
    _gatherSections();
}

  Future<void> _fetchAllStudents() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('students').get();

      setState(() {
        studentList = snapshot.docs.map((doc) {
          return {
            'id': doc.id,
            ...doc.data() as Map<String, dynamic>,
          };
        }).toList();
      });

      filteredList = List.from(studentList);
    } catch (e) {
      print("Error fetching all students: $e");
    }
  }

  void _filterStudentSearch() {
    // Filters search from textField and selectedSection
    setState(() {
      filteredList = studentList.where((student) {
        String fullName =
            "${student['firstName']} ${student['lastName']}".toLowerCase();
        return fullName
            .contains(_studentQueryController.text.trim().toLowerCase());
      }).where((student) {
        String section = student['sectionId'].toString();
        return section == selectedSection;
      }).toList();
    });
  }

  Future<void> _gatherSections() async {
    Set<String> uniqueSections = {}; // Set to hold unique sections

    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('students').get();

      for (var doc in snapshot.docs) {
        final data = doc.data() as Map<String, dynamic>?; // Cast to a nullable Map
        if (data != null && data.containsKey("sectionId")) {
          String section = data["sectionId"].toString();
          uniqueSections.add(section); // Add to set (avoids duplicates)
        }
      }

      setState(() {
        sections = uniqueSections.toList(); // Convert set to list
        selectedSection = sections.isNotEmpty ? sections[0] : null; // Select the first section as default
      });
    } catch (e) {
      print("Error fetching sections: $e");
    }
  }

}
