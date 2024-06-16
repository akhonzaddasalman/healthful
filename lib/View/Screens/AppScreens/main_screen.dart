import 'dart:math';

import 'package:flutter/material.dart';
import 'package:healthful/Controller/Provider/authentication_provider.dart';
import 'package:healthful/Controller/Provider/doctor_provider.dart';
import 'package:healthful/Controller/Provider/home_screen_provider.dart';
import 'package:healthful/View/Screens/AppScreens/detail_page.dart';
import 'package:healthful/View/Screens/AppScreens/seeAllCategory_screen.dart';
import 'package:healthful/View/Utils/next_screen.dart';
import 'package:healthful/View/theme/extention.dart';
import 'package:healthful/View/theme/light_color.dart';
import 'package:healthful/View/theme/text_styles.dart';
import 'package:healthful/View/theme/theme.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  //late List<DoctorModel> doctorDataList;
  @override
  void initState() {
    // doctorDataList = doctorMapList.map((x) => DoctorModel.fromJson(x)).toList();
    super.initState();
    getData();
  }

  Future getData() async {
    final sp = context.read<AuthProvider>();
    final doctorProvider = context.read<DoctorProvider>();
    await doctorProvider.fetchDoctors(sp.uid.toString());
    await sp.getDataFromSharedPreferences();
  }

  @override
  Widget build(BuildContext context) {
    final sp = context.read<AuthProvider>();
    final homeProvider = context.read<HomeScreenProvider>();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: InkWell(
          onTap: () {
            homeProvider.changeTab(3);
          },
          child: Align(
            alignment: Alignment.center,
            child: CircleAvatar(
              backgroundColor: LightColor.marron,
              radius: 35,
              child: CircleAvatar(
                radius: 21,
                backgroundImage: sp.imageUrl.toString() != "" ? NetworkImage("${sp.imageUrl}") as ImageProvider : const AssetImage("assets/user.png"),
              ),
            ),
          ).p(8),
        ),
        actions: const <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.notifications_none,
              size: 30,
              color: LightColor.grey,
            ),
          ),
        ],
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Builder(builder: (context) {
        return Consumer<DoctorProvider>(builder: (context, DoctorProvider doctorProvider, child) {
          if (doctorProvider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: LightColor.marron,
              ),
            );
          }
          return CustomScrollView(
            slivers: <Widget>[
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    _header(sp.name.toString()),
                    Container(
                      height: 55,
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.all(Radius.circular(13)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: LightColor.grey.withOpacity(.3),
                            blurRadius: 15,
                            offset: const Offset(5, 5),
                          )
                        ],
                      ),
                      child: TextField(
                        onChanged: (value) {
                          doctorProvider.searchQuery = value;
                        },
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                          border: InputBorder.none,
                          hintText: "Search",
                          hintStyle: TextStyles.body.subTitleColor,
                          suffixIcon: SizedBox(
                              width: 50,
                              child: const Icon(Icons.search, color: LightColor.marron)
                                  .alignCenter
                                  .ripple(() {}, borderRadius: BorderRadius.circular(13))),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              doctorProvider.searchQuery.isEmpty
                  ? SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          _category(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("Top Doctors", style: TextStyles.title.bold),
                              Icon(
                                Icons.swap_vert_outlined,
                                color: Theme.of(context).primaryColor,
                              ).p(12).ripple(() {
                                doctorProvider.isAscending
                                    ? doctorProvider.sortDoctorsByNameDescending()
                                    : doctorProvider.sortDoctorsByNameAscending();
                              }, borderRadius: const BorderRadius.all(Radius.circular(20))),
                            ],
                          ).hP16,
                          ListView.builder(
                              itemCount: doctorProvider.doctors.length,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                var doctor = doctorProvider.doctors[index];
                                return Container(
                                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
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
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                                    child: ListTile(
                                      contentPadding: const EdgeInsets.all(0),
                                      leading: ClipRRect(
                                        borderRadius: const BorderRadius.all(Radius.circular(13)),
                                        child: Container(
                                          height: 55,
                                          width: 55,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(15),
                                            color: randomColor(),
                                          ),
                                          child: Image.network(
                                            doctor.image.toString(),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                      title: Text(doctor.name.toString(), style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600)),
                                      subtitle: Text(
                                        doctor.type.toString(),
                                        style: TextStyles.bodySm.subTitleColor.bold,
                                      ),
                                      trailing: Icon(
                                        Icons.keyboard_arrow_right,
                                        size: 30,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                  ).ripple(() {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailPage(doctor: doctor),
                                      ),
                                    );
                                  }, borderRadius: const BorderRadius.all(Radius.circular(20))),
                                );
                              }),
                        ],
                      ),
                    )
                  : SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("Top Doctors", style: TextStyles.title.bold),
                              Icon(
                                Icons.swap_vert_outlined,
                                color: Theme.of(context).primaryColor,
                              ).p(12).ripple(() {
                                doctorProvider.isAscending
                                    ? doctorProvider.sortDoctorsByNameDescending()
                                    : doctorProvider.sortDoctorsByNameAscending();
                              }, borderRadius: const BorderRadius.all(Radius.circular(20))),
                            ],
                          ).hP16,
                          ListView.builder(
                              itemCount: doctorProvider.doctors.length,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                var doctor = doctorProvider.doctors[index];
                                return Container(
                                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
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
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                                    child: ListTile(
                                      contentPadding: const EdgeInsets.all(0),
                                      leading: ClipRRect(
                                        borderRadius: const BorderRadius.all(Radius.circular(13)),
                                        child: Container(
                                          height: 55,
                                          width: 55,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(15),
                                            color: randomColor(),
                                          ),
                                          child: Image.network(
                                            doctor.image.toString(),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                      title: Text(doctor.name.toString(), style: TextStyles.title.bold),
                                      subtitle: Text(
                                        doctor.type.toString(),
                                        style: TextStyles.bodySm.subTitleColor.bold,
                                      ),
                                      trailing: Icon(
                                        Icons.keyboard_arrow_right,
                                        size: 30,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                  ).ripple(() {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailPage(doctor: doctor),
                                      ),
                                    );
                                  }, borderRadius: const BorderRadius.all(Radius.circular(20))),
                                );
                              }),
                        ],
                      ),
                    )
            ],
          );
        });
      }),
    );
  }

  Widget _header(String name) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Hello,", style: TextStyles.title.subTitleColor),
        Text(name, style: TextStyles.h1Style),
      ],
    ).p16;
  }

  Widget _category() {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 8, right: 16, left: 16, bottom: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Category", style: TextStyles.title.bold),
              Text(
                "See All",
                style: TextStyles.titleNormal.copyWith(color: Theme.of(context).primaryColor),
              ).p(8).ripple(() {
                nextScreen(context, const AllCategoryScreen());
              })
            ],
          ),
        ),
        SizedBox(
          height: AppTheme.fullHeight(context) * .28,
          width: AppTheme.fullWidth(context),
          child: ListView.builder(
            itemCount: doctorCategories.length,
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              final Random random = Random();
              final List<Color> colors = cardRandomColor();
              final Color lightColor = colors[0];
              final Color darkColor = colors[1];
              final int value = random.nextInt(150) + 10;
              return _categoryCard(doctorCategories[index].toString(), "$value + Stores", color: darkColor, lightColor: lightColor);
            },
          ),
        ),
      ],
    );
  }

  Widget _categoryCard(String title, String subtitle, {Color? color, required Color lightColor}) {
    TextStyle titleStyle = TextStyles.title.bold.white;
    TextStyle subtitleStyle = TextStyles.body.bold.white;
    if (AppTheme.fullWidth(context) < 392) {
      titleStyle = TextStyles.body.bold.white;
      subtitleStyle = TextStyles.bodySm.bold.white;
    }
    return AspectRatio(
      aspectRatio: 6 / 8,
      child: Container(
        height: 280,
        width: AppTheme.fullWidth(context) * .3,
        margin: const EdgeInsets.only(left: 10, right: 10, bottom: 20, top: 10),
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              offset: const Offset(4, 4),
              blurRadius: 10,
              color: lightColor.withOpacity(.8),
            )
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          child: Container(
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: -20,
                  left: -20,
                  child: CircleAvatar(
                    backgroundColor: lightColor,
                    radius: 60,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Flexible(
                      child: Text(title, style: titleStyle).hP8,
                    ),
                    const SizedBox(height: 10),
                    Flexible(
                      child: Text(
                        overflow: TextOverflow.ellipsis,
                        subtitle,
                        style: subtitleStyle,
                      ).hP8,
                    ),
                  ],
                ).p16
              ],
            ),
          ),
        ).ripple(() {}, borderRadius: const BorderRadius.all(Radius.circular(20))),
      ),
    );
  }

  Color randomColor() {
    var random = Random();
    final colorList = [
      Theme.of(context).primaryColor,
      LightColor.orange,
      LightColor.green,
      LightColor.grey,
      LightColor.lightOrange,
      LightColor.skyBlue,
      LightColor.titleTextColor,
      Colors.red,
      Colors.brown,
      LightColor.marronExtraLight,
      LightColor.skyBlue,
    ];
    var color = colorList[random.nextInt(colorList.length)];
    return color;
  }

  List<Color> cardRandomColor() {
    var random = Random();
    final List<List<Color>> colorList = [
      [LightColor.lightGreen, LightColor.green],
      [LightColor.lightBlue, LightColor.skyBlue],
      [LightColor.lightOrange, LightColor.orange],
      [LightColor.lightGreen, LightColor.green],
      [LightColor.lightBlue, LightColor.skyBlue],
    ];

    var color = colorList[random.nextInt(colorList.length)];
    return color;
  }

  List<String> doctorCategories = [
    'Allergist',
    'Anesthesiologist',
    'Cardiologist',
    'Dermatologist',
    'Endocrinologist',
    'Gastroenterologist',
    'Hematologist',
    'Infectious Disease Specialist',
    'Internist',
    'Neonatologist',
    'Nephrologist',
    'Neurologist',
    'Obstetrician/Gynecologist',
    'Oncologist',
    'Ophthalmologist',
    'Orthopedic Surgeon',
    'Otolaryngologist (ENT Specialist)',
    'Pediatrician',
    'Plastic Surgeon',
    'Psychiatrist',
    'Pulmonologist',
    'Radiologist',
    'Rheumatologist',
    'Surgeon',
    'Urologist',
    'Cardiac Electrophysiologist',
    'Cardiac Surgeon',
    'Colorectal Surgeon',
    'Critical Care Specialist',
    'Emergency Medicine Physician',
    'Family Medicine Physician',
    'Geriatrician',
    'Gynecologic Oncologist',
    'Hand Surgeon',
    'Hepatologist',
    'Interventional Cardiologist',
    'Interventional Radiologist',
    'Medical Geneticist',
    'Nephrology Nurse',
    'Neurosurgeon',
    'Nurse Anesthetist',
    'Nurse Midwife',
    'Nurse Practitioner',
    'Obstetric Nurse',
    'Occupational Medicine Physician',
    'Oncology Nurse',
    'Ophthalmic Technician',
    'Oral and Maxillofacial Surgeon',
    'Orthodontist',
    'Orthopedic Nurse',
  ];
}
