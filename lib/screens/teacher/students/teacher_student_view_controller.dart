part of "teacher_student_view_screen.dart";

abstract class TeacherStudentViewController
    extends State<TeacherStudentViewScreen> {
  final TextEditingController _studentQueryController = TextEditingController();
  List<Map<String, dynamic>> studentList = [];
  List<Map<String, dynamic>> filteredList = [];
  Map<String, String> sectionIdToName = {
  }; // Map to hold sectionId to sectionName mapping
  List<String> sections = [];
  String? selectedSection;
  List<String> teacherSectionIds = [
  ]; // Store section IDs for the logged-in teacher

  @override
  void initState() {
    super.initState();
    _gatherSections();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _gatherSections(); // Ensure sections are fetched when the screen is revisited
  }

  Future<void> _fetchAllStudents() async {
    try {
      if (teacherSectionIds.isNotEmpty) {
        QuerySnapshot snapshot = await FirebaseFirestore.instance
            .collection('students')
            .where('sectionId', whereIn: teacherSectionIds)
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
        _filterStudentSearch(); // Initial filtering for search input
      } else {
        print("No sections found for the current teacher.");
      }
    } catch (e) {
      print("Error fetching students: $e");
    }
  }

  void _filterStudentSearch() {
    setState(() {
      filteredList = studentList.where((student) {
        String fullName = "${student['firstName']} ${student['lastName']}"
            .toLowerCase();
        bool matchesSearch = fullName.contains(
            _studentQueryController.text.trim().toLowerCase());

        return matchesSearch;
      }).where((student) {
        String sectionId = student['sectionId'].toString();
        bool matchesSection = selectedSection == null ||
            sectionIdToName[sectionId] == selectedSection;
        return matchesSection;
      }).toList();
    });
  }

  Future<void> _gatherSections() async {
    Set<String> uniqueSections = {}; // Set to hold unique section names
    Map<String, String> sectionIdToNameMap = {
    }; // Map to store sectionId to sectionName mapping

    try {
      String? teacherId = FirebaseAuth.instance.currentUser?.uid;

      QuerySnapshot sectionSnapshot = await FirebaseFirestore.instance
          .collection('sections')
          .where('teacherId', isEqualTo: teacherId)
          .get();

      // Clear previous sections and sectionIdToName mapping
      uniqueSections.clear();
      sectionIdToNameMap.clear();
      teacherSectionIds.clear();

      for (var doc in sectionSnapshot.docs) {
        final data = doc.data() as Map<String, dynamic>?;

        if (data != null && data.containsKey("sectionName")) {
          String sectionId = doc.id; // This is the section ID
          String sectionName = data["sectionName"].toString();
          uniqueSections.add(sectionName);
          sectionIdToNameMap[sectionId] = sectionName;
          teacherSectionIds.add(sectionId); // Collect section IDs
        }
      }

      setState(() {
        sections = uniqueSections.toList();
        selectedSection = sections.isNotEmpty ? sections[0] : null;
        sectionIdToName = sectionIdToNameMap;
      });

      if (teacherSectionIds.isNotEmpty) {
        await _fetchAllStudents();
      } else {
        print("No sections found for the current teacher.");
      }
    } catch (e) {
      print("Error fetching sections: $e");
    }
  }
}
