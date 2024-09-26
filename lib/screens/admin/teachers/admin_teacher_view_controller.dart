part of 'admin_teacher_view_screen.dart';

abstract class AdminTeacherViewController
    extends State<AdminTeacherViewScreen> {
  String? selectedYear;
  List<String> years = [];
  List<Map<String, dynamic>> _teachers = [];

  @override
  void initState() {
    super.initState();
    // Generate a list of years from the current year to a specified future year
    int currentYear = DateTime.now().year;
    for (int i = 0; i <= 10; i++) {
      years.add((currentYear + i).toString());
    }

    // Fetch teachers when the screen is initialized
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Fetch teachers when the screen is initialized
    fetchAllTeachers().then((data) {
      setState(() {
        _teachers = data; // Store fetched teachers
      });
    });
  }

  Future<List<Map<String, dynamic>>> fetchAllTeachers() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('role', isEqualTo: 'teacher')
          .get();

      List<Map<String, dynamic>> teachers = querySnapshot.docs
          .map((doc) => {'id': doc.id, ...doc.data() as Map<String, dynamic>})
          .toList();

      return teachers;
    } catch (e) {
      print("Error fetching teachers: $e");
      return [];
    }
  }
}
