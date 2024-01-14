import 'package:covid_stat/config/font_styles.dart';
import 'package:covid_stat/config/theme/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchContainer extends ConsumerWidget {
  final void Function()? onTap;
  const SearchContainer({super.key, required this.onTap});
  final searchStyle =
      const TextStyle(fontFamily: FontStyles.poppinMedium, color: Colors.grey);
  @override
  Widget build(BuildContext context, ref) {
    final themeData = ref.watch(themeProvider);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.w),
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          color: themeData.isDarkMode
              ? themeData.themeData.colorScheme.primary
              : Colors.white,
          surfaceTintColor: themeData.isDarkMode
              ? themeData.themeData.colorScheme.primary
              : Colors.white,
          elevation: 3,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.w)),
          child: SizedBox(
            height: 45.h,
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  child: Icon(
                    CupertinoIcons.location_solid,
                    color: themeData.isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                Text('Search country', style: searchStyle),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
