import 'package:covid_stat/config/font_styles.dart';
import 'package:covid_stat/config/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CovidTiles extends ConsumerWidget {
  final String number;
  final Color color;
  final String title;
  CovidTiles(
      {super.key,
      required this.number,
      required this.color,
      required this.title});

  @override
  Widget build(BuildContext context, ref) {
    final themeData = ref.watch(themeProvider);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2.w),
      child: Card(
        color: themeData.isDarkMode
            ? themeData.themeData.colorScheme.primary
            : Colors.white,
        surfaceTintColor: themeData.isDarkMode
            ? themeData.themeData.colorScheme.primary
            : Colors.white,
        elevation: 3,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.w, horizontal: 10.w),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(6.w),
                height: 25,
                width: 25,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color.withOpacity(.26),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.transparent,
                    border: Border.all(
                      color: color,
                      width: 2,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                number,
                style: TextStyle(
                  fontFamily: FontStyles.poppinSemiBold,
                  fontSize: 22.sp,
                  color: color,
                ),
              ),
              Text(title,
                  style: TextStyle(
                    fontFamily: FontStyles.poppins,
                    fontSize: 12.sp,
                    color: color,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
