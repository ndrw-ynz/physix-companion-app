import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:physix_companion_app/widgets/sections/section_details_widget.dart';

part 'admin_sections_view_controller.dart';

class AdminSectionsViewScreen extends StatefulWidget {
  const AdminSectionsViewScreen({super.key});

  @override
  State<AdminSectionsViewScreen> createState() =>
      _AdminSectionsViewScreenState();
}

class _AdminSectionsViewScreenState extends AdminSectionsViewController {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sections List"),
        elevation: 0,
        backgroundColor: Colors.white,
        shape: const Border(
          bottom: BorderSide(color: Colors.black, width: 2.0), // Black outline
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push("/admin_home/sections/add"),
          )
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(
              top: 20.0, left: 42.0, right: 42.0, bottom: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Text("Section List", style: TextStyle(fontSize: 28.0)),
              const SizedBox(height: 12.0),
              Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 194, 194, 194),
                    borderRadius: BorderRadius.circular(10.0)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      //controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search Section Name',
                        hintStyle: const TextStyle(
                            color: Color.fromARGB(255, 194, 194, 194)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 8.0),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: () {},
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: DropdownMenu<String>(
                        initialSelection: selectedYear,
                        dropdownMenuEntries:
                            years.map<DropdownMenuEntry<String>>((String year) {
                          return DropdownMenuEntry<String>(
                            value: year,
                            label: year, // Black text for dropdown items
                          );
                        }).toList(),
                        onSelected: (String? newValue) {
                          setState(() {
                            selectedYear = newValue;
                          });
                        },
                        menuHeight: 20.0,
                        label: const Text(
                          'Select a year',
                          style: TextStyle(
                            color: Color.fromARGB(255, 0, 0,
                                0), // Change hint text color to black
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12.0),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
              Flexible(
                  fit: FlexFit.loose,
                  child: ListView(
                    children: <Widget>[
                      SectionDetailsWidget(
                          itemNumber: 1,
                          sectionCode: "2934",
                          teacherAssigned: "De Guzman, Juan Miguel",
                          yearAdded: 2024),
                      SectionDetailsWidget(
                          itemNumber: 2,
                          sectionCode: "2935",
                          teacherAssigned: "Delos Santos, Flora Mary",
                          yearAdded: 2024),
                      SectionDetailsWidget(
                          itemNumber: 3,
                          sectionCode: "3002",
                          teacherAssigned: "Cruz, Jake Mark",
                          yearAdded: 2024),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
