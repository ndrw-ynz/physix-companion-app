import 'package:flutter/material.dart';

import '../../utils.dart';

class ChangePasswordScreenWidget extends StatefulWidget {
  const ChangePasswordScreenWidget({super.key});

  @override
  State<ChangePasswordScreenWidget> createState() =>
      _ChangePasswordScreenWidgetState();
}

class _ChangePasswordScreenWidgetState
    extends State<ChangePasswordScreenWidget> {
  final _formKey = GlobalKey<FormState>();

  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  bool _isOldPasswordObscured = true;
  bool _isNewPasswordObscured = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Change Password"),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 0.0),
        child: Form(
          key: _formKey,
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                "Old Password",
                style: TextStyle(fontSize: 18.0),
              ),
              const SizedBox(height: 5.0),
              TextFormField(
                controller: _oldPasswordController,
                obscureText: _isOldPasswordObscured,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(
                      Icons.lock_outline,
                      color: Colors.black,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(_isOldPasswordObscured
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          _isOldPasswordObscured = !_isOldPasswordObscured;
                        });
                      },
                    )),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password is required';
                  }
                  return null;
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              const SizedBox(height: 20.0),
              const Text(
                "New Password",
                style: TextStyle(fontSize: 18.0),
              ),
              const SizedBox(height: 5.0),
              TextFormField(
                controller: _newPasswordController,
                obscureText: _isNewPasswordObscured,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(
                      Icons.lock_outline,
                      color: Colors.black,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(_isNewPasswordObscured
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          _isNewPasswordObscured = !_isNewPasswordObscured;
                        });
                      },
                    )),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password is required';
                  }

                  if (value.length < 8) {
                    return 'Password must be at least 8 characters';
                  }

                  return null;
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              const SizedBox(height: 15.0),
              ElevatedButton(
                  onPressed: () => {
                        if (_formKey.currentState!.validate()) _updatePassword()
                      },
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      backgroundColor:
                          const Color.fromARGB(255, 221, 219, 219)),
                  child: const Text("Confirm Password"))
            ],
          )),
        ),
      ),
    );
  }

  Future<void> _updatePassword() async {
    bool isUpdated = await updateUserPassword(
        context, _oldPasswordController.text, _newPasswordController.text);

    if (isUpdated) {
      _oldPasswordController.clear();
      _newPasswordController.clear();
    }
    print("Is updated: $isUpdated");
  }
}
