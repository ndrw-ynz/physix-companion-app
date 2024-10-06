part of "teacher_change_password_screen.dart";

abstract class TeacherChangePasswordController
    extends State<TeacherChangePasswordScreen> {
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  bool _isOldPasswordObscured = true;
  bool _isNewPasswordObscured = true;
}
