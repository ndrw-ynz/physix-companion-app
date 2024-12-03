part of "student_login_screen.dart";

abstract class StudentLoginController extends State<StudentLoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isObscured = true;

  Future<void> validateStudentLogin() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _usernameController.text.trim(),
          password: _passwordController.text.trim());

      print("STUDENT SIGNED IN!");
      showDialog(
          context: context,
          builder: (context) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          });

      while (authNotifier.isLoading) {
        await Future.delayed(
            const Duration(milliseconds: 100)); // Add a small delay
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
