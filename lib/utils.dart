import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

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