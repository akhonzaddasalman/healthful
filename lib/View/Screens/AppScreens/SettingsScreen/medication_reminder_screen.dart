import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthful/Controller/Provider/authentication_provider.dart';
import 'package:healthful/Controller/Provider/medication_provider.dart';
import 'package:healthful/Model/medication_model.dart';
import 'package:healthful/View/Components/build_buttons.dart';
import 'package:healthful/View/theme/extention.dart';
import 'package:healthful/View/theme/light_color.dart';
import 'package:healthful/View/theme/text_styles.dart';
import 'package:healthful/View/widgets/text_field.dart';
import 'package:provider/provider.dart';

class MedicationReminderPage extends StatefulWidget {
  const MedicationReminderPage({super.key});

  @override
  _MedicationReminderPageState createState() => _MedicationReminderPageState();
}

class _MedicationReminderPageState extends State<MedicationReminderPage> {
  @override
  Widget build(BuildContext context) {
    final sp = context.read<AuthProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Medication Reminders'),
      ),
      body: StreamBuilder<List<Medication>>(
        stream: Provider.of<MedicationProvider>(context).getMedicationsStream(sp.uid.toString()),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.medical_information,
                    size: 140,
                    color: LightColor.marron,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text("No medications added yet.", style: TextStyles.title.bold),
                ],
              ),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final medication = snapshot.data![index];
              return ListTile(
                title: Text(medication.name),
                subtitle: Text('Dosage: ${medication.dosage}'),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    Provider.of<MedicationProvider>(context, listen: false).removeMedication(medication.id);
                  },
                ),
              );
            },
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
    final sp = context.read<AuthProvider>();
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
                const SizedBox(
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
            }, Text('Cancel', style: GoogleFonts.poppins(color: LightColor.white))),
            Consumer<MedicationProvider>(builder: (context, MedicationProvider medicationProvider, child) {
              return buildRegisterButton(() {
                final name = nameController.text.trim();
                final dosage = dosageController.text.trim();
                if (name.isNotEmpty && dosage.isNotEmpty) {
                  medicationProvider.addMedication(sp.uid.toString(), name, dosage);
                  Navigator.of(context).pop();
                }
              },
                  medicationProvider.isLoading
                      ? const SpinKitThreeBounce(
                          color: LightColor.white,
                          size: 30.0,
                        )
                      : Text('Add', style: GoogleFonts.poppins(color: LightColor.white)));
            }),
          ],
        );
      },
    );
  }
}
