part of 'admin_teacher_view_screen.dart';

abstract class AdminTeacherViewController
    extends State<AdminTeacherViewScreen> {
  final TextEditingController _teacherQueryController = TextEditingController();
  List<Map<String, dynamic>> teacherList = [];
  List<Map<String, dynamic>> filteredList = [];
  List<String> years = [];
  String? selectedYear;

  @override
  void initState() {
    super.initState();

    _fetchAllTeachers();
    _gatherYears();
  }

  Future<void> _fetchAllTeachers() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('role', isEqualTo: 'teacher')
          .get();

      setState(() {
        teacherList = snapshot.docs.map((doc) {
          return {
            'id': doc.id,
            ...doc.data() as Map<String, dynamic>,
          };
        }).toList();
      });

      filteredList = List.from(teacherList);
    } catch (e) {
      print("Error fetching all teachers: $e");
    }
  }

  void _filterTeacherSearch() {
    // Filters search from textField and selectedYear
    setState(() {
      filteredList = teacherList.where((teacher) {
        String fullName =
            "${teacher['firstName']} ${teacher['lastName']}".toLowerCase();
        return fullName
            .contains(_teacherQueryController.text.trim().toLowerCase());
      }).where((teacher) {
        DateTime dateCreated = (teacher['dateCreated'] as Timestamp).toDate();
        return dateCreated.year.toString() == selectedYear;
      }).toList();
    });
  }

  Future<void> _gatherYears() async {
    Set<String> uniqueYears = {};

    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('role', isEqualTo: 'teacher')
          .get();

      for (var doc in snapshot.docs) {
        Timestamp timestamp = doc["dateCreated"];

        if (timestamp != null) {
          DateTime dateTime = timestamp.toDate();

          uniqueYears.add(dateTime.year.toString());
        }
      }

      setState(() {
        years = uniqueYears.toList();
        selectedYear = years.isNotEmpty ? years[0] : null;
      });
    } catch (e) {
      print("Error fetching years: $e");
    }
  }
}
