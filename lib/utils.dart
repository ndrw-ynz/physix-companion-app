import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum UserType { admin, teachers, students }

String extractUsername(String email) {
  // Define the regular expression to capture the part before the '@'
  RegExp regex = RegExp(r'^([a-zA-Z0-9._%+-]+)@');

  // Match the regex against the email
  Match? match = regex.firstMatch(email);

  // If there is a match, return the first group (the username)
  if (match != null) {
    return match.group(1)!;
  } else {
    // Return a default value or handle error if no match is found
    return '';
  }
}

String formatTimestamp(Timestamp timestamp) {
  DateTime dateTime = timestamp.toDate(); // Convert Timestamp to DateTime
  return DateFormat('yyyy-MM-dd – kk:mm').format(dateTime); // Format DateTime
}

Future<Map<String, dynamic>?> getUserProfile(UserType userType) async {
  User? user = FirebaseAuth.instance.currentUser;

  if (user != null) {
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection(userType.name)
          .doc(user.uid)
          .get();
      if (doc.exists) {
        return doc.data() as Map<String, dynamic>;
      } else {
        print('No ${userType.name} profile found');
      }
    } catch (e) {
      print('Error fetching user profile: $e');
    }
  }

  return null;
}

Future<bool> updateUserPassword(
    BuildContext context, String currentPassword, String newPassword) async {
  // Show loading dialog
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return const AlertDialog(
        content: Row(
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 16),
            Text("Updating password..."),
          ],
        ),
      );
    },
  );

  try {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Reauthenticate user with current password
      AuthCredential credential = EmailAuthProvider.credential(
          email: user.email!, password: currentPassword);

      await user.reauthenticateWithCredential(credential);
      print("Reauthentication successful.");

      // Update password
      await user.updatePassword(newPassword);
      print("Password updated successfully.");

      // Dismiss loading dialog
      Navigator.of(context).pop();

      // Show success dialog
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Success"),
            content: const Text("Password updated successfully."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("OK"),
              ),
            ],
          );
        },
      );

      return true;
    } else {
      print("User not found.");
      Navigator.of(context).pop(); // Dismiss loading dialog
      return false;
    }
  } catch (e) {
    print("Failed to update password: $e");

    // Dismiss loading dialog
    Navigator.of(context).pop();

    // Show error dialog
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Error"),
          content: const Text("Failed to update password! "),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );

    return false;
  }
}
