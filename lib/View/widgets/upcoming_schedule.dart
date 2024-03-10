import 'package:flutter/material.dart';

class UpcomingSchedule extends StatelessWidget {
  UpcomingSchedule({super.key});

  List<DoctorData> doctorData = [
    DoctorData(
      name: "Dr. Smith",
      speciality: "General Physician",
      status: "Confirmed",
      time: "10:30 AM",
      date: "02/25/2024",
      photoUrl: "assets/doctor.png",
    ),
    DoctorData(
      name: "Dr. John",
      speciality: "Pysic Physician",
      status: "Confirmed",
      time: "10:30 AM",
      date: "06/25/2024",
      photoUrl: "assets/doctor_1.png",
    ),
    DoctorData(
      name: "Dr. Salman",
      speciality: "Health Physician",
      status: "Confirmed",
      time: "10:30 AM",
      date: "08/25/2024",
      photoUrl: "assets/doctor_3.png",
    ),
    DoctorData(
      name: "Dr. Bush",
      speciality: "General Physician",
      status: "Confirmed",
      time: "10:30 AM",
      date: "03/25/2024",
      photoUrl: "assets/doctor_4.png",
    ),
    DoctorData(
      name: "Dr. Smith",
      speciality: "General Physician",
      status: "Confirmed",
      time: "10:30 AM",
      date: "02/25/2024",
      photoUrl: "assets/doctor.png",
    ),
    DoctorData(
      name: "Dr. John",
      speciality: "Pysic Physician",
      status: "Confirmed",
      time: "10:30 AM",
      date: "06/25/2024",
      photoUrl: "assets/doctor_1.png",
    ),
    DoctorData(
      name: "Dr. Salman",
      speciality: "Health Physician",
      status: "Confirmed",
      time: "10:30 AM",
      date: "08/25/2024",
      photoUrl: "assets/doctor_3.png",
    ),
    DoctorData(
      name: "Dr. Bush",
      speciality: "General Physician",
      status: "Confirmed",
      time: "10:30 AM",
      date: "03/25/2024",
      photoUrl: "assets/doctor_4.png",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "About Doctor",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 15),
          Container(
            height: MediaQuery.of(context).size.height * 0.57,
            padding: const EdgeInsets.symmetric(horizontal: 2),
            decoration: BoxDecoration(
              color: const Color(0xFFF4F6FA),
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListView.builder(
                itemCount: doctorData.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          spreadRadius: 2,
                        )
                      ],
                    ),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          ListTile(
                            title: Text(
                              doctorData[index].name.toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(doctorData[index].speciality.toString()),
                            trailing: CircleAvatar(
                              radius: 25,
                              backgroundImage: AssetImage(doctorData[index].photoUrl.toString()),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Divider(
                              thickness: 1,
                              height: 20,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.calendar_month,
                                    color: Colors.black54,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    doctorData[index].date.toString(),
                                    style: TextStyle(
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.access_time_filled,
                                    color: Colors.black54,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    doctorData[index].time.toString(),
                                    style: TextStyle(
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: const BoxDecoration(
                                      color: Colors.green,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  const Text(
                                    "Confirmed",
                                    style: TextStyle(
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                onTap: () {},
                                child: Container(
                                  width: 150,
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF4F6FA),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      "Cancel",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {},
                                child: Container(
                                  width: 150,
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(255, 133, 41, 41),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      "Rechedule",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}

class DoctorData {
  final String name;
  final String speciality;
  final String status;
  final String time;
  final String date;
  final String photoUrl;

  DoctorData({
    required this.name,
    required this.speciality,
    required this.status,
    required this.time,
    required this.date,
    required this.photoUrl,
  });
}
