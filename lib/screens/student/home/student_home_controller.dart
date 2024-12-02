part of "student_home_screen.dart";

abstract class StudentHomeController extends State<StudentHomeScreen> {
  String? studentDisplayName;
  Map<String, dynamic>? sectionData;

  @override
  void initState() {
    super.initState();
    updateStudentDisplay();
  }

  Future<void> updateStudentDisplay() async {
    Map<String, dynamic>? studentProfile =
        await getUserProfile(UserType.students);

    // Fetch section profile
    try {
      DocumentSnapshot<Map<String, dynamic>> doc = await FirebaseFirestore
          .instance
          .collection('sections')
          .doc(studentProfile?["sectionId"])
          .get();

      if (doc.exists) {
        setState(() {
          sectionData = doc.data();
        });
      }
    } catch (e) {
      print("Error fetching section data: $e");
    }

    if (studentProfile != null) {
      setState(() {
        studentDisplayName =
            "${studentProfile["firstName"]} ${studentProfile["lastName"]}";
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
}
