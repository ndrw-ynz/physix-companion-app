part of "teacher_student_view_screen.dart";

abstract class TeacherStudentViewController
    extends State<TeacherStudentViewScreen> {
  final _studentQueryController = TextEditingController();

  List<Map<String, dynamic>> studentList = [];
  List<Map<String, dynamic>> filteredStudentList = [];
  Map<String, String> sectionIds = {};

  List<DropdownMenuItem<String>> dropdownSectionItems = [];
  String? selectedSectionId;

  @override
  void initState() {
    super.initState();

    _fetchAllSections();
    _fetchAllStudents();
    _listenToCollectionChanges();
  }

  void _listenToCollectionChanges() {
    FirebaseFirestore.instance
        .collection('students')
        .snapshots()
        .listen((QuerySnapshot snapshot) {
      _fetchAllStudents();
    });
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
        sectionIds[sectionId] = sectionName;

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

  Future<void> _fetchAllStudents() async {
    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('students').get();

      setState(() {
        studentList = snapshot.docs.map((doc) {
          return {
            'id': doc.id,
            ...doc.data() as Map<String, dynamic>,
          };
        }).toList();
      });

      filteredStudentList = List.from(studentList);
    } catch (e) {
      print("Error fetching all teachers: $e");
    }
  }

  void _filterStudentSearch() {
    // Filters search from textField and selectedYear
    setState(() {
      filteredStudentList = studentList.where((student) {
        String studentName =
            "${student['firstName']} ${student['lastName']}".toLowerCase();
        return studentName
            .contains(_studentQueryController.text.trim().toLowerCase());
      }).where((student) {
        return student["sectionId"] == selectedSectionId;
      }).toList();
    });
  }
}
