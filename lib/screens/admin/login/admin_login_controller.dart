part of "admin_login_screen.dart";

abstract class AdminLoginController extends State<AdminLoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isObscured = true;
}
