part of 'admin_sections_view_screen.dart';

abstract class AdminSectionsViewController
    extends State<AdminSectionsViewScreen> {
  String? selectedYear;
  List<String> years = [];

  @override
  void initState() {
    super.initState();
    // Generate a list of years from the current year to a specified future year
    int currentYear = DateTime.now().year;
    for (int i = 0; i <= 10; i++) {
      years.add((currentYear + i).toString());
    }
  }
}
