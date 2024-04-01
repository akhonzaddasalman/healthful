import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:healthful/Model/medication_model.dart';

class MedicationProvider with ChangeNotifier {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    Future.microtask(() => notifyListeners());
  }

  Future<void> addMedication(String patientId, String name, String dosage) async {
    try {
      setLoading(true);
      TimeOfDay currentTime = TimeOfDay.now();
      String formattedTime = '${currentTime.hourOfPeriod.toString().padLeft(2, '0')}:'
          '${currentTime.minute.toString().padLeft(2, '0')} '
          '${currentTime.period == DayPeriod.am ? 'AM' : 'PM'}';
      print("Dosage Time $formattedTime");
      await _firestore.collection('medications').add({
        'patientId': patientId,
        'name': name,
        'dosage': dosage,
        'dosageTime': formattedTime,
      });
      setLoading(false);
      notifyListeners();
    } catch (e) {
      print("Error adding medication: $e");
    }
  }

  Future<void> removeMedication(String medicationId) async {
    try {
      await _firestore.collection('medications').doc(medicationId).delete();
      notifyListeners();
    } catch (e) {
      print("Error removing medication: $e");
    }
  }

  Stream<List<Medication>> getMedicationsStream(String patientId) {
    return _firestore.collection('medications').where("patientId", isEqualTo: patientId).snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Medication(id: doc.id, name: doc['name'], dosage: doc['dosage'], dosageTime: doc['dosageTime'])).toList());
  }
}
