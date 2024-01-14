import 'package:covid_stat/config/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDivider extends ConsumerWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(themeProvider);
    return Divider(
      color: currentTheme.isDarkMode ? Colors.white24 : Colors.black26,
      thickness: 0.8.w,
    );
  }
}
