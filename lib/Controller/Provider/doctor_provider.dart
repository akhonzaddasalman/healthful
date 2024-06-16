import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:healthful/Model/doctor_model.dart';

class DoctorProvider with ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void setIsLoading(bool value) {
    _isLoading = value;
    Future.microtask(() => notifyListeners());
  }

  bool _isAscending = false;

  bool get isAscending => _isAscending;

  void setAscending(bool value) {
    _isAscending = value;
    Future.microtask(() => notifyListeners());
  }

  List<DoctorModel> _doctors = [];

  List<DoctorModel> get doctors => _doctors;

  String _searchQuery = '';

  String get searchQuery => _searchQuery;

  set searchQuery(String query) {
    _searchQuery = query;
    Future.microtask(() => notifyListeners());
  }

  Future<void> fetchDoctors(String doctorId) async {
    try {
      _doctors.clear();
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('users').where("uid", isNotEqualTo: doctorId).where("type", isEqualTo: 'doctor').get();
      print(doctors);
      _doctors = querySnapshot.docs
          .map((doc) => DoctorModel(
                id: doc['uid'],
                name: doc['name'],
                phone: doc['phone'],
                type: doc['type'],
                category: doc['category'],
                about: doc['about'],
        goodReviews: (doc.data() as Map<String,dynamic>).containsKey('goodReviews') && doc['goodReviews'] != null ? double.parse(doc['goodReviews']) : 0.0,
        image: doc['image_url'],
        totalReviews: (doc.data() as Map<String,dynamic>).containsKey('totalReviews') && doc['totalReviews'] != null ? doc['totalReviews'] : 0,
        averageRating: (doc.data() as Map<String,dynamic>).containsKey('averageRating') && doc['averageRating'] != null ? double.parse(doc['averageRating']) : 0.0,
      ))
          .toList();
      print(doctors);
      notifyListeners();
    } catch (e) {
      print("Error fetching doctors: $e");
    }
  }

  void sortDoctorsByNameAscending() {
    _doctors.sort((a, b) => a.name.compareTo(b.name));
    setAscending(true);
    notifyListeners();
  }

  void sortDoctorsByNameDescending() {
    _doctors.sort((a, b) => b.name.compareTo(a.name));
    setAscending(false);
    notifyListeners();
  }

  void filterDoctors() {
    _doctors = _doctors.where((doctor) {
      final doctorName = doctor.name.toLowerCase();
      final doctorCategory = doctor.category.toLowerCase();
      final queryLowerCase = _searchQuery.toLowerCase();
      return doctorName.contains(queryLowerCase) || doctorCategory.contains(queryLowerCase);
    }).toList();
    notifyListeners();
  }
}
