import 'package:covid_stat/config/font_styles.dart';
import 'package:covid_stat/config/theme/theme_provider.dart';
import 'package:covid_stat/config/widgets/custom_divider.dart';
import 'package:covid_stat/config/widgets/custom_loading.dart';
import 'package:covid_stat/features/covid/presentation/provider/covid_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SearchResult extends ConsumerWidget {
  final String searchText;
  SearchResult({super.key, required this.searchText});

  final tooltipTxtStyle =
      TextStyle(fontFamily: FontStyles.poppins, fontSize: 10.sp);
  final titleStyle =
      TextStyle(fontFamily: FontStyles.poppinMedium, fontSize: 16.sp);
  final tblHeaderStyle =
      TextStyle(fontFamily: FontStyles.poppinMedium, fontSize: 12.sp);
  final tblStyle = TextStyle(fontFamily: FontStyles.poppins, fontSize: 12.sp);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchData = ref.watch(searchCountryStatProvider(searchText));
    final themeData = ref.watch(themeProvider);
    return Scaffold(
      body: RefreshIndicator(
        color: themeData.isDarkMode ? Colors.white : Colors.black,
        onRefresh: () async {
          ref.invalidate(searchCountryStatProvider(searchText));
        },
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: SafeArea(
                child: searchData.when(
              data: (data) {
                List<Data> pieData = [
                  Data('Total Cases', data.cases, Colors.orange),
                  Data('Active Cases', data.active, Colors.blue),
                  Data('Total Recovered', data.recovered, Colors.green),
                  Data('Total Deaths', data.deaths, Colors.red),
                  Data('Critical', data.critical, Colors.yellow),
                ];
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        SfCircularChart(
                          margin: EdgeInsets.symmetric(
                              horizontal: 12.w, vertical: 4.w),
                          tooltipBehavior: TooltipBehavior(
                            textStyle: tooltipTxtStyle,
                            enable: true,
                            header: '',
                            format: 'point.x : point.y',
                          ),
                          legend: const Legend(
                              overflowMode: LegendItemOverflowMode.wrap,
                              orientation: LegendItemOrientation.auto,
                              position: LegendPosition.bottom,
                              isVisible: true,
                              textStyle:
                                  TextStyle(fontFamily: FontStyles.poppins)),
                          series: <CircularSeries>[
                            DoughnutSeries<Data, String>(
                              strokeWidth: 1,
                              strokeColor: Colors.white,
                              innerRadius: '65%',
                              animationDuration: 1000,
                              dataSource: pieData,
                              pointColorMapper: (data, index) => data.color,
                              xValueMapper: (data, index) => data.title,
                              yValueMapper: (data, index) => data.count,
                              dataLabelSettings: DataLabelSettings(
                                textStyle: TextStyle(
                                    fontFamily: FontStyles.poppins,
                                    fontSize: 10.sp),
                                isVisible: true,
                                labelIntersectAction:
                                    LabelIntersectAction.shift,
                                labelPosition: ChartDataLabelPosition.outside,
                              ),
                            )
                          ],
                        ),
                        Positioned(
                          top: 10,
                          right: 10,
                          child: Image.network(
                            data.countryInfo.flag,
                            width: 40,
                            height: 40,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(CupertinoIcons.back),
                        ),
                      ],
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.w),
                      child: Text(
                        'Today\'s Update',
                        style: titleStyle,
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 6.w),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 4.w, vertical: 4.w),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.r),
                              border: Border.all(
                                color: themeData.isDarkMode
                                    ? Colors.white
                                    : Colors.black,
                                width: .5,
                              )),
                          width: 300.w,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text('Cases', style: tblHeaderStyle),
                                    Text('Deaths', style: tblHeaderStyle),
                                    Text('Recovered', style: tblHeaderStyle),
                                  ],
                                ),
                                const CustomDivider(),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 8.w),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        // width: 50.w,
                                        child: Text(data.todayCases.toString(),
                                            style: tblStyle),
                                      ),
                                      SizedBox(
                                        // width: 50.w,
                                        child: Text(data.todayDeaths.toString(),
                                            style: tblStyle),
                                      ),
                                      SizedBox(
                                        // width: 50.w,
                                        child: Text(
                                            data.todayRecovered.toString(),
                                            style: tblStyle),
                                      ),
                                    ],
                                  ),
                                ),
                                const CustomDivider(),
                              ]),
                        )),
                  ],
                );
              },
              error: (err, stack) => Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.w),
                  child: Text(err.toString()),
                ),
              ),
              loading: () => Padding(
                padding: EdgeInsets.symmetric(vertical: 12.w),
                child: const CustomCircularLoading(),
              ),
            )),
          ),
        ),
      ),
    );
  }
}

class Data {
  Data(this.title, this.count, this.color);

  final String title;
  final int count;
  final Color color;
}
