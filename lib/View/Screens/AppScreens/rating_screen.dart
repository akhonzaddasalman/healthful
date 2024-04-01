import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:healthful/Controller/Provider/appointment_provider.dart';
import 'package:healthful/Controller/Provider/authentication_provider.dart';
import 'package:healthful/Model/appointment_model.dart';
import 'package:healthful/View/Utils/next_screen.dart';
import 'package:healthful/View/theme/extention.dart';
import 'package:healthful/View/theme/light_color.dart';
import 'package:healthful/View/theme/text_styles.dart';
import 'package:healthful/View/theme/theme.dart';
import 'package:healthful/View/widgets/text_field.dart';
import 'package:provider/provider.dart';

class RatingScreen extends StatefulWidget {
  const RatingScreen({super.key, required this.doctor});
  final Appointment doctor;

  @override
  _RatingScreenState createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  TextEditingController reviewController = TextEditingController();
  double ratingValue = 2.5;
  double _satisfactionScore = 0;
  Appointment? doctor;
  @override
  void initState() {
    doctor = widget.doctor;
    super.initState();
  }

  Widget _appbar() {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          BackButton(color: Theme.of(context).primaryColor),
          // IconButton(
          //     icon: Icon(
          //       doctor!.isfavourite ? Icons.favorite : Icons.favorite_border,
          //       color: doctor!.isfavourite ? Colors.red : LightColor.grey,
          //     ),
          //     onPressed: () {
          //       setState(() {
          //         doctor!.isfavourite = !doctor!.isfavourite;
          //       });
          //     })
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final sp = context.watch<AuthProvider>();
    TextStyle titleStyle = TextStyles.title.copyWith(fontSize: 25).bold;
    if (AppTheme.fullWidth(context) < 393) {
      titleStyle = TextStyles.title.copyWith(fontSize: 23).bold;
    }
    return Scaffold(
      backgroundColor: LightColor.extraLightBlue,
      body: Stack(
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.43,
            child: Image.network(
              doctor!.photoUrl.toString(),
              fit: BoxFit.cover,
            ),
          ),
          DraggableScrollableSheet(
            maxChildSize: .8,
            initialChildSize: .6,
            minChildSize: .6,
            builder: (context, scrollController) {
              return Container(
                height: AppTheme.fullHeight(context) * .5,
                padding: const EdgeInsets.only(left: 19, right: 19, top: 16), //symmetric(horizontal: 19, vertical: 16),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                  color: Colors.white,
                ),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  controller: scrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ListTile(
                        contentPadding: const EdgeInsets.all(0),
                        title: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              doctor!.doctorName.toString(),
                              style: titleStyle,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Icon(Icons.check_circle, size: 18, color: Theme.of(context).primaryColor),
                            const Spacer(),
                          ],
                        ),
                        subtitle: Text(
                          doctor!.category.toString(),
                          style: TextStyles.bodySm.subTitleColor.bold,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 18.0),
                        child: Divider(
                          thickness: .3,
                          color: LightColor.grey,
                        ),
                      ),
                      Text(
                        "How You Find The Doctor:",
                        style: TextStyles.title.copyWith(fontSize: 18).black,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 28.0),
                        child: Center(
                          child: RatingBar.builder(
                            initialRating: 0.5,
                            minRating: 0.2,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: 40,
                            itemPadding: const EdgeInsets.symmetric(horizontal: 3.0),
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                              print(rating);
                              ratingValue = rating;
                              setState(() {});
                            },
                          ),
                        ),
                      ),
                      // Text(
                      //   "Rate Your Satisfaction From Doctor:",
                      //   style: TextStyles.title.copyWith(fontSize: 18).black,
                      // ),
                      // const SizedBox(height: 10.0),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(vertical: 28.0),
                      //   child: Center(
                      //     child: RatingBar.builder(
                      //       initialRating: 2.5,
                      //       minRating: 0.2,
                      //       direction: Axis.horizontal,
                      //       allowHalfRating: true,
                      //       itemCount: 5,
                      //       itemSize: 40,
                      //       itemPadding: const EdgeInsets.symmetric(horizontal: 3.0),
                      //       itemBuilder: (context, _) => const Icon(
                      //         Icons.star,
                      //         color: Colors.amber,
                      //       ),
                      //       onRatingUpdate: (rating) {
                      //         print(rating);
                      //         _satisfactionScore = rating;
                      //         setState(() {});
                      //       },
                      //     ),
                      //   ),
                      // ),

                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: RoundedTextField(
                          controller: reviewController,
                          hint: 'Write a Review',
                          color: Colors.transparent,
                          borderColor: Colors.transparent,
                          maxLine: 6,
                        ),
                      ),
                      const SizedBox(height: 30.0),
                      Consumer<AppointmentProvider>(builder: (context, appointmentProvider, _) {
                        return InkWell(
                          onTap: () {
                            DateTime currentDate = DateTime.now();

                            String formattedDate = '${currentDate.month.toString().padLeft(2, '0')}/'
                                '${currentDate.day.toString().padLeft(2, '0')}/'
                                '${currentDate.year.toString()}';
                            TimeOfDay currentTime = TimeOfDay.now();
                            String formattedTime = '${currentTime.hourOfPeriod.toString().padLeft(2, '0')}:'
                                '${currentTime.minute.toString().padLeft(2, '0')} '
                                '${currentTime.period == DayPeriod.am ? 'AM' : 'PM'}';
                            print("Date $formattedDate Time $formattedTime");
                            appointmentProvider
                                .rateTheAppointment(context, doctor!.doctorId.toString(), sp.uid.toString(), doctor!.appointmentId, ratingValue,
                                    reviewController.text)
                                .then((value) {
                              if (value) {
                                nextScreenRemoveUntil(context, "/home");
                              }
                            });
                          },
                          child: Container(
                            width: double.infinity,
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
                                      "Submit Ratings",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                    ),
                            ),
                          ),
                        );
                      })
                    ],
                  ),
                ),
              );
            },
          ),
          _appbar(),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:healthful/Controller/Provider/appointment_provider.dart';
// import 'package:healthful/View/theme/light_color.dart';
// import 'package:provider/provider.dart';
//
// class RatingScreen extends StatefulWidget {
//   const RatingScreen({super.key});
//
//   @override
//   _RatingScreenState createState() => _RatingScreenState();
// }
//
// class _RatingScreenState extends State<RatingScreen> {
//   double ratingValue = 2.5;
//   double _satisfactionScore = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Rate Doctor'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             const Text(
//               'Rate the Doctor:',
//               style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 10.0),
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 28.0),
//               child: Center(
//                 child: RatingBar.builder(
//                   initialRating: 2.5,
//                   minRating: 0.2,
//                   direction: Axis.horizontal,
//                   allowHalfRating: true,
//                   itemCount: 5,
//                   itemSize: 50,
//                   itemPadding: const EdgeInsets.symmetric(horizontal: 3.0),
//                   itemBuilder: (context, _) => const Icon(
//                     Icons.star,
//                     color: Colors.amber,
//                   ),
//                   onRatingUpdate: (rating) {
//                     print(rating);
//                     ratingValue = rating;
//                     setState(() {});
//                   },
//                 ),
//               ),
//             ),
//             const Text(
//               'Rate Your Satisfaction:',
//               style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 10.0),
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 28.0),
//               child: Center(
//                 child: RatingBar.builder(
//                   initialRating: 2.5,
//                   minRating: 0.2,
//                   direction: Axis.horizontal,
//                   allowHalfRating: true,
//                   itemCount: 5,
//                   itemSize: 50,
//                   itemPadding: const EdgeInsets.symmetric(horizontal: 3.0),
//                   itemBuilder: (context, _) => const Icon(
//                     Icons.star,
//                     color: Colors.amber,
//                   ),
//                   onRatingUpdate: (rating) {
//                     print(rating);
//                     _satisfactionScore = rating;
//                     setState(() {});
//                   },
//                 ),
//               ),
//             ),
//             const SizedBox(height: 30.0),
//             ElevatedButton(
//               onPressed: () {
//                 // Implement logic to submit ratings
//               },
//               child: const Text('Submit Ratings'),
//             ),
//             Consumer<AppointmentProvider>(builder: (context, appointmentProvider, _) {
//               return InkWell(
//                 onTap: () {
//                   DateTime currentDate = DateTime.now();
//
//                   String formattedDate = '${currentDate.month.toString().padLeft(2, '0')}/'
//                       '${currentDate.day.toString().padLeft(2, '0')}/'
//                       '${currentDate.year.toString()}';
//                   TimeOfDay currentTime = TimeOfDay.now();
//                   String formattedTime = '${currentTime.hourOfPeriod.toString().padLeft(2, '0')}:'
//                       '${currentTime.minute.toString().padLeft(2, '0')} '
//                       '${currentTime.period == DayPeriod.am ? 'AM' : 'PM'}';
//                   print("Date $formattedDate Time $formattedTime");
//                   //appointmentProvider.rescheduleAppointment(doctorData[index].id, formattedDate.toString(), formattedTime.toString());
//                 },
//                 child: Container(
//                   width: double.infinity,
//                   padding: const EdgeInsets.symmetric(
//                     vertical: 12,
//                   ),
//                   margin: const EdgeInsets.symmetric(
//                     horizontal: 10,
//                   ),
//                   decoration: BoxDecoration(
//                     color: Colors.green,
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Center(
//                     child: appointmentProvider.isReSchedule
//                         ? const SpinKitThreeBounce(
//                             color: LightColor.white,
//                             size: 30.0,
//                           )
//                         : const Text(
//                             "Rate Appointment",
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.w500,
//                               color: Colors.white,
//                             ),
//                           ),
//                   ),
//                 ),
//               );
//             }),
//           ],
//         ),
//       ),
//     );
//   }
// }
