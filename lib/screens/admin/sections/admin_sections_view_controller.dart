part of 'admin_sections_view_screen.dart';

abstract class AdminSectionsViewController
    extends State<AdminSectionsViewScreen> {
  final TextEditingController _sectionQueryController = TextEditingController();
  List<Map<String, dynamic>> sectionsList = [];
  List<Map<String, dynamic>> filteredList = [];
  Map<String, String> teacherNames = {};

  List<String> years = [];
  String? selectedYear;

  @override
  void initState() {
    super.initState();

    _gatherYears();
    _fetchAllSections();
  }

  Future<void> _fetchAllSections() async {
    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('sections').get();

      Set<String> teacherIds = {};
      setState(() {
        sectionsList = snapshot.docs.map((doc) {
          String teacherId = doc['teacherId'] ?? "";
          teacherIds.add(teacherId);
          return {
            'id': doc.id,
            ...doc.data() as Map<String, dynamic>,
          };
        }).toList();
      });

      if (teacherIds.isNotEmpty) {
        QuerySnapshot teacherSnapshot = await FirebaseFirestore.instance
            .collection('teachers')
            .where(FieldPath.documentId, whereIn: teacherIds.toList())
            .get();

        // Store the teacher names in a map (teacherId -> full name)
        for (var doc in teacherSnapshot.docs) {
          String firstName = doc['firstName'] ?? 'Unknown';
          String lastName = doc['lastName'] ?? 'Unknown';
          teacherNames[doc.id] = '$firstName $lastName';
        }
      }

      setState(() {
        filteredList = List.from(sectionsList);
      });
    } catch (e) {
      print("Error fetching all sections: $e");
    }
  }

  void _filterSectionSearch() {
    // Filters search from textField and selectedYear
    setState(() {
      filteredList = sectionsList.where((section) {
        String sectionName = section['sectionName'];
        return sectionName
            .contains(_sectionQueryController.text.trim().toLowerCase());
      }).where((section) {
        DateTime dateCreated = (section['dateCreated'] as Timestamp).toDate();
        return dateCreated.year.toString() == selectedYear;
      }).toList();
    });
  }

  Future<void> _gatherYears() async {
    Set<String> uniqueYears = {};

    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('sections').get();

      for (var doc in snapshot.docs) {
        Timestamp timestamp = doc["dateCreated"];

        DateTime dateTime = timestamp.toDate();

        uniqueYears.add(dateTime.year.toString());
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
