import 'package:covid_stat/config/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CustomCircularLoading extends StatelessWidget {
  const CustomCircularLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final themeData = ref.watch(themeProvider);

        return Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Transform.scale(
                scale: .8.sp,
                child: CircularProgressIndicator(
                  color: themeData.isDarkMode ? Colors.white : Colors.black,
                  strokeWidth: 3.sp,
                ),
              ),
              SpinKitDoubleBounce(
                size: 24.w,
                color: themeData.isDarkMode ? Colors.white : Colors.black,
              )
            ],
          ),
        );
      },
    );
  }
}
