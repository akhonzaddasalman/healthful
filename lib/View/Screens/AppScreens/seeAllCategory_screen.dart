import 'package:flutter/material.dart';
import 'package:healthful/View/theme/extention.dart';
import 'package:healthful/View/theme/text_styles.dart';
import 'package:healthful/View/theme/theme.dart';

class AllCategoryScreen extends StatefulWidget {
  const AllCategoryScreen({super.key});

  @override
  State<AllCategoryScreen> createState() => _AllCategoryScreenState();
}

class _AllCategoryScreenState extends State<AllCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('All Category'),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
        children: [
          _categoryCard("Chemist & Drugist", "350 + Stores", color: Colors.green, lightColor: Colors.lightGreen),
          _categoryCard("Covid - 19 Specialist", "899 Doctors", color: Colors.blue, lightColor: Colors.lightBlue),
          _categoryCard("Cardiologists Specialist", "500 + Doctors", color: Colors.orange, lightColor: Colors.orangeAccent),
          _categoryCard("Dermatologist", "300 + Doctors", color: Colors.green, lightColor: Colors.lightGreen),
          _categoryCard("General Surgeon", "500 + Doctors", color: Colors.blue, lightColor: Colors.lightBlue),
          _categoryCard("Chemist & Drugist", "350 + Stores", color: Colors.green, lightColor: Colors.lightGreen),
          _categoryCard("Covid - 19 Specialist", "899 Doctors", color: Colors.blue, lightColor: Colors.lightBlue),
          _categoryCard("Cardiologists Specialist", "500 + Doctors", color: Colors.orange, lightColor: Colors.orangeAccent),
          _categoryCard("Dermatologist", "300 + Doctors", color: Colors.green, lightColor: Colors.lightGreen),
          _categoryCard("General Surgeon", "500 + Doctors", color: Colors.blue, lightColor: Colors.lightBlue),
          _categoryCard("Chemist & Drugist", "350 + Stores", color: Colors.green, lightColor: Colors.lightGreen),
          _categoryCard("Covid - 19 Specialist", "899 Doctors", color: Colors.blue, lightColor: Colors.lightBlue),
          _categoryCard("Cardiologists Specialist", "500 + Doctors", color: Colors.orange, lightColor: Colors.orangeAccent),
          _categoryCard("Dermatologist", "300 + Doctors", color: Colors.green, lightColor: Colors.lightGreen),
          _categoryCard("General Surgeon", "500 + Doctors", color: Colors.blue, lightColor: Colors.lightBlue),
        ],
      ),
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
}
