part of "attempt_history_screen.dart";

abstract class AttemptHistoryController extends State<AttemptHistoryScreen> {
  final TextEditingController _historyQueryController = TextEditingController();
  // Query Parameters
  // Lesson
  Map<String, String> attemptCollectionNames = {
    "Lesson 1": "activityOneAttempts",
    "Lesson 2": "activityTwoAttempts",
    "Lesson 3": "activityThreeAttempts",
    "Lesson 4": "activityFourAttempts",
    "Lesson 5": "activityFiveAttempts",
    "Lesson 6": "activitySixAttempts",
    "Lesson 7": "activitySevenAttempts",
    "Lesson 8": "activityEightAttempts",
    "Lesson 9": "activityNineAttempts",
  };
  String? selectedLesson;
  List<String> lessons = [
    "Lesson 1",
    "Lesson 2",
    "Lesson 3",
    "Lesson 4",
    "Lesson 5",
    "Lesson 6",
    "Lesson 7",
    "Lesson 8",
    "Lesson 9"
  ];
  // Difficulty
  String? selectedDifficulty;
  List<String> difficulties = ["Easy", "Medium", "Hard"];
  // Query results
  List<Map<String, dynamic>> queryHistoryList = [];

  @override
  void initState() {
    super.initState();
    selectedLesson = lessons[0];
    selectedDifficulty = difficulties[0];
  }

  Future<void> _fetchAttemptHistory() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null && selectedLesson != null) {
      try {
        QuerySnapshot snapshot = await FirebaseFirestore.instance
            .collection(attemptCollectionNames[selectedLesson!]!)
            .where("studentId", isEqualTo: user.uid)
            .where("difficulty", isEqualTo: selectedDifficulty!)
            .get();

        queryHistoryList = snapshot.docs.map((doc) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          data['lessonName'] = selectedLesson;
          return data;
        }).toList();
      } catch (e) {
        print("Error fetching attempt history: $e");
      }
    }
  }
}
