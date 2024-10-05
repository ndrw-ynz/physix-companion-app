import 'package:cloud_firestore/cloud_firestore.dart';
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
                      controller: _sectionQueryController,
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
                          onPressed: () {
                            if (_sectionQueryController.text.isEmpty) {
                              _fetchAllSections();
                            } else {
                              _filterSectionSearch();
                            }
                          },
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    Container(
                      padding: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: DropdownButton<String>(
                        value: selectedYear,
                        icon: const Icon(Icons.arrow_downward),
                        elevation: 16,
                        items:
                            years.map<DropdownMenuItem<String>>((String year) {
                          return DropdownMenuItem<String>(
                            value: year,
                            child: Text(year),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedYear = newValue!;
                            _filterSectionSearch();
                          });
                        },
                        hint: const Text(
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
              Expanded(
                child: ListView.builder(
                  itemCount: filteredList.length,
                  itemBuilder: (context, index) {
                    final section = filteredList[index];
                    final teacherId = section["teacherId"] ?? "";

                    String teacherFullName =
                        teacherNames[teacherId] ?? "Unknown Teacher";

                    return SectionDetailsWidget(
                      itemNumber: index + 1,
                      sectionId: section["id"],
                      sectionCode: section["sectionName"] ?? "Unknown name",
                      teacherAssigned: teacherFullName,
                      teacherId: section["teacherId"] ?? "Unknown ID",
                      dateRegistered: section["dateCreated"] ?? Timestamp.now(),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
