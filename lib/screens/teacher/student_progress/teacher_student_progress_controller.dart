part of "teacher_student_progress_screen.dart";

abstract class TeacherStudentProgressController
    extends State<TeacherStudentProgressScreen> {
  final TextEditingController _studentQueryController = TextEditingController();
  List<Map<String, dynamic>> studentList = [];
  List<Map<String, dynamic>> filteredList = [];
  Map<String, String> sectionIdToName = {}; // Map to hold sectionId to sectionName mapping
  List<String> sections = [];
  String? selectedSection;
  List<String> teacherSectionIds = []; // Store section IDs for the logged-in teacher
  int? selectedLessonNumber; // Holds the selected lesson number
  List<Map<String, dynamic>> lessonAttempts = []; // Holds filtered attempts
  String? selectedDifficulty; // Holds the selected difficulty

  @override
  void initState() {
    super.initState();
    _gatherSections(); // Fetch sections and students
    selectedLessonNumber = 1; // Default to Lesson 1
    selectedDifficulty = "Easy"; // Default to Easy
    _fetchLessonAttempts(); // Fetch attempts for the default selection
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _gatherSections(); // Ensure sections are fetched when the screen is revisited
  }

  Future<void> _fetchAllStudents() async {
    try {
      // Fetch lesson attempts before filtering students
      await _fetchLessonAttempts();

      if (teacherSectionIds.isNotEmpty) {
        QuerySnapshot snapshot = await FirebaseFirestore.instance
            .collection('students')
            .where('sectionId', whereIn: teacherSectionIds)
            .get();

        setState(() {
          studentList = snapshot.docs.map((doc) {
            final data = doc.data() as Map<String, dynamic>;

            return {
              'id': doc.id,
              ...data,
              'lessonNumber': data['lessonNumber'] is String
                  ? int.tryParse(data['lessonNumber']) ?? 0
                  : (data['lessonNumber'] ?? 0),
            };
          }).toList();
        });

        filteredList = List.from(studentList);
        _filterStudentSearch();
      } else {
        print("No sections found for the current teacher.");
      }
    } catch (e) {
      print("Error fetching students: $e");
    }
  }

  void _filterStudentSearch() {
    setState(() {
      String query = _studentQueryController.text.trim().toLowerCase();

      filteredList = studentList.where((student) {
        // Extract student details
        String fullName = "${student['firstName']} ${student['lastName']}".toLowerCase();
        String sectionId = student['sectionId'].toString();
        bool matchesSearch = fullName.contains(query);

        // Filter based on section
        bool matchesSection = selectedSection == null ||
            sectionIdToName[sectionId] == selectedSection;

        // Check for "Accomplished" based on the main `isAccomplished`
        bool isAccomplishedTopLevel = lessonAttempts.any((attempt) {
          return attempt['studentId'] == student['id'] &&
              attempt['isAccomplished'] == true; // Check top-level isAccomplished
        });

        // Combine all filters: Search, Section, and Accomplishment Status
        return matchesSearch && matchesSection && isAccomplishedTopLevel;
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

  Future<void> _fetchLessonAttempts() async {
    if (selectedLessonNumber == null) return;

    String collectionName = 'activity${_lessonNumberToString(selectedLessonNumber!)}Attempts';
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection(collectionName)
          .where('difficulty', isNotEqualTo: null)
          .get();

      setState(() {
        lessonAttempts = snapshot.docs.map((doc) {
          return {
            'id': doc.id,
            ...doc.data() as Map<String, dynamic>,
          };
        }).toList();
      });

      _filterStudentSearch();  // Reapply the search filter after fetching attempts
    } catch (e) {
      print("Error fetching lesson attempts from $collectionName: $e");
    }
  }

  String _lessonNumberToString(int lessonNumber) {
    const lessonMap = {
      1: 'One',
      2: 'Two',
      3: 'Three',
      4: 'Four',
      5: 'Five',
      6: 'Six',
      7: 'Seven',
      8: 'Eight',
      9: 'Nine',
    };
    return lessonMap[lessonNumber] ?? 'Unknown';
  }
}