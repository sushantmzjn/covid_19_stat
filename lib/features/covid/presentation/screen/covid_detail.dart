import 'package:covid_stat/config/font_styles.dart';
import 'package:covid_stat/config/widgets/custom_loading.dart';
import 'package:covid_stat/features/covid/presentation/provider/covid_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CovidDetail extends ConsumerWidget {
  CovidDetail({super.key});

  final tooltipTxtStyle =
      TextStyle(fontFamily: FontStyles.poppins, fontSize: 10.sp);

  @override
  Widget build(BuildContext context, ref) {
    final covidStat = ref.watch(allCovidStatProvider);

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: covidStat.when(
            data: (data) {
              List<Data> pieData = [
                Data('Active Cases', data.active, Colors.orange),
                Data('Total Recovered', data.recovered, Colors.green),
                Data('Total Deaths', data.deaths, Colors.red),
              ];

              List<Data> barData = [
                Data('Deaths', data.todayDeaths, Colors.red),
                Data('Recovered', data.todayRecovered, Colors.green),
                Data('Cases', data.todayCases, Colors.blue),
              ];

              return Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SfCircularChart(
                        tooltipBehavior: TooltipBehavior(
                          textStyle: tooltipTxtStyle,
                          enable: true,
                          header: '',
                          format: 'point.x : point.y',
                        ),
                        margin: EdgeInsets.symmetric(
                            horizontal: 12.w, vertical: 4.w),
                        legend: const Legend(
                            orientation: LegendItemOrientation.auto,
                            position: LegendPosition.right,
                            isVisible: true,
                            textStyle:
                                TextStyle(fontFamily: FontStyles.poppins)),
                        series: <CircularSeries>[
                          DoughnutSeries<Data, String>(
                            innerRadius: '65%',
                            animationDuration: 1000,
                            dataSource: pieData,
                            pointColorMapper: (Data data, _) => data.color,
                            xValueMapper: (Data data, _) => data.title,
                            yValueMapper: (Data data, _) => data.count,
                            dataLabelSettings: DataLabelSettings(
                              textStyle: TextStyle(
                                  fontFamily: FontStyles.poppins,
                                  fontSize: 10.sp),
                              isVisible: true,
                              labelIntersectAction: LabelIntersectAction.shift,
                              labelPosition: ChartDataLabelPosition.outside,
                            ),
                            strokeWidth: 1.5,
                            strokeColor: Colors.white,
                          ),
                        ],
                        title: ChartTitle(
                            alignment: ChartAlignment.center,
                            textStyle:
                                const TextStyle(fontFamily: FontStyles.poppins),
                            text: 'Total Cases: ${data.cases.toString()}'),
                      ),
                      SfCartesianChart(
                        title: ChartTitle(
                            alignment: ChartAlignment.near,
                            text: 'Today\'s Cases',
                            textStyle: TextStyle(
                                fontFamily: FontStyles.poppinMedium,
                                fontSize: 14.sp)),
                        margin: EdgeInsets.symmetric(
                            horizontal: 12.w, vertical: 10.w),
                        primaryXAxis: const CategoryAxis(),
                        // legend: const Legend(
                        //     orientation: LegendItemOrientation.auto,
                        //     position: LegendPosition.bottom,
                        //     isVisible: true,
                        //     textStyle: TextStyle(fontFamily: FontStyles.poppins)),
                        series: <CartesianSeries<Data, String>>[
                          ColumnSeries<Data, String>(
                            dataSource: barData,
                            xValueMapper: (Data report, _) => report.title,
                            yValueMapper: (Data report, _) => report.count,
                            pointColorMapper: (Data report, _) => report.color,
                            dataLabelSettings: DataLabelSettings(
                                isVisible: true,
                                textStyle: TextStyle(
                                    fontFamily: FontStyles.poppins,
                                    fontSize: 10.sp)),
                            width: 0.60,
                          ),
                        ],
                        tooltipBehavior: TooltipBehavior(
                          textStyle: tooltipTxtStyle,
                          enable: true,
                          header: '',
                          format: 'point.x : point.y',
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(CupertinoIcons.back),
                  )
                ],
              );
            },
            error: (err, stack) => Center(
              child: Text(err.toString()),
            ),
            loading: () => const CustomCircularLoading(),
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
