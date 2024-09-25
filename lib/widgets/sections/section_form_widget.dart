import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../commons.dart';

class SectionFormWidget extends StatefulWidget {
  const SectionFormWidget({super.key, required this.formMode});
  final FormMode formMode;

  @override
  State<SectionFormWidget> createState() => _SectionFormWidgetState();
}

class _SectionFormWidgetState extends SectionFormController {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("${_getModeTypeDesc()} Section"),
            elevation: 0,
            backgroundColor: Colors.white,
            shape: const Border(
              bottom:
                  BorderSide(color: Colors.black, width: 2.0), // Black outline
            )),
        body: Center(
            child: Padding(
          padding: const EdgeInsets.only(
              top: 20.0, left: 42.0, right: 42.0, bottom: 20.0),
          child: Column(children: <Widget>[
            Text("${_getModeTypeDesc()} Section",
                style: TextStyle(fontSize: 28.0)),
            Container(
                margin: const EdgeInsets.all(15.0),
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 2.0),
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.grey[200]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      "Stub Code",
                      style: TextStyle(fontSize: 16.0),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: _stubCodeController,
                      style: const TextStyle(color: Colors.black),
                      decoration: const InputDecoration(
                        filled: true,
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      "Assigned Teacher",
                      style: TextStyle(fontSize: 16.0),
                    ),
                    const SizedBox(height: 10),
                    DropdownButton<String>(
                      value: selectedValue,
                      hint: const Text('Select an option'),
                      icon: const Icon(Icons.arrow_drop_down),
                      isExpanded: true,
                      dropdownColor: Colors.white54,
                      style: const TextStyle(color: Colors.black),
                      items:
                          options.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedValue = newValue;
                        });
                      },
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      "Year Registered",
                      style: TextStyle(fontSize: 16.0),
                    ),
                    TextFormField(
                      controller: _dateController,
                      style: const TextStyle(color: Colors.black),
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.grey,
                        border: OutlineInputBorder(),
                      ),
                      readOnly: true,
                    ),
                    const SizedBox(height: 15),
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {
                            _showConfirmationDialog(
                                context, _stubCodeController.text);
                          },
                          style: ButtonStyle(),
                          child: Text("${_getModeTypeDesc()} Section")),
                    )
                  ],
                ))
          ]),
        )));
  }
}

abstract class SectionFormController extends State<SectionFormWidget> {
  final TextEditingController _stubCodeController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  String? selectedValue;
  List<String> options = ['Option 1', 'Option 2', 'Option 3', 'Option 4'];

  @override
  void initState() {
    super.initState();
    _dateController.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
  }

  String _getModeTypeDesc() {
    String result;
    switch (widget.formMode) {
      case FormMode.add:
        result = "Add";
        break;
      case FormMode.edit:
        result = "Edit";
        break;
    }
    return result;
  }

  void _showConfirmationDialog(BuildContext context, String stubCode) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('${_getModeTypeDesc()} Section'),
          content:
              Text('Are you sure you want to ${_getModeTypeDesc()} $stubCode?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // add logic here for add/edit
                _showAddSuccessDialog(context);
              },
              child: Text(_getModeTypeDesc()),
            ),
          ],
        );
      },
    );
  }

  void _showAddSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Section ${_getModeTypeDesc()}ed Successfully'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Continue'),
            ),
          ],
        );
      },
    );
  }
}
