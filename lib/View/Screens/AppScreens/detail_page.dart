import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthful/Controller/Provider/appointment_provider.dart';
import 'package:healthful/Controller/Provider/authentication_provider.dart';
import 'package:healthful/Controller/Provider/calender_provider.dart';
import 'package:healthful/Model/doctor_model.dart';
import 'package:healthful/View/Components/build_buttons.dart';
import 'package:healthful/View/theme/extention.dart';
import 'package:healthful/View/theme/light_color.dart';
import 'package:healthful/View/theme/text_styles.dart';
import 'package:healthful/View/theme/theme.dart';
import 'package:healthful/View/widgets/more_text_widget.dart';
import 'package:healthful/View/widgets/progress_widget.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key, required this.doctor});
  final DoctorModel doctor;

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late DoctorModel doctor;
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
    final sp = context.read<AuthProvider>();
    TextStyle titleStyle = TextStyles.title.copyWith(fontSize: 25).bold;
    if (AppTheme.fullWidth(context) < 393) {
      titleStyle = TextStyles.title.copyWith(fontSize: 23).bold;
    }
    var averageRating = doctor.averageRating;
    print(averageRating.toString());
    return Scaffold(
      backgroundColor: LightColor.extraLightBlue,
      body: Consumer<CalendarProvider>(builder: (context, provider, child) {
        return Stack(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.43,
              child: Image.network(
                doctor.image.toString(),
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
                  padding: const EdgeInsets.only(
                      left: 19,
                      right: 19,
                      top: 16), //symmetric(horizontal: 19, vertical: 16),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
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
                              Expanded(
                                child: Text(
                                  doctor.name.toString(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Icon(Icons.check_circle,
                                  size: 18,
                                  color: Theme.of(context).primaryColor),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 28.0),
                                child: Center(
                                  child: RatingBar(
                                    initialRating: double.parse(
                                        averageRating.toString() ?? "0.0"),
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemSize: 15,
                                    itemPadding: const EdgeInsets.symmetric(
                                        horizontal: 3.0),
                                    onRatingUpdate: (rating) {
                                      print(rating);
                                    },
                                    glow: false,
                                    ratingWidget: RatingWidget(
                                      full: _image('assets/heart.png'),
                                      half: _image('assets/heart_half.png'),
                                      empty: _image('assets/heart_border.png'),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          subtitle: Text(
                            doctor.category.toString(),
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
                        StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('users')
                                .where("uid", isEqualTo: doctor.id.toString())
                                .snapshots(),
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              }

                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                    child: CircularProgressIndicator(
                                  color: LightColor.marron,
                                ));
                              }
                              final Map<String, dynamic> data =
                                  snapshot.data!.docs.first.data()
                                      as Map<String, dynamic>;
                              String goodReviewsString =
                                  data['goodReviews'] ?? "0.0";
                              int totalReviewsString =
                                  data['totalReviews'] ?? 0;
                              double goodReviews =
                                  double.parse(goodReviewsString);
                              double totalReviews =
                                  double.parse(totalReviewsString.toString());

                              return Row(
                                children: <Widget>[
                                  ProgressWidget(
                                      value: goodReviews,
                                      totalValue: 100,
                                      activeColor: LightColor.marronExtraLight,
                                      backgroundColor:
                                          LightColor.grey.withOpacity(.3),
                                      title: "Good Review",
                                      durationTime: 500),
                                  ProgressWidget(
                                      value: totalReviews,
                                      totalValue: 1000,
                                      activeColor: LightColor.marronLight,
                                      backgroundColor:
                                          LightColor.grey.withOpacity(.3),
                                      title: "Total Reviews",
                                      durationTime: 300),
                                  ProgressWidget(
                                      value: double.parse(
                                          data['averageRating'] ?? "0.0"),
                                      totalValue: 100,
                                      activeColor: LightColor.marron,
                                      backgroundColor:
                                          LightColor.grey.withOpacity(.3),
                                      title: "Satisfaction",
                                      durationTime: 800),
                                ],
                              );
                            }),
                        const Divider(
                          thickness: .3,
                          color: LightColor.grey,
                        ),
                        const Text(
                          "About",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                        ReadMoreText(
                          doctor.about.toString(),
                          trimLines: 3,
                          colorClickableText: LightColor.marronLight,
                          trimMode: TrimMode.Line,
                          trimCollapsedText: " Read more",
                          trimExpandedText: " Show less",
                          style: TextStyles.body.subTitleColor,
                        ),
                        _buildCustomCalendarHeader(context),
                        TableCalendar(
                          daysOfWeekHeight: 20,
                          headerVisible: false,
                          firstDay: DateTime.utc(2010, 10, 16),
                          lastDay: DateTime.utc(2030, 3, 14),
                          focusedDay: provider.focusedDay,
                          selectedDayPredicate: (day) {
                            return isSameDay(provider.selectedDay, day);
                          },
                          onDaySelected: (selectedDay, focusedDay) {
                            provider.selectDay(selectedDay, focusedDay);
                          },
                          onPageChanged: (focusedDay) {
                            provider.changeFocusedDay(focusedDay);
                          },
                          calendarStyle: const CalendarStyle(
                            todayDecoration: BoxDecoration(
                              color: LightColor.marronLight,
                              shape: BoxShape.circle,
                            ),
                            selectedDecoration: BoxDecoration(
                              color: LightColor.marron,
                              shape: BoxShape.circle,
                            ),
                            outsideDaysVisible: false,
                          ),
                          headerStyle: const HeaderStyle(
                            formatButtonVisible: false,
                            titleCentered: true,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Consumer<AppointmentProvider>(
                            builder: (context, appointmentProvider, _) {
                          return SizedBox(
                            height: 55,
                            width: double.infinity,
                            child: buildRegisterButton(() {
                              DateTime currentDate =
                                  provider.selectedDay ?? DateTime.now();

                              String formattedDate =
                                  '${currentDate.month.toString().padLeft(2, '0')}/'
                                  '${currentDate.day.toString().padLeft(2, '0')}/'
                                  '${currentDate.year.toString()}';
                              TimeOfDay currentTime = TimeOfDay.now();
                              String formattedTime =
                                  '${currentTime.hourOfPeriod.toString().padLeft(2, '0')}:'
                                  '${currentTime.minute.toString().padLeft(2, '0')} '
                                  '${currentTime.period == DayPeriod.am ? 'AM' : 'PM'}';
                              print("Date $formattedDate Time $formattedTime");
                              appointmentProvider.addAppointment(
                                context: context,
                                doctorId: doctor.id.toString(),
                                patientId: sp.uid.toString(),
                                doctorName: doctor.name.toString(),
                                photoUrl: doctor.image.toString(),
                                category: doctor.category.toString(),
                                appointmentDate: formattedDate,
                                appointmentTime: formattedTime,
                                phone: doctor.phone.toString(),
                              );
                            },
                                appointmentProvider.isLoading
                                    ? const SpinKitThreeBounce(
                                        color: LightColor.white,
                                        size: 30.0,
                                      )
                                    : const Text("Make an appointment",
                                        style: TextStyle(
                                            color: LightColor.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15))),
                          );
                        }).vP16
                      ],
                    ),
                  ),
                );
              },
            ),
            _appbar(),
          ],
        );
      }),
    );
  }

  Widget _image(String asset) {
    return Image.asset(
      asset,
      height: 30.0,
      width: 30.0,
      color: Colors.amber,
    );
  }

  Widget _buildCustomCalendarHeader(BuildContext context) {
    final provider = Provider.of<CalendarProvider>(context, listen: false);
    final now = DateTime.now();
    final isCurrentMonth = now.year == provider.focusedDay.year &&
        now.month == provider.focusedDay.month;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Schedules',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: LightColor.marron,
              borderRadius: BorderRadius.circular(15),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 6),
            child: Row(
              children: [
                if (!isCurrentMonth)
                  GestureDetector(
                      onTap: () {
                        provider.changeFocusedDay(provider.focusedDay
                            .subtract(const Duration(days: 30)));
                      },
                      child: const Icon(Icons.arrow_back_ios,size: 14,color: LightColor.white,)),
                Text(
                  _formatMonth(provider.focusedDay),
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
                GestureDetector(
                    onTap: () {
                      provider.changeFocusedDay(
                          provider.focusedDay.add(const Duration(days: 30)));
                    },
                    child: const Icon(
                      Icons.arrow_forward_ios,
                      size: 14,
                      color: LightColor.white,
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatMonth(DateTime date) {
    return DateFormat('MMM')
        .format(date); // Format month as "May", "Jun", "Dec", etc.
  }
}
