part of 'admin_sections_view_screen.dart';

abstract class AdminSectionsViewController
    extends State<AdminSectionsViewScreen> {
  String? selectedYear;
  List<String> years = [];
  List<Map<String, dynamic>> _sections = [];

  @override
  void initState() {
    super.initState();
    // Generate a list of years from the current year to a specified future year
    int currentYear = DateTime.now().year;
    for (int i = 0; i <= 10; i++) {
      years.add((currentYear + i).toString());
    }

    fetchAllSections();
  }

  Future<List<Map<String, dynamic>>> fetchAllSections() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('sections').get();

      List<Map<String, dynamic>> _sections = querySnapshot.docs
          .map((doc) => {'id': doc.id, ...doc.data() as Map<String, dynamic>})
          .toList();

      return _sections;
    } catch (e) {
      print("Error fetching teachers: $e");
      return [];
    }
  }
}
