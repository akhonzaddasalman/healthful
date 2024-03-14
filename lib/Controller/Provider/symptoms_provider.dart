// symptom_provider.dart
import 'package:flutter/material.dart';

import '../../Model/symptoms_model.dart';

class SymptomProvider extends ChangeNotifier {
  TextEditingController symptomController = TextEditingController();
  final List<Symptom> _selectedSymptoms = [];
  final List<Diagnosis> _diagnoses = [];

  List<Symptom> get selectedSymptoms => _selectedSymptoms;
  List<Diagnosis>? get diagnoses => _diagnoses; // Getter for diagnoses

  void addSymptom(Symptom symptom) {
    _selectedSymptoms.clear();
    _selectedSymptoms.add(symptom);
    Future.microtask(() => notifyListeners());
  }

  void checkSymptoms() {
    final Map<List<Symptom>, List<Diagnosis>> symptomData = {
      [Symptom('Fever'), Symptom('Cough')]: [
        Diagnosis('Common Cold', 'Get plenty of rest and drink fluids.'),
        Diagnosis('Flu', 'See a doctor for further evaluation and treatment.'),
      ],
      [Symptom('Headache'), Symptom('Fatigue')]: [
        Diagnosis('Stress', 'Practice relaxation techniques and consider therapy.'),
        Diagnosis('Dehydration', 'Drink plenty of water and rest.'),
      ],
      [Symptom('Sore throat'), Symptom('Muscle or body aches')]: [
        Diagnosis('Flu', 'See a doctor for further evaluation and treatment.'),
        Diagnosis('Strep Throat', 'See a doctor for a strep test and antibiotics if necessary.'),
      ],
      [Symptom('Shortness of breath'), Symptom('Loss of taste or smell')]: [
        Diagnosis('COVID-19',
            'Isolate yourself from others and follow guidelines from health authorities. Seek medical attention if symptoms worsen or if you have trouble breathing.'),
        Diagnosis('Sinus Infection', 'Use saline nasal spray and over-the-counter medications for symptom relief.'),
      ],
      [Symptom('Diarrhea'), Symptom('Nausea')]: [
        Diagnosis('Gastroenteritis', 'Stay hydrated and rest. Avoid solid foods until symptoms subside.'),
        Diagnosis('Food Poisoning', 'Stay hydrated and rest. Avoid solid foods until symptoms subside. See a doctor if symptoms persist.'),
      ],
      [Symptom('Joint pain'), Symptom('Rash')]: [
        Diagnosis('Lupus', 'See a rheumatologist for further evaluation and treatment.'),
        Diagnosis('Allergic reaction', 'Take antihistamines and avoid allergens. See a doctor if symptoms worsen.'),
      ],
      [Symptom('Chest pain'), Symptom('Shortness of breath')]: [
        Diagnosis('Heart attack', 'Call emergency services immediately and seek medical attention.'),
        Diagnosis('Pulmonary embolism', 'Go to the emergency room immediately for evaluation and treatment.'),
      ],
      [Symptom('Abdominal pain'), Symptom('Vomiting')]: [
        Diagnosis('Appendicitis', 'Go to the emergency room immediately for evaluation and potential surgery.'),
        Diagnosis('Gastroenteritis', 'Stay hydrated and rest. Avoid solid foods until symptoms subside.'),
      ],
      [Symptom('Back pain'), Symptom('Numbness or tingling')]: [
        Diagnosis('Herniated disc', 'See an orthopedist or spine specialist for further evaluation and treatment.'),
        Diagnosis('Sciatica', 'Use heat or ice packs and consider physical therapy. See a doctor if symptoms persist.'),
      ],
      [Symptom('Frequent urination'), Symptom('Burning sensation when urinating')]: [
        Diagnosis('Urinary tract infection (UTI)', 'Drink plenty of water and see a doctor for antibiotics.'),
        Diagnosis('Kidney stones', 'Stay hydrated and manage pain with over-the-counter medications. See a doctor if symptoms persist.'),
      ],
      [Symptom('Dizziness'), Symptom('Nausea')]: [
        Diagnosis('Vertigo', 'Avoid sudden movements and lie down. See a doctor if symptoms persist.'),
        Diagnosis('Motion sickness', 'Try to focus on a fixed point and consider over-the-counter medications.'),
      ],
      [Symptom('Difficulty breathing'), Symptom('Wheezing')]: [
        Diagnosis('Asthma exacerbation', 'Use prescribed inhalers and seek medical attention if symptoms worsen.'),
        Diagnosis('Bronchitis', 'Stay hydrated and rest. Use a humidifier to ease coughing. See a doctor if symptoms persist.'),
      ],
      [Symptom('Frequent headaches'), Symptom('Visual disturbances')]: [
        Diagnosis('Migraine with aura',
            'Rest in a quiet, dark room and use over-the-counter pain relievers. Consider prescription medications if symptoms persist.'),
        Diagnosis('Ocular migraine', 'Rest in a quiet, dark room and use over-the-counter pain relievers. See an eye doctor for further evaluation.'),
      ],
      [Symptom('Chest tightness'), Symptom('Coughing up blood')]: [
        Diagnosis('Pulmonary embolism', 'Go to the emergency room immediately for evaluation and treatment.'),
        Diagnosis('Pneumonia', 'See a doctor immediately for evaluation and treatment.'),
      ],
      [Symptom('Excessive thirst'), Symptom('Frequent urination')]: [
        Diagnosis('Diabetes mellitus',
            'Monitor your blood sugar levels regularly and follow a balanced diet. See a doctor for prescribed medications if necessary.'),
        Diagnosis('Diabetes insipidus', 'See an endocrinologist for further evaluation and treatment.'),
      ],
      [Symptom('Unexplained weight loss'), Symptom('Loss of appetite')]: [
        Diagnosis('Hyperthyroidism', 'Follow a healthy diet and lifestyle. See an endocrinologist for further evaluation and treatment.'),
        Diagnosis('Cancer', 'See a doctor for further evaluation and testing.'),
      ],
      [Symptom('Swollen lymph nodes'), Symptom('Night sweats')]: [
        Diagnosis('Infection', 'See a doctor for evaluation and possible antibiotic treatment if necessary.'),
        Diagnosis('Lymphoma', 'See an oncologist for further evaluation and treatment.'),
      ],
      [Symptom('Difficulty swallowing'), Symptom('Hoarse voice')]: [
        Diagnosis('Esophageal stricture', 'See a gastroenterologist for further evaluation and treatment.'),
        Diagnosis('Laryngitis', 'Rest your voice and stay hydrated. Consider throat lozenges for symptom relief.'),
      ],
      [Symptom('Confusion'), Symptom('Memory loss')]: [
        Diagnosis('Alzheimer\'s Disease', 'Stay mentally and socially active. See a neurologist for further evaluation and treatment.'),
        Diagnosis('Dementia', 'See a doctor for further evaluation and management of symptoms.'),
      ],
      [Symptom('Severe abdominal pain'), Symptom('Bloody stool')]: [
        Diagnosis('Gastrointestinal bleeding', 'Go to the emergency room immediately for evaluation and treatment.'),
        Diagnosis('Inflammatory bowel disease', 'See a gastroenterologist for further evaluation and treatment.'),
      ],
    };

    // [Symptom('Severe abdominal pain'), Symptom('Bloody stool')]: [
    // Diagnosis('Gastrointestinal bleeding', 'Go to the emergency room immediately for evaluation and treatment.'),
    // Diagnosis('Inflammatory bowel disease', 'See a gastroenterologist for further evaluation and treatment.'),
    // ],
    // Find potential diagnoses based on selected symptoms
    _diagnoses.clear(); // Clear previous diagnoses
    //print('This is add data ${symptomData}');
    for (var entry in symptomData.entries) {
      var matched = false;
      for (var symptom in entry.key) {
        print('This is add data ');
        if (selectedSymptoms.first.name == symptom.name) {
          matched = true;
          print('Data matched ${selectedSymptoms[0].name} = ${symptom.name}');
          break;
        }
      }
      if (matched) {
        _diagnoses.addAll(entry.value);
        print('This is add data 2 ${diagnoses?[0].recommendation.toString()} ${diagnoses?[1].recommendation.toString()}');
      }
    }

    // try {
    //   for (var symptomsList in symptomData.keys) {
    //     print('This is add data 1');
    //
    //     if (selectedSymptoms.every((symptom) => symptomsList.contains(symptom))) {
    //       print('This is add data  ${selectedSymptoms.first.name.toString()}');
    //       _diagnoses.addAll(symptomData[symptomsList]!);
    //     }
    //   }
    // } catch (error) {
    //   print('Error during symptom check: $error');
    //   // Optionally handle the error more gracefully, e.g., by providing a user-friendly message
    // }

    notifyListeners();
  }
}
