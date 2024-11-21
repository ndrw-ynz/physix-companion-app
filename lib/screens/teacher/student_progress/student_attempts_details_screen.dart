import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class StudentAttemptDetailsScreen extends StatefulWidget {
  final String studentId;
  final String firstName;
  final String lastName;
  final int lessonNumber;
  final String difficulty;

  const StudentAttemptDetailsScreen({
    super.key,
    required this.studentId,
    required this.firstName,
    required this.lastName,
    required this.lessonNumber,
    required this.difficulty,
  });

  @override
  _StudentAttemptDetailsScreenState createState() =>
      _StudentAttemptDetailsScreenState();
}

class _StudentAttemptDetailsScreenState
    extends State<StudentAttemptDetailsScreen> {
  List<Map<String, dynamic>> attempts = [];

  @override
  void initState() {
    super.initState();
    _fetchAttempts();
  }

  Future<void> _fetchAttempts() async {
    String collectionName =
        'activity${_lessonNumberToString(widget.lessonNumber)}Attempts';
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection(collectionName)
          .where('studentId', isEqualTo: widget.studentId)
          .where('difficulty', isEqualTo: widget.difficulty)
          .get();

      setState(() {
        attempts = snapshot.docs.map((doc) {
          return {
            'id': doc.id,
            ...doc.data() as Map<String, dynamic>,
          };
        }).toList();

        // Sort the attempts by dateAttempted in descending order
        attempts.sort((a, b) {
          Timestamp timestampA = a['dateAttempted'] as Timestamp;
          Timestamp timestampB = b['dateAttempted'] as Timestamp;
          return timestampB.compareTo(timestampA);
        });
      });
    } catch (e) {
      print("Error fetching attempts: $e");
    }
  }

  String _lessonNumberToString(int lessonNumber) {
    const lessonMap = {
      1: 'One',
      2: 'Two',
      3: 'Three',
      4: 'Four',
      5: 'Five',
      6: 'Six',
      7: 'Seven',
      8: 'Eight',
      9: 'Nine',
    };
    return lessonMap[lessonNumber] ?? 'Unknown';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Student Progress"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                '${widget.firstName} ${widget.lastName}',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: attempts.length,
              itemBuilder: (context, index) {
                final attempt = attempts[index];
                final timestamp = attempt['dateAttempted'] as Timestamp?;
                final dateAttempted = timestamp?.toDate();
                final formattedDate = dateAttempted != null
                    ? DateFormat('dd/MM/yy').format(dateAttempted)
                    : 'N/A';

                // Check if this is for activityThreeAttempts
                final lessonString = _lessonNumberToString(widget.lessonNumber);
                final activityCollectionName = 'activity${lessonString}Attempts';
                print('Activity Collection Name: $activityCollectionName');  // Debugging output

                // Check if this attempt belongs to activityThreeAttempts
                if (activityCollectionName == 'activityThreeAttempts') {
                  return _buildActivityThreeUI(attempt, formattedDate);
                }


                // Render UI for other activities
                final results = attempt['results'] as Map<String, dynamic>? ?? {};
                return Container(
                  margin: EdgeInsets.all(8),
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.black),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Lesson ${_lessonNumberToString(widget.lessonNumber)}',
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            formattedDate,
                            style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),

                      Row(
                        children: [
                          Row(
                            children: [
                              Text('Difficulty:', style: TextStyle(fontSize: 14)),
                              SizedBox(width: 4),
                              Text(
                                attempt['difficulty'] ?? 'N/A',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: _getDifficultyColor(attempt['difficulty'] ?? ''),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Status:',
                            style: TextStyle(fontSize: 14, color: Colors.black),
                          ),
                          SizedBox(width: 4),
                          Text(
                            attempt['isAccomplished'] != null
                                ? (attempt['isAccomplished'] ? "Accomplished" : "Not Accomplished")
                                : 'N/A',
                            style: TextStyle(
                              fontSize: 14,
                              color: attempt['isAccomplished'] != null
                                  ? (attempt['isAccomplished'] ? Colors.green : Colors.red)
                                  : Colors.black,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),

                      Text(
                          'Total Duration | ${attempt['totalDurationInSec'] ?? 'N/A'} s',
                          style: TextStyle(fontSize: 14)),
                      SizedBox(height: 12),

                      // Dynamically render results
                      ...results.entries.map((entry) {
                        final resultName = entry.key;
                        final resultData = entry.value as Map<String, dynamic>;

                        return Container(
                          margin: EdgeInsets.only(top: 8),
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.black),
                          ),
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    '$resultName: ',
                                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(width: 4),
                                  Text(
                                    resultData['isAccomplished'] != null
                                        ? (resultData['isAccomplished'] ? 'Accomplished' : 'Not Accomplished')
                                        : 'N/A',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: resultData['isAccomplished'] != null
                                          ? (resultData['isAccomplished'] ? Colors.green : Colors.red)
                                          : Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),

                              Row(
                                children: [
                                  Text(
                                    'Number of Mistakes: ',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  Text(
                                    '${resultData['mistakes'] ?? "N/A"}',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),

                              Row(
                                children: [
                                  Text(
                                    'Duration | ',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  Text(
                                    '${resultData['durationInSec'] ?? "N/A"} s',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityThreeUI(Map<String, dynamic> attempt, String formattedDate) {
    final results = attempt['results'] as Map<String, dynamic>? ?? {};
    final kinematicsData = results['1DKinematics'] ?? {};
    final graphsData = results['graphs'] ?? {};

    // Extract 1D Kinematics Data
    bool isAccelerationAccomplished = kinematicsData['isAccelerationAccomplished'] ?? false;
    bool isTotalDepthAccomplished = kinematicsData['isTotalDepthAccomplished'] ?? false;
    int accelerationMistakes = kinematicsData['accelerationMistakes'] ?? 0;
    int totalDepthMistakes = kinematicsData['totalDepthMistakes'] ?? 0;
    int kinematicsDurationInSec = kinematicsData['durationInSec'] ?? 0;

    // Extract Graph Data
    bool isGraphsAccomplished = graphsData['isAccomplished'] ?? false;
    int graphMistakes = graphsData['mistakes'] ?? 0;
    int graphDurationInSec = graphsData['durationInSec'] ?? 0;

    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blue),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Lesson ${_lessonNumberToString(widget.lessonNumber)}',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                formattedDate,
                style: TextStyle(fontSize: 14, color: Colors.grey[700]),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Row(
                children: [
                  Text('Difficulty:', style: TextStyle(fontSize: 14)),
                  SizedBox(width: 4),
                  Text(
                    attempt['difficulty'] ?? 'N/A',
                    style: TextStyle(
                      fontSize: 14,
                      color: _getDifficultyColor(attempt['difficulty'] ?? ''),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 8),
              Text(
                'Status:',
                style: TextStyle(fontSize: 14, color: Colors.black),
              ),
              SizedBox(width: 4),
              Text(
                attempt['isAccomplished'] != null
                    ? (attempt['isAccomplished'] ? "Accomplished" : "Not Accomplished")
                    : 'N/A',
                style: TextStyle(
                  fontSize: 14,
                  color: attempt['isAccomplished'] != null
                      ? (attempt['isAccomplished'] ? Colors.green : Colors.red)
                      : Colors.black,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),

          Text(
              'Total Duration | ${attempt['totalDurationInSec'] ?? 'N/A'} s',
              style: TextStyle(fontSize: 14)),
          SizedBox(height: 12),

          Container(
            margin: EdgeInsets.only(top: 8),
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.black),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('1D Kinematics:', style: TextStyle(fontSize: 14)),
                    SizedBox(width: 8),
                    Text(
                      (isAccelerationAccomplished && isTotalDepthAccomplished) ? 'Accomplished' : 'Not Accomplished',
                      style: TextStyle(
                        fontSize: 14,
                        color: (isAccelerationAccomplished && isTotalDepthAccomplished)
                            ? Colors.green
                            : Colors.red,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),

                // White container for 1D Kinematics details
                Container(
                  margin: EdgeInsets.only(top: 8),
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.black),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text('Acceleration: ', style: TextStyle(fontSize: 14)),
                          Text(
                            isAccelerationAccomplished ? 'Accomplished' : 'Not Accomplished',
                            style: TextStyle(
                              fontSize: 14,
                              color: isAccelerationAccomplished ? Colors.green : Colors.red,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),

                      Row(
                        children: [
                          Text('Number of Mistakes: ', style: TextStyle(fontSize: 14)),
                          Text('$accelerationMistakes', style: TextStyle(fontSize: 14)),
                        ],
                      ),
                      SizedBox(height: 8),

                      Row(
                        children: [
                          Text('Total Depth: ', style: TextStyle(fontSize: 14)),
                          SizedBox(width: 8),
                          Text(
                            isTotalDepthAccomplished ? 'Accomplished' : 'Not Accomplished',
                            style: TextStyle(
                              fontSize: 14,
                              color: isTotalDepthAccomplished ? Colors.green : Colors.red,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),

                      Row(
                        children: [
                          Text('Number of Mistakes: ', style: TextStyle(fontSize: 14)),
                          Text('$totalDepthMistakes', style: TextStyle(fontSize: 14)),
                        ],
                      ),
                      SizedBox(height: 8),

                      Row(
                        children: [
                          Text('Duration: | ', style: TextStyle(fontSize: 14)),
                          Text('$kinematicsDurationInSec s', style: TextStyle(fontSize: 14)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 12),
          Container(
            margin: EdgeInsets.only(top: 8),
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.black),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Graphs:', style: TextStyle(fontSize: 14)),
                    SizedBox(width: 8),
                    Text(
                      isGraphsAccomplished ? 'Accomplished' : 'Not Accomplished',
                      style: TextStyle(
                        fontSize: 14,
                        color: isGraphsAccomplished ? Colors.green : Colors.red,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),

                Row(
                  children: [
                    Text('Number of Mistakes: ', style: TextStyle(fontSize: 14)),
                    Text('$graphMistakes', style: TextStyle(fontSize: 14)),
                  ],
                ),
                SizedBox(height: 8),

                Row(
                  children: [
                    Text('Duration: | ', style: TextStyle(fontSize: 14)),
                    Text('$graphDurationInSec s', style: TextStyle(fontSize: 14)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty) {
      case 'Easy':
        return Colors.green;
      case 'Medium':
        return Colors.orange;
      case 'Hard':
        return Colors.red;
      default:
        return Colors.black;
    }
  }
}