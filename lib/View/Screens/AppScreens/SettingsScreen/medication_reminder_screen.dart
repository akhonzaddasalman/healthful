import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthful/View/Components/build_buttons.dart';
import 'package:healthful/View/theme/extention.dart';
import 'package:healthful/View/theme/light_color.dart';
import 'package:healthful/View/theme/text_styles.dart';
import 'package:healthful/View/widgets/text_field.dart';

class MedicationReminderPage extends StatefulWidget {
  const MedicationReminderPage({super.key});

  @override
  _MedicationReminderPageState createState() => _MedicationReminderPageState();
}

class _MedicationReminderPageState extends State<MedicationReminderPage> {
  List<Medication> medications = [
    Medication(name: 'Aspirin', dosage: '100mg'),
    Medication(name: 'Lipitor', dosage: '20mg'),
    Medication(name: 'Metformin', dosage: '500mg'),
    Medication(name: 'Synthroid', dosage: '50mcg'),
    Medication(name: 'Lasix', dosage: '40mg'),
    Medication(name: 'Amoxicillin', dosage: '250mg'),
    Medication(name: 'Ventolin', dosage: '100mcg'),
    Medication(name: 'Zyrtec', dosage: '10mg'),
    Medication(name: 'Prozac', dosage: '20mg'),
    Medication(name: 'Norvasc', dosage: '5mg'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Medication Reminders'),
      ),
      body: medications.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.medical_information,
                    size: 140,
                    color: LightColor.marron,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text("No medications added yet.", style: TextStyles.title.bold),
                ],
              ),
            )
          : ListView.builder(
              itemCount: medications.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(medications[index].name),
                  subtitle: Text('Dosage: ${medications[index].dosage}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        medications.removeAt(index);
                      });
                    },
                  ),
                );
              },
            ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          backgroundColor: LightColor.marron,
          foregroundColor: LightColor.white,
          onPressed: () {
            _showAddMedicationDialog(context);
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Future<void> _showAddMedicationDialog(BuildContext context) async {
    TextEditingController nameController = TextEditingController();
    TextEditingController dosageController = TextEditingController();

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Medication', style: TextStyles.title.bold),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                RoundedTextField(
                  controller: nameController,
                  hint: 'Medication Name',
                  color: LightColor.marron,
                  borderColor: LightColor.marron,
                ),
                SizedBox(
                  height: 10,
                ),
                RoundedTextField(
                  controller: dosageController,
                  hint: 'Dosage',
                  color: LightColor.marron,
                  borderColor: LightColor.marron,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            buildRegisterButton(() {
              Navigator.of(context).pop();
            }, 'Cancel', textStyle: GoogleFonts.poppins(color: LightColor.white)),
            buildRegisterButton(() {
              setState(() {
                medications.add(
                  Medication(
                    name: nameController.text,
                    dosage: dosageController.text,
                  ),
                );
              });
              Navigator.of(context).pop();
            }, 'Add', textStyle: GoogleFonts.poppins(color: LightColor.white)),
          ],
        );
      },
    );
  }
}

class Medication {
  final String name;
  final String dosage;

  Medication({required this.name, required this.dosage});
}
