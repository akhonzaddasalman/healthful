class Appointment {
  final String appointmentId;
  final String doctorId;
  final String doctorName;
  final String photoUrl;
  final String category;
  final String phone;
  final String appointmentDate;
  final String appointmentTime;
  final String status;
  bool rated;

  Appointment({
    required this.appointmentId,
    required this.doctorId,
    required this.doctorName,
    required this.photoUrl,
    required this.category,
    required this.appointmentDate,
    required this.appointmentTime,
    required this.status,
    required this.phone,
    this.rated = false,
  });
}
