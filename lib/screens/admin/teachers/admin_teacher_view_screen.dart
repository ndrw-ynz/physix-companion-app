import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:physix_companion_app/widgets/teachers/teacher_details_widget.dart';

part 'admin_teacher_view_controller.dart';

class AdminTeacherViewScreen extends StatefulWidget {
  const AdminTeacherViewScreen({super.key});

  @override
  State<AdminTeacherViewScreen> createState() => _AdminTeacherViewScreenState();
}

class _AdminTeacherViewScreenState extends AdminTeacherViewController {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Teachers List"),
        elevation: 0,
        backgroundColor: Colors.white,
        shape: const Border(
          bottom: BorderSide(color: Colors.black, width: 2.0), // Black outline
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push("/admin_home/teachers/add"),
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
              const Text("Teacher List", style: TextStyle(fontSize: 28.0)),
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
                        hintText: "Search Teacher's Name",
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
                      TeacherDetailsWidget(
                          itemNumber: 1,
                          name: "De Guzman, Juan Miguel",
                          email: "jmdeguzman@gmail.com",
                          username: "deguzman2312",
                          password: "sampletext",
                          yearRegistered: 2024),
                      TeacherDetailsWidget(
                          itemNumber: 2,
                          name: "Delos Santos, Flora Mary",
                          email: "floramary@gmail.com",
                          username: "floramary022",
                          password: "sampletext",
                          yearRegistered: 2024),
                      TeacherDetailsWidget(
                          itemNumber: 3,
                          name: "Cruz, Jake Mark",
                          email: "jakecruz@gmail.com",
                          username: "cruzjake209",
                          password: "sampletext",
                          yearRegistered: 2024)
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
