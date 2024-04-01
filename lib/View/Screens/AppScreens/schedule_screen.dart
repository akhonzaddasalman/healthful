import 'package:flutter/material.dart';
import 'package:healthful/Controller/Provider/appointment_provider.dart';
import 'package:healthful/Controller/Provider/authentication_provider.dart';
import 'package:healthful/View/theme/light_color.dart';
import 'package:healthful/View/widgets/canceled_schedule.dart';
import 'package:healthful/View/widgets/completed_appointments.dart';
import 'package:healthful/View/widgets/upcoming_schedule.dart';
import 'package:provider/provider.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  int _buttonIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  Future getData() async {
    final sp = context.read<AuthProvider>();
    final appointmentProvider = context.read<AppointmentProvider>();
    appointmentProvider.fetchUpcomingAppointments(sp.uid.toString());
    appointmentProvider.fetchCanceledAppointments(sp.uid.toString());
    appointmentProvider.fetchCompletedAppointments(sp.uid.toString());
  }

  final _scheduleWidgets = [
    // Upcoming Widget
    const UpcomingAppointments(),

    // Completed Widget
    const CompletedAppointments(),

    // Canceled Widget
    const CanceledAppointments(),
  ];
  List<String> scheduleName = [
    'Upcoming',
    'Complete',
    'Canceled',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  "Schedule",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                height: 50,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFFF4F6FA),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListView.builder(
                    itemCount: scheduleName.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            _buttonIndex = index;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 25),
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                            color: _buttonIndex == index ? LightColor.marron : LightColor.grey.withOpacity(0.2),
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                offset: const Offset(4, 4),
                                blurRadius: 5,
                                color: LightColor.grey.withOpacity(.2),
                              ),
                              BoxShadow(
                                offset: const Offset(-3, 0),
                                blurRadius: 5,
                                color: LightColor.grey.withOpacity(.1),
                              )
                            ],
                          ),
                          child: Text(
                            scheduleName[index].toString(),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: _buttonIndex == index ? Colors.white : Colors.black38,
                            ),
                          ),
                        ),
                      );
                    }),
              ),
              const SizedBox(height: 30),
              _scheduleWidgets[_buttonIndex],
            ],
          ),
        ),
      ),
    );
  }
}
