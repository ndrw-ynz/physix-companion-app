part of "teacher_home_screen.dart";

abstract class TeacherHomeController extends State<TeacherHomeScreen> {
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
