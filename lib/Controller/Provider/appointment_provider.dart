import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:healthful/Model/appointment_model.dart';
import 'package:healthful/View/Utils/snack_bar.dart';
import 'package:healthful/View/theme/light_color.dart';

final CollectionReference appointmentsCollection = FirebaseFirestore.instance.collection('appointments');

class AppointmentProvider with ChangeNotifier {
  List<Appointment> _upcomingAppointments = [];

  List<Appointment> get upcomingAppointments => _upcomingAppointments;

  List<Appointment> _canceledAppointments = [];

  List<Appointment> get canceledAppointments => _canceledAppointments;

  List<Appointment> _completedAppointments = [];

  List<Appointment> get completedAppointments => _completedAppointments;
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void setIsLoading(bool value) {
    _isLoading = value;
    Future.microtask(() => notifyListeners());
  }

  bool _isCanceled = false;

  bool get isCanceled => _isCanceled;

  void setIsCanceled(bool value) {
    _isCanceled = value;
    Future.microtask(() => notifyListeners());
  }

  bool _isReSchedule = false;

  bool get isReSchedule => _isReSchedule;

  void setIsReSchedule(bool value) {
    _isReSchedule = value;
    Future.microtask(() => notifyListeners());
  }

  String generateRandomId(int length) {
    const chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random();
    final idList = List.generate(length, (index) => chars[random.nextInt(chars.length)]);
    return idList.join();
  }

  Future<void> addAppointment({
    required BuildContext context,
    required String doctorId,
    required String patientId,
    required String phone,
    required String doctorName,
    required String photoUrl,
    required String category,
    required String appointmentDate,
    required String appointmentTime,
  }) async {
    try {
      setIsLoading(true);

      var docId = generateRandomId(10 + Random().nextInt(11));

      // Check if appointment already exists for the current user and doctor
      QuerySnapshot existingAppointments =
          await appointmentsCollection.where('userId', isEqualTo: doctorId).where('status', isEqualTo: "canceled").get();

      if (existingAppointments.docs.isNotEmpty) {
        // If appointment exists, update the existing one
        await existingAppointments.docs.first.reference.update({
          'appointmentDate': appointmentDate,
          'appointmentTime': appointmentTime,
          'status': 'upcoming',
          'confirmation': false,
        });
        openSnackBar(context, "Your appointment has been updated successfully", Colors.green);
      } else {
        // If appointment does not exist, add a new one
        await appointmentsCollection.doc(docId).set({
          'docId': docId,
          'doctorName': doctorName,
          'photoUrl': photoUrl,
          'category': category,
          'appointmentDate': appointmentDate,
          'appointmentTime': appointmentTime,
          'status': 'upcoming',
          'doctorId': doctorId,
          'patientId': patientId,
          'phone': phone,
        });
        openSnackBar(context, "Your appointment has been scheduled successfully", Colors.green);
      }

      setIsLoading(false);
      notifyListeners();
    } catch (error) {
      // Handle error
      print("Error adding/updating appointment: $error");
      openSnackBar(context, "Error adding/updating appointment", Colors.red);
      setIsLoading(false);
    }
  }

  Future<void> fetchUpcomingAppointments(String patientId) async {
    setIsLoading(true);

    appointmentsCollection.where('status', isEqualTo: "upcoming").where('patientId', isEqualTo: patientId).snapshots().listen((querySnapshot) {
      _upcomingAppointments = querySnapshot.docs
          .map((doc) => Appointment(
                appointmentId: doc.id,
                doctorId: doc['doctorId'],
                doctorName: doc['doctorName'],
                photoUrl: doc['photoUrl'],
                category: doc['category'],
                appointmentDate: doc['appointmentDate'],
                appointmentTime: doc['appointmentTime'],
                status: doc['status'],
                phone: doc['phone'],
              ))
          .toList();

      setIsLoading(false);
      notifyListeners();
    });
  }

  Future<void> fetchCompletedAppointments(String patientId) async {
    setIsLoading(true);

    appointmentsCollection.where('status', isEqualTo: "completed").where('patientId', isEqualTo: patientId).snapshots().listen((querySnapshot) {
      _completedAppointments = querySnapshot.docs
          .map((doc) => Appointment(
                appointmentId: doc.id,
                doctorId: doc['doctorId'],
                phone: doc['phone'],
                doctorName: doc['doctorName'],
                photoUrl: doc['photoUrl'],
                category: doc['category'],
                appointmentDate: doc['appointmentDate'],
                appointmentTime: doc['appointmentTime'],
                status: doc['status'],
                rated: doc['rated'],
              ))
          .toList();

      setIsLoading(false);
      notifyListeners();
    });
  }

  Future<void> fetchCanceledAppointments(String patientId) async {
    setIsLoading(true);

    appointmentsCollection.where('status', isEqualTo: "canceled").where('patientId', isEqualTo: patientId).snapshots().listen((querySnapshot) {
      _canceledAppointments = querySnapshot.docs
          .map((doc) => Appointment(
                appointmentId: doc.id,
                doctorId: doc['doctorId'],
                phone: doc['phone'],
                doctorName: doc['doctorName'],
                photoUrl: doc['photoUrl'],
                category: doc['category'],
                appointmentDate: doc['appointmentDate'],
                appointmentTime: doc['appointmentTime'],
                status: doc['status'],
              ))
          .toList();

      setIsLoading(false);
      notifyListeners();
    });
  }

  Future<void> cancelAppointment(String appointmentId) async {
    setIsCanceled(true);
    await appointmentsCollection.doc(appointmentId).update({'status': 'canceled'});
    _upcomingAppointments.removeWhere((appointment) => appointment.appointmentId == appointmentId);
    setIsCanceled(false);
    notifyListeners();
  }

  Future<void> rescheduleAppointment(String appointmentId, String newDate, String newTime) async {
    setIsReSchedule(true);
    await appointmentsCollection.doc(appointmentId).update({
      'status': "upcoming",
      'appointmentDate': newDate,
      'appointmentTime': newTime,
    });
    setIsReSchedule(false);
    notifyListeners();
  }

  Future<void> completeTheAppointment(String appointmentId, String newDate, String newTime) async {
    setIsReSchedule(true);
    print('This is parameter data $appointmentId $newDate $newTime');
    await appointmentsCollection.doc(appointmentId).update({
      'status': "completed",
      'rated': false,
      'appointmentDate': newDate,
      'appointmentTime': newTime,
    });
    setIsReSchedule(false);
    notifyListeners();
  }

  // Future<bool> rateTheAppointment(String doctorId, String userId, double rating, String comment) async {
  //   try {
  //     setIsReSchedule(true);
  //     if (rating <= 0) {
  //       throw Exception("Rate the Appointment");
  //     }
  //
  //     DocumentReference userRef = FirebaseFirestore.instance.collection("users").doc(doctorId);
  //
  //     DocumentSnapshot user = await userRef.get();
  //     if (!user.exists) {
  //       throw Exception("User not found");
  //     }
  //
  //     Map<String, dynamic> review = {
  //       "user": userId,
  //       "rating": rating,
  //       "comment": comment,
  //       "timestamp": FieldValue.serverTimestamp(),
  //     };
  //
  //     await userRef.collection("reviews").add(review);
  //
  //     // Update the listing's "numReviews" field and "rating" field
  //     QuerySnapshot reviewsSnapshot = await userRef.collection("reviews").get();
  //     int numReviews = reviewsSnapshot.docs.length;
  //     double totalRating =
  //         reviewsSnapshot.docs.map((reviewDoc) => reviewDoc["rating"] as double).fold(0, (previousValue, rating) => previousValue + rating);
  //     double updatedRating = totalRating / numReviews;
  //     await userRef.update({
  //       "numReviews": numReviews,
  //       "rating": updatedRating,
  //     });
  //
  //     await appointmentsCollection.doc(doctorId).update({
  //       'rated': true,
  //     });
  //     setIsReSchedule(false);
  //     notifyListeners();
  //     return true;
  //   } catch (error) {
  //     print(error);
  //     setIsReSchedule(false);
  //     notifyListeners();
  //     return false;
  //   }
  // }

  Future<bool> rateTheAppointment(BuildContext context, String doctorId, String userId, String appointmentId, double rating, String comment) async {
    try {
      setIsReSchedule(true);

      // Ensure the rating is within a valid range
      if (rating <= 0 || rating > 5) {
        openSnackBar(context, "Rating should be between 1 and 5", LightColor.warning);
        throw Exception("Rating should be between 1 and 5");
      }

      // Reference to the doctor's document
      print('doctor id $doctorId');
      print('user id $userId');
      DocumentReference doctorRef = FirebaseFirestore.instance.collection("users").doc(doctorId);

      // Check if the doctor exists
      DocumentSnapshot doctorSnapshot = await doctorRef.get();
      if (!doctorSnapshot.exists) {
        openSnackBar(context, "Doctor not found", LightColor.warning);
        throw Exception("Doctor not found");
      }
      print('1');
      // Create a new review object
      Map<String, dynamic> review = {
        "user": userId,
        "rating": rating,
        "comment": comment,
        "timestamp": FieldValue.serverTimestamp(),
      };

      // Add the review to the doctor's reviews sub-collection
      await doctorRef.collection("reviews").add(review);
      print('2');
      // Calculate the updated average rating
      QuerySnapshot reviewsSnapshot = await doctorRef.collection("reviews").get();
      int numReviews = reviewsSnapshot.docs.length;
      double totalRating = reviewsSnapshot.docs.map((reviewDoc) => reviewDoc["rating"] as double).fold(0, (a, b) => a + b);
      double updatedRating = totalRating / numReviews;
      print('3');
      int goodReviewsCount = 0;
      for (QueryDocumentSnapshot reviewDoc in reviewsSnapshot.docs) {
        double rating = reviewDoc['rating'];
        if (rating == 5) {
          goodReviewsCount++;
        }
      }

      print('4');
      // Calculate the percentage of good reviews
      double goodReviewsPercentage = (goodReviewsCount / numReviews.toDouble()) * 100;

      // Update the doctor's document with the new rating and number of reviews
      await doctorRef.update({
        "totalReviews": numReviews,
        "averageRating": updatedRating.toStringAsFixed(1),
        "goodReviews": goodReviewsPercentage.toStringAsFixed(1),
      });
      print('5');
      // Mark the appointment as rated
      await appointmentsCollection.doc(appointmentId).update({
        'rated': true,
      });
      print('6');
      setIsReSchedule(false);
      notifyListeners();
      return true; // Success
    } catch (error) {
      print("error : $error");
      setIsReSchedule(false);
      notifyListeners();
      return false; // Failure
    }
  }
}
