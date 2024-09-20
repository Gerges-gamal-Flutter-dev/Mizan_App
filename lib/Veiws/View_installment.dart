// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

class ViewInstallment extends StatefulWidget {
  const ViewInstallment({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ViewInstallmentState createState() => _ViewInstallmentState();
}

class _ViewInstallmentState extends State<ViewInstallment> {
  bool showForm = false;
  List<Map<String, String>> tableData = [];
  final TextEditingController paymentController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController notesController = TextEditingController();

  void _saveData() {
    setState(() {
      tableData.add({
        'payment': paymentController.text,
        'date': dateController.text,
        'notes': notesController.text,
      });
      paymentController.clear();
      dateController.clear();
      notesController.clear();
      showForm = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'الميزان',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage('assets/images/logo.png'),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.green[300],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'في هذة الغرفة يتم عرض او اضافة او حذف الاقساط الملتزم بها حاليا ',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: tableData.isEmpty
                    ? Center(
                        child: Image.asset(
                          "assets/images/no quest.gif",
                          width: double.infinity,
                          height: 300,
                          fit: BoxFit.cover,
                        ),
                      )
                    : DataTable(
                        columns: const [
                           DataColumn(label: Text('القسط الشهري')),
                           DataColumn(label: Text('ميعاد التسديد')),
                           DataColumn(label: Text('ملاحظات')),
                        ],
                        rows: tableData
                            .map(
                              (data) => DataRow(cells: [
                                DataCell(Text(data['payment']!)),
                                DataCell(Text(data['date']!)),
                                DataCell(Text(data['notes']!)),
                              ]),
                            )
                            .toList(),
                      ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            showForm = !showForm;
          });
        },
        child: const Icon(Icons.add),
      ),
      bottomSheet: showForm
          ? Container(
              padding: const EdgeInsets.all(16),
              color: Colors.white,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: paymentController,
                    decoration:
                        const InputDecoration(labelText: 'القسط الشهري'),
                  ),
                  TextField(
                    controller: dateController,
                    decoration:
                        const InputDecoration(labelText: 'ميعاد التسديد'),
                  ),
                  TextField(
                    controller: notesController,
                    decoration: const InputDecoration(labelText: 'ملاحظات'),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _saveData,
                    child: const Text('حفظ'),
                  ),
                ],
              ),
            )
          : null,
    );
  }
}