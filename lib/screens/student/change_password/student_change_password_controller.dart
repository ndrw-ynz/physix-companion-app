part of "student_change_password_screen.dart";

abstract class StudentChangePasswordController
    extends State<StudentChangePasswordScreen> {
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  bool _isOldPasswordObscured = true;
  bool _isNewPasswordObscured = true;
}
