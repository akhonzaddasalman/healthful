import 'dart:math';

import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:healthful/Controller/Provider/symptoms_provider.dart';
import 'package:healthful/Model/symptoms_model.dart';
import 'package:healthful/View/theme/extention.dart';
import 'package:healthful/View/theme/light_color.dart';
import 'package:healthful/View/theme/text_styles.dart';
import 'package:provider/provider.dart';

class SymptomCheckerScreen extends StatefulWidget {
  const SymptomCheckerScreen({super.key});

  @override
  State<SymptomCheckerScreen> createState() => _SymptomCheckerScreenState();
}

class _SymptomCheckerScreenState extends State<SymptomCheckerScreen> {
  GlobalKey<AutoCompleteTextFieldState<String>> key = GlobalKey();
  String selectedImage = '';

  @override
  void initState() {
    super.initState();
  }

  void selectRandomImage() {
    final random = Random();
    final index = random.nextInt(images.length);
    setState(() {
      selectedImage = images[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Symptom Checker'),
      ),
      body: Consumer<SymptomProvider>(builder: (context, symptomProvider, _) {
        return Column(
          children: <Widget>[
            const SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: 55,
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(13)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: LightColor.grey.withOpacity(.3),
                      blurRadius: 15,
                      offset: const Offset(5, 5),
                    )
                  ],
                ),
                child: AutoCompleteTextField<String>(
                  key: key,
                  cursorColor: LightColor.black,
                  controller: symptomProvider.symptomController,
                  textInputAction: TextInputAction.done,
                  clearOnSubmit: false,
                  suggestions: symptoms.map((symptom) => symptom.name).toList(),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                    border: InputBorder.none,
                    hintText: "Search",
                    hintStyle: TextStyles.body.subTitleColor,
                  ),
                  itemFilter: (item, query) {
                    return item.toLowerCase().startsWith(query.toLowerCase());
                  },
                  itemSorter: (a, b) {
                    return a.compareTo(b);
                  },
                  itemSubmitted: (item) {
                    setState(() {
                      symptomProvider.symptomController.text = item;

                      symptomProvider.addSymptom(Symptom(item));
                      selectRandomImage();
                      symptomProvider.checkSymptoms();
                    });
                  },
                  itemBuilder: (context, item) {
                    return ListTile(
                      title: Text(
                        item,
                        style: const TextStyle(color: LightColor.black),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            symptomProvider.diagnoses!.isNotEmpty
                ? Expanded(
                    child: Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: LightColor.white,
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            offset: const Offset(4, 4),
                            blurRadius: 10,
                            color: LightColor.grey.withOpacity(.2),
                          ),
                          BoxShadow(
                            offset: const Offset(-3, 0),
                            blurRadius: 15,
                            color: LightColor.grey.withOpacity(.1),
                          )
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: Image.asset(selectedImage)),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            " It's seem like ${symptomProvider.diagnoses!.first.condition.toString()}",
                            style: TextStyles.bodySm.black.bold,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            symptomProvider.diagnoses!.first.recommendation.toString(),
                            style: TextStyles.bodySm.subTitleColor.black,
                          ),
                          SizedBox(
                            height: 30,
                          )
                        ],
                      ),
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                        itemCount: symptoms.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              symptomProvider.addSymptom(symptoms[index]);
                              selectRandomImage();
                              symptomProvider.symptomController.text = symptoms[index].name;
                              symptomProvider.checkSymptoms();
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30),
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: LightColor.white,
                                borderRadius: const BorderRadius.all(Radius.circular(10)),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                    offset: const Offset(4, 4),
                                    blurRadius: 10,
                                    color: LightColor.grey.withOpacity(.2),
                                  ),
                                  BoxShadow(
                                    offset: const Offset(-3, 0),
                                    blurRadius: 15,
                                    color: LightColor.grey.withOpacity(.1),
                                  )
                                ],
                              ),
                              child: Text(
                                symptoms[index].name.toString(),
                                style: TextStyles.bodySm.black.bold,
                              ),
                            ),
                          );
                        }),
                  ),
            const SizedBox(height: 10.0),
            // for (var symptom in symptoms) SymptomTile(symptom: symptom),
            // const SizedBox(height: 20.0),
            // ElevatedButton(
            //   onPressed: () {
            //     symptomProvider.checkSymptoms();
            //     print("diagnoses : " + symptomProvider.diagnoses.toString());
            //   },
            //   child: const Text('Check Symptoms'),
            // ),
            // if (symptomProvider.diagnoses != null) ...symptomProvider.diagnoses!.map((diagnosis) => DiagnosisTile(diagnosis: diagnosis)).toList(),
          ],
        );
      }),
    );
  }

  final List<String> images = [
    'assets/doctor_1.png',
    'assets/doctor_3.png',
    'assets/doctor_4.png',
    'assets/doctor.png',
    'assets/doctor_face.png',
  ];

  // List of predefined symptoms
  List<Symptom> symptoms = [
    Symptom('Fever'),
    Symptom('Cough'),
    Symptom('Headache'),
    Symptom('Fatigue'),
    Symptom('Sore throat'),
    Symptom('Muscle or body aches'),
    Symptom('Shortness of breath'),
    Symptom('Loss of taste or smell'),
    Symptom('Nasal congestion or runny nose'),
    Symptom('Nausea or vomiting'),
    Symptom('Diarrhea'),
    Symptom('Chills or sweating'),
    Symptom('Chest pain'),
    Symptom('Difficulty swallowing'),
    Symptom('Earache'),
    Symptom('Eye redness or irritation'),
    Symptom('Dizziness or lightheadedness'),
    Symptom('Rash or skin irritation'),
    Symptom('Joint pain'),
    Symptom('Abdominal pain or cramps'),
    Symptom('Constipation'),
    Symptom('Bloating or gas'),
    Symptom('Weight loss'),
    Symptom('Frequent urination'),
    Symptom('Burning sensation during urination'),
    Symptom('Blood in urine'),
    Symptom('Frequent thirst or hunger'),
    Symptom('Unexplained weight gain'),
    Symptom('Swelling in legs or ankles'),
    Symptom('Irregular heartbeat'),
    Symptom('Persistent coughing up of blood'),
    Symptom('Seizures or convulsions'),
    Symptom('Sudden numbness or weakness'),
    Symptom('Difficulty speaking or understanding speech'),
    Symptom('Blurred or double vision'),
    Symptom('Memory loss or confusion'),
    Symptom('Mood swings or changes in behavior'),
    Symptom('Persistent headaches or migraines'),
    Symptom('Unexplained fevers or night sweats'),
    Symptom('Frequent infections or illnesses'),
    Symptom('Extreme fatigue or weakness'),
    Symptom('Loss of consciousness or fainting'),
    Symptom('Difficulty breathing during exercise'),
    Symptom('Chest pain or discomfort during activity'),
    Symptom('Palpitations or rapid heart rate'),
  ];
}

class SymptomTile extends StatelessWidget {
  final Symptom symptom;

  const SymptomTile({required this.symptom});

  @override
  Widget build(BuildContext context) {
    final symptomProvider = Provider.of<SymptomProvider>(context, listen: false);
    return ListTile(
      title: Text(symptom.name),
      leading: Checkbox(
        value: symptomProvider.selectedSymptoms.contains(symptom),
        onChanged: (value) {
          symptomProvider.addSymptom(symptom);
        },
      ),
    );
  }
}

class DiagnosisTile extends StatelessWidget {
  final Diagnosis diagnosis;

  const DiagnosisTile({required this.diagnosis});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(diagnosis.condition),
      subtitle: Text(diagnosis.recommendation),
    );
  }
}
