part of "teacher_login_screen.dart";

abstract class TeacherLoginController extends State<TeacherLoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isObscured = true;

  Future<void> validateTeacherLogin() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: _usernameController.text.trim(),
              password: _passwordController.text.trim());

      print("TEACHER SIGNED IN!");
      showDialog(
          context: context,
          builder: (context) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          });

      while (authNotifier.isLoading) {
        await Future.delayed(Duration(milliseconds: 100)); // Add a small delay
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        print("NO USER!");
      } else if (e.code == "wrong-password") {
        print("WRONG PASSWORD!");
      } else {
        print("ERROR! " + e.code);
      }
    }
  }
}
