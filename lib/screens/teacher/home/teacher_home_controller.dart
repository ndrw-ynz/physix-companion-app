part of "teacher_home_screen.dart";

abstract class TeacherHomeController extends State<TeacherHomeScreen> {
  String? teacherDisplayName;
  List<Map<String, dynamic>> sectionsWithCounts = []; // Holds section name and student count

  @override
  void initState() {
    super.initState();
    updateTeacherDisplay();
    fetchSectionsWithStudentCounts();
  }

  Future<void> updateTeacherDisplay() async {
    Map<String, dynamic>? teacherProfile = await getUserProfile();

    if (teacherProfile != null) {
      setState(() {
        teacherDisplayName = "${teacherProfile["firstName"]} ${teacherProfile["lastName"]}";
      });
    }
  }

  Future<void> logOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      print("User logged out successfully");
      context.go("/");
    } catch (e) {
      print("Error logging out: $e");
    }
  }

  Future<void> fetchSectionsWithStudentCounts() async {
    String? teacherId = FirebaseAuth.instance.currentUser?.uid;

    if (teacherId == null) return;

    try {
      QuerySnapshot sectionSnapshot = await FirebaseFirestore.instance
          .collection('sections')
          .where('teacherId', isEqualTo: teacherId)
          .get();

      // Loop through sections and count students for each section
      List<Map<String, dynamic>> sectionDataList = [];

      for (var sectionDoc in sectionSnapshot.docs) {
        String sectionId = sectionDoc.id;
        String sectionName = sectionDoc['sectionName'];

        // Fetch student count for this section
        QuerySnapshot studentSnapshot = await FirebaseFirestore.instance
            .collection('students')
            .where('sectionId', isEqualTo: sectionId)
            .get();

        int studentCount = studentSnapshot.docs.length;

        // Add the section name and student count to the list
        sectionDataList.add({
          'sectionName': sectionName,
          'studentCount': studentCount,
        });
      }

      setState(() {
        sectionsWithCounts = sectionDataList;
      });

      print("Sections with counts: $sectionsWithCounts");
    } catch (e) {
      print("Error fetching sections with student counts: $e");
    }
  }
}