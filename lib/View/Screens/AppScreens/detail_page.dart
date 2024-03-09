import 'package:flutter/material.dart';
import 'package:healthful/Model/dactor_model.dart';
import 'package:healthful/View/Components/build_buttons.dart';
import 'package:healthful/View/theme/extention.dart';
import 'package:healthful/View/theme/light_color.dart';
import 'package:healthful/View/theme/text_styles.dart';
import 'package:healthful/View/theme/theme.dart';
import 'package:healthful/View/widgets/progress_widget.dart';
import 'package:healthful/View/widgets/rating_start.dart';

class DetailPage extends StatefulWidget {
  DetailPage({Key? key, required this.model}) : super(key: key);
  final DoctorModel model;

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  DoctorModel? model;
  @override
  void initState() {
    model = widget.model;
    super.initState();
  }

  Widget _appbar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        BackButton(color: Theme.of(context).primaryColor),
        IconButton(
            icon: Icon(
              model!.isfavourite ? Icons.favorite : Icons.favorite_border,
              color: model!.isfavourite ? Colors.red : LightColor.grey,
            ),
            onPressed: () {
              setState(() {
                model!.isfavourite = !model!.isfavourite;
              });
            })
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    TextStyle titleStyle = TextStyles.title.copyWith(fontSize: 25).bold;
    if (AppTheme.fullWidth(context) < 393) {
      titleStyle = TextStyles.title.copyWith(fontSize: 23).bold;
    }
    return Scaffold(
      backgroundColor: LightColor.extraLightBlue,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: <Widget>[
            Image.asset(model!.image),
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
                                model!.name,
                                style: titleStyle,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Icon(Icons.check_circle, size: 18, color: Theme.of(context).primaryColor),
                              const Spacer(),
                              RatingStar(
                                rating: model!.rating,
                              )
                            ],
                          ),
                          subtitle: Text(
                            model!.type,
                            style: TextStyles.bodySm.subTitleColor.bold,
                          ),
                        ),
                        const Divider(
                          thickness: .3,
                          color: LightColor.grey,
                        ),
                        Row(
                          children: <Widget>[
                            ProgressWidget(
                                value: model!.goodReviews,
                                totalValue: 100,
                                activeColor: LightColor.marronExtraLight,
                                backgroundColor: LightColor.grey.withOpacity(.3),
                                title: "Good Review",
                                durationTime: 500),
                            ProgressWidget(
                                value: model!.totalScore,
                                totalValue: 100,
                                activeColor: LightColor.marronLight,
                                backgroundColor: LightColor.grey.withOpacity(.3),
                                title: "Total Score",
                                durationTime: 300),
                            ProgressWidget(
                                value: model!.satisfaction,
                                totalValue: 100,
                                activeColor: LightColor.marron,
                                backgroundColor: LightColor.grey.withOpacity(.3),
                                title: "Satisfaction",
                                durationTime: 800),
                          ],
                        ),
                        const Divider(
                          thickness: .3,
                          color: LightColor.grey,
                        ),
                        Text("About", style: titleStyle).vP16,
                        Text(
                          model!.description,
                          style: TextStyles.body.subTitleColor,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              height: 45,
                              width: 45,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: LightColor.grey.withAlpha(150)),
                              child: const Icon(
                                Icons.call,
                                color: Colors.white,
                              ),
                            ).ripple(
                              () {},
                              borderRadius: BorderRadius.circular(10),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              height: 45,
                              width: 45,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: LightColor.grey.withAlpha(150)),
                              child: const Icon(
                                Icons.chat_bubble,
                                color: Colors.white,
                              ),
                            ).ripple(
                              () {},
                              borderRadius: BorderRadius.circular(10),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            SizedBox(
                              height: 55,
                              child: buildRegisterButton(() {}, "Make an appointment",
                                  textStyle: const TextStyle(color: LightColor.white, fontWeight: FontWeight.bold, fontSize: 15)),
                            ),
                          ],
                        ).vP16
                      ],
                    ),
                  ),
                );
              },
            ),
            _appbar(),
          ],
        ),
      ),
    );
  }
}
