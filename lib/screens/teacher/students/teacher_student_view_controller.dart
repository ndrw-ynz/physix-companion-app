part of "teacher_student_view_screen.dart";

abstract class TeacherStudentViewController
    extends State<TeacherStudentViewScreen> {
  final TextEditingController _studentQueryController = TextEditingController();
  List<Map<String, dynamic>> studentList = [];
  List<Map<String, dynamic>> filteredList = [];
  Map<String, String> sectionIdToName = {};  // Map to hold sectionId to sectionName mapping
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
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('students')
          .get();

      setState(() {
        studentList = snapshot.docs.map((doc) {
          return {
            'id': doc.id,
            ...doc.data() as Map<String, dynamic>,
          };
        }).toList();
      });

      filteredList = List.from(studentList);
      _filterStudentSearch();  // Re-filter students after gathering sections
    } catch (e) {
      print("Error fetching all students: $e");
    }
  }

  void _filterStudentSearch() {
    setState(() {
      filteredList = studentList.where((student) {
        String fullName = "${student['firstName']} ${student['lastName']}".toLowerCase();
        bool matchesSearch = fullName.contains(_studentQueryController.text.trim().toLowerCase());

        return matchesSearch;
      }).where((student) {
        // Get the student sectionId
        String sectionId = student['sectionId'].toString();

        // Find the matching sectionId based on the selectedSection (section name)
        bool matchesSection = selectedSection != null && sectionIdToName[sectionId] == selectedSection;
        return matchesSection;
      }).toList();
    });
  }


  Future<void> _gatherSections() async {
    Set<String> uniqueSections = {};  // Set to hold unique section names
    Map<String, String> sectionIdToNameMap = {};  // Map to store sectionId to sectionName mapping

    try {
      String? teacherId = FirebaseAuth.instance.currentUser?.uid;

      QuerySnapshot sectionSnapshot = await FirebaseFirestore.instance
          .collection('sections')
          .where('teacherId', isEqualTo: teacherId)
          .get();

      for (var doc in sectionSnapshot.docs) {
        final data = doc.data() as Map<String, dynamic>?;
        if (data != null && data.containsKey("sectionName")) {
          String sectionId = doc.id;  // This is the subcollection name (sectionId)
          String sectionName = data["sectionName"].toString();  // The sectionName to display
          uniqueSections.add(sectionName);  // Add section name to set (avoids duplicates)
          sectionIdToNameMap[sectionId] = sectionName;  // Map sectionId to sectionName
        }
      }

      setState(() {
        sections = uniqueSections.toList();  // List of section names for display
        selectedSection = sections.isNotEmpty ? sections[0] : null;  // Select the first section as default
        sectionIdToName = sectionIdToNameMap;  // Store the mapping for future reference
      });

    } catch (e) {
      print("Error fetching sections: $e");
    }
  }
}