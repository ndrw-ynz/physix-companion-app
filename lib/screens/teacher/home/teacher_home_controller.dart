part of "teacher_home_screen.dart";

abstract class TeacherHomeController extends State<TeacherHomeScreen> {
  String? teacherDisplayName;
  List<Map<String, dynamic>> sectionsWithCounts = [
  ]; // Holds section name and student count

  @override
  void initState() {
    super.initState();
    updateTeacherDisplay();
    getSectionsWithStudentCounts();
  }

  Future<void> updateTeacherDisplay() async {
    Map<String, dynamic>? teacherProfile = await getUserProfile();

    if (teacherProfile != null) {
      setState(() {
        teacherDisplayName =
        "${teacherProfile["firstName"]} ${teacherProfile["lastName"]}";
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

  Stream<List<Map<String, dynamic>>> getSectionsWithStudentCounts() {
    String? teacherId = FirebaseAuth.instance.currentUser?.uid;

    if (teacherId == null) {
      return Stream.value([]);
    }

    return FirebaseFirestore.instance
        .collection('sections')
        .where('teacherId', isEqualTo: teacherId)
        .snapshots()
        .asyncMap((sectionSnapshot) async {
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

        sectionDataList.add({
          'sectionName': sectionName,
          'studentCount': studentCount,
        });
      }

      return sectionDataList;
    });
  }
}