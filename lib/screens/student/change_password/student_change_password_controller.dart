part of "student_change_password_screen.dart";

abstract class StudentChangePasswordController
    extends State<StudentChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  bool _isOldPasswordObscured = true;
  bool _isNewPasswordObscured = true;

  Future<void> _updateStudentPassword() async {
    bool isUpdated = await updateUserPassword(
        context, _oldPasswordController.text, _newPasswordController.text);

    if (isUpdated) {
      _oldPasswordController.clear();
      _newPasswordController.clear();
    }
    print("Is updated: $isUpdated");
  }
}
