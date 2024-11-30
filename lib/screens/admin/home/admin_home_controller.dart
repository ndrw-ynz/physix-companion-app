part of "admin_home_screen.dart";

abstract class AdminHomeController extends State<AdminHomeScreen> {
  int teacherCount = 0;
  int sectionCount = 0;
  int studentCount = 0;

  @override
  void initState() {
    super.initState();
    fetchUserSectionCounts();
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

  Future<void> fetchUserSectionCounts() async {
    await _fetchTeacherCount();
    await _fetchSectionCount();
  }

  Future<void> _fetchTeacherCount() async {
    try {
      QuerySnapshot teacherSnapshot =
          await FirebaseFirestore.instance.collection('teachers').get();

      setState(() {
        teacherCount = teacherSnapshot.docs.length;
      });

      print("Number of teachers: $teacherCount");
    } catch (e) {
      print("Error fetching teacher count: $e");
    }
  }

  Future<void> _fetchSectionCount() async {
    try {
      QuerySnapshot sectionSnapshot =
          await FirebaseFirestore.instance.collection('sections').get();

      setState(() {
        sectionCount = sectionSnapshot.docs.length;
      });

      print("Number of sections: $sectionCount");
    } catch (e) {
      print("Error fetching section count: $e");
    }
  }
}
