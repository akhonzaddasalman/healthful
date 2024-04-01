import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:healthful/Controller/Provider/appointment_provider.dart';
import 'package:healthful/View/Screens/AppScreens/message_screen.dart';
import 'package:healthful/View/Screens/AppScreens/rating_screen.dart';
import 'package:healthful/View/Utils/next_screen.dart';
import 'package:healthful/View/theme/extention.dart';
import 'package:healthful/View/theme/light_color.dart';
import 'package:healthful/View/widgets/progress_widget.dart';
import 'package:provider/provider.dart';

import '../../Controller/Functions/make_phone_call.dart';

class CompletedAppointments extends StatelessWidget {
  const CompletedAppointments({
    super.key,
  });

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
            child: Consumer<AppointmentProvider>(builder: (context, appointmentProvider, _) {
              if (appointmentProvider.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: LightColor.marron,
                  ),
                );
              }
              return ListView.builder(
                  itemCount: appointmentProvider.completedAppointments.length,
                  itemBuilder: (context, index) {
                    final doctorData = appointmentProvider.completedAppointments;
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.all(Radius.circular(20)),
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
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(
                                doctorData[index].doctorName.toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(doctorData[index].category.toString()),
                              trailing: CircleAvatar(
                                radius: 25,
                                backgroundImage: NetworkImage(doctorData[index].photoUrl.toString()),
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
                                    const Icon(
                                      Icons.calendar_month,
                                      color: Colors.black54,
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      doctorData[index].appointmentDate.toString(),
                                      style: const TextStyle(
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.access_time_filled,
                                      color: Colors.black54,
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      doctorData[index].appointmentTime.toString(),
                                      style: const TextStyle(
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: appointmentProvider.completedAppointments[index].rated ? 25 : 15),
                            appointmentProvider.completedAppointments[index].rated
                                ? StreamBuilder<QuerySnapshot>(
                                    stream: FirebaseFirestore.instance
                                        .collection('users')
                                        .where("uid", isEqualTo: doctorData[index].doctorId.toString())
                                        .snapshots(),
                                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                      if (snapshot.hasError) {
                                        return Text('Error: ${snapshot.error}');
                                      }

                                      if (snapshot.connectionState == ConnectionState.waiting) {
                                        return const Center(
                                            child: CircularProgressIndicator(
                                          color: LightColor.marron,
                                        ));
                                      }
                                      final Map<String, dynamic> data = snapshot.data!.docs.first.data() as Map<String, dynamic>;
                                      String goodReviewsString = data['goodReviews'];
                                      int totalReviewsString = data['totalReviews'];
                                      double goodReviews = double.parse(goodReviewsString);
                                      double totalReviews = double.parse(totalReviewsString.toString());

                                      return Row(
                                        children: <Widget>[
                                          ProgressWidget(
                                              value: goodReviews,
                                              totalValue: 100,
                                              activeColor: LightColor.marronExtraLight,
                                              backgroundColor: LightColor.grey.withOpacity(.3),
                                              title: "Good Review",
                                              durationTime: 500),
                                          ProgressWidget(
                                              value: totalReviews,
                                              totalValue: 1000,
                                              activeColor: LightColor.marronLight,
                                              backgroundColor: LightColor.grey.withOpacity(.3),
                                              title: "Total Reviews",
                                              durationTime: 300),
                                          ProgressWidget(
                                              value: double.parse(data['averageRating']),
                                              totalValue: 100,
                                              activeColor: LightColor.marron,
                                              backgroundColor: LightColor.grey.withOpacity(.3),
                                              title: "Satisfaction",
                                              durationTime: 800),
                                        ],
                                      );
                                    })
                                : Consumer<AppointmentProvider>(builder: (context, appointmentProvider, _) {
                                    return Row(
                                      children: [
                                        const SizedBox(width: 10),
                                        Container(
                                          height: 40,
                                          width: 40,
                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: LightColor.grey.withAlpha(150)),
                                          child: const Icon(
                                            Icons.call,
                                            color: Colors.white,
                                          ),
                                        ).ripple(
                                          () {
                                            print('phone number is ${doctorData[index].phone}');
                                            callNumber(doctorData[index].phone);
                                          },
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          height: 40,
                                          width: 40,
                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: LightColor.grey.withAlpha(150)),
                                          child: const Icon(
                                            Icons.chat_bubble,
                                            color: Colors.white,
                                          ),
                                        ).ripple(
                                          () {
                                            nextScreen(
                                                context,
                                                MessagesScreen(
                                                  doctorId: doctorData[index].doctorId,
                                                  doctorName: doctorData[index].doctorName,
                                                  doctorImage: doctorData[index].photoUrl,
                                                  doctorPhone: doctorData[index].phone,
                                                  appointmentId: doctorData[index].appointmentId,
                                                ));
                                          },
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              nextScreen(
                                                  context,
                                                  RatingScreen(
                                                    doctor: doctorData[index],
                                                  ));
                                            },
                                            child: Container(
                                              width: 120,
                                              padding: const EdgeInsets.symmetric(
                                                vertical: 12,
                                              ),
                                              margin: const EdgeInsets.symmetric(
                                                horizontal: 10,
                                              ),
                                              decoration: BoxDecoration(
                                                color: Colors.green,
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                              child: Center(
                                                child: appointmentProvider.isReSchedule
                                                    ? const SpinKitThreeBounce(
                                                        color: LightColor.white,
                                                        size: 30.0,
                                                      )
                                                    : const Text(
                                                        "Rate Appointment",
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight: FontWeight.w500,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  }),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                    );
                  });
            }),
          ),
        ],
      ),
    );
  }
}
