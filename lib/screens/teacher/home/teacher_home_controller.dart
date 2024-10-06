part of "teacher_home_screen.dart";

abstract class TeacherHomeController extends State<TeacherHomeScreen> {
  String? teacherDisplayName;

  @override
  void initState() {
    super.initState();

    updateTeacherDisplay();
  }

  Future<void> updateTeacherDisplay() async {
    Map<String, dynamic>? teacherProfile = await getUserProfile();

    if (teacherProfile != null) {
      teacherDisplayName =
          "${teacherProfile["firstName"]} ${teacherProfile["lastName"]}";
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
