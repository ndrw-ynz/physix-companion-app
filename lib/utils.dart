import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

enum UserType { admin, teacher, student }

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
