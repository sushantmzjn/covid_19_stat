import 'package:covid_stat/config/font_styles.dart';
import 'package:covid_stat/config/theme/theme_provider.dart';
import 'package:covid_stat/features/covid/presentation/screen/search_result.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchContainer extends ConsumerStatefulWidget {
  final TextEditingController controller;
  const SearchContainer({super.key, required this.controller});

  @override
  ConsumerState<SearchContainer> createState() => _SearchContainerState();
}

class _SearchContainerState extends ConsumerState<SearchContainer> {
  final searchStyle = TextStyle(
      fontFamily: FontStyles.poppinMedium, color: Colors.grey, fontSize: 12.sp);
  final txtStyle =
      TextStyle(fontFamily: FontStyles.poppinMedium, fontSize: 12.sp);

  @override
  Widget build(BuildContext context) {
    final themeData = ref.watch(themeProvider);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
      child: TextFormField(
        cursorColor: themeData.isDarkMode ? Colors.white : Colors.black,
        controller: widget.controller,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.search,
        style: txtStyle,
        onChanged: (val) {
          setState(() {});
        },
        onFieldSubmitted: (val) async {
          if (val.trim().isEmpty) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                behavior: SnackBarBehavior.floating,
                padding: const EdgeInsets.all(8.0),
                backgroundColor: Colors.redAccent,
                content: Text(
                  'Text Field is empty !!',
                  style: TextStyle(color: Colors.white, fontSize: 16.sp),
                )));
          } else {
            Navigator.of(context).push(CupertinoPageRoute(builder: (context) {
              return SearchResult(
                searchText: widget.controller.text.trim(),
              );
            }));
          }
        },
        decoration: InputDecoration(
          suffixIcon: widget.controller.text.trim().isEmpty
              ? null
              : IconButton(
                  onPressed: () {
                    setState(() {
                      widget.controller.clear();
                    });
                  },
                  icon: const Icon(
                    Icons.clear_rounded,
                    color: Colors.redAccent,
                  )),
          hintText: 'Search Country',
          hintStyle: searchStyle,
          contentPadding: EdgeInsets.symmetric(vertical: 6.w, horizontal: 12.w),
          border: const OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: themeData.isDarkMode ? Colors.white : Colors.black)),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey)),
        ),
      ),
    );
  }
}
