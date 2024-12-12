part of "student_home_screen.dart";

abstract class StudentHomeController extends State<StudentHomeScreen> {
  String? studentDisplayName;
  Map<String, dynamic>? sectionData;
  Map<String, dynamic>? unlockedLevelData;

  Map<int, String> lessonNames = {
    1: "Lesson 1",
    2: "Lesson 2",
    3: "Lesson 3",
    4: "Lesson 4",
    5: "Lesson 5",
    6: "Lesson 6",
    7: "Lesson 7",
    8: "Lesson 8",
    9: "Lesson 9",
  };

  @override
  void initState() {
    super.initState();
    updateStudentDisplay();
  }

  Future<void> updateStudentDisplay() async {
    Map<String, dynamic>? studentProfile =
        await getUserProfile(UserType.students);

    // Fetch section profile
    try {
      DocumentSnapshot<Map<String, dynamic>> doc = await FirebaseFirestore
          .instance
          .collection('sections')
          .doc(studentProfile?["sectionId"])
          .get();

      if (doc.exists) {
        setState(() {
          sectionData = doc.data();
        });
      }
    } catch (e) {
      print("Error fetching section data: $e");
    }

    // Fetch unlocked level data
    try {
      User? user = FirebaseAuth.instance.currentUser;

      DocumentSnapshot<Map<String, dynamic>> doc = await FirebaseFirestore
          .instance
          .collection('unlockedLevels')
          .doc(user?.uid)
          .get();

      if (doc.exists) {
        setState(() {
          unlockedLevelData = doc.data();
        });
      }
    } catch (e) {
      print("Error fetching unlocked levels data: $e");
    }

    if (studentProfile != null) {
      setState(() {
        studentDisplayName =
            "${studentProfile["firstName"]} ${studentProfile["lastName"]}";
      });
    }
  }

  Future<void> logOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      print("User logged out successfully");
      context.go("/");
      authNotifier.logoutUser();
    } catch (e) {
      print("Error logging out: $e");
    }
  }
}
