import 'package:covid_stat/config/font_styles.dart';
import 'package:covid_stat/config/theme/theme_provider.dart';
import 'package:covid_stat/config/widgets/custom_loading.dart';
import 'package:covid_stat/config/widgets/custom_switch.dart';
import 'package:covid_stat/features/covid/presentation/provider/covid_provider.dart';
import 'package:covid_stat/features/covid/presentation/screen/country_stat.dart';
import 'package:covid_stat/features/covid/presentation/screen/covid_detail.dart';
import 'package:covid_stat/features/covid/presentation/widgets/covid_tiles.dart';
import 'package:covid_stat/features/covid/presentation/widgets/search_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

class HomePage extends ConsumerStatefulWidget {
  HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final txtStyle = TextStyle(
      fontFamily: FontStyles.poppinMedium,
      fontSize: 18.sp,
      color: Colors.white);

  final titleStyle = TextStyle(
    fontFamily: FontStyles.poppinSemiBold,
    fontSize: 18.sp,
  );

  String shortenNumber(int number) {
    if (number < 1000) {
      return number.toString();
    } else if (number < 1000000) {
      double result = number / 1000;
      return '${result.toStringAsFixed(result.truncateToDouble() == result ? 0 : 1)}K';
    } else if (number < 1000000000) {
      double result = number / 1000000;
      return '${result.toStringAsFixed(result.truncateToDouble() == result ? 0 : 1)}M';
    } else {
      double result = number / 1000000000;
      return '${result.toStringAsFixed(result.truncateToDouble() == result ? 0 : 1)}B';
    }
  }

  TextEditingController searchTextController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final covidStatData = ref.watch(allCovidStatProvider);
    final countryStatData = ref.watch(countryStatProvider);
    final themeData = ref.watch(themeProvider);

    return Scaffold(
      key: _scaffoldKey,
      endDrawer: Drawer(
        width: MediaQuery.of(context).size.width / 1.8,
        child: const CustomSwitch(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: 220.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20.r),
                            bottomRight: Radius.circular(20.r))),
                    child: Stack(
                      children: [
                        Image.asset('assets/images/virus.png'),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: Row(
                            children: [
                              SvgPicture.asset('assets/images/Drcorona.svg',
                                  height: 210.h),
                              Flexible(
                                child: Text(
                                  'All you need is to stay at home.',
                                  textAlign: TextAlign.center,
                                  style: txtStyle,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Positioned(
                      right: 16.r,
                      child: GestureDetector(
                        onTap: () => _scaffoldKey.currentState!.openEndDrawer(),
                        child: Image.asset(
                          'assets/icons/setting.png',
                          color: Colors.white,
                          height: 25.h,
                          width: 25.h,
                        ),
                      )),
                ],
              ),
              SearchContainer(
                controller: searchTextController,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.w),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Case Update',
                      style: titleStyle,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .push(CupertinoPageRoute(builder: (context) {
                          return CovidDetail();
                        }));
                      },
                      splashColor: Colors.blue.withOpacity(0.2),
                      child: Text(
                        'See Details',
                        style: TextStyle(
                          fontFamily: FontStyles.poppinMedium,
                          fontSize: 13.sp,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5.h),
              covidStatData.when(
                data: (data) {
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      child: Row(
                        children: [
                          CovidTiles(
                              number: shortenNumber(data.cases),
                              color: const Color(0xFFFF8748),
                              title: 'Total Cases'),
                          CovidTiles(
                              number: shortenNumber(data.active),
                              color: const Color(0xFFFF8748),
                              title: 'Active Cases'),
                          CovidTiles(
                              number: shortenNumber(data.recovered),
                              color: const Color(0xFF36C12C),
                              title: 'Total Recovered'),
                          CovidTiles(
                              number: shortenNumber(data.active),
                              color: const Color(0xFFFF4848),
                              title: 'Total Death'),
                        ],
                      ),
                    ),
                  );
                },
                error: (err, stack) => Center(
                  child: Text(err.toString()),
                ),
                loading: () => SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: Row(
                      children: [
                        CovidTiles(
                            number: shortenNumber(0),
                            color: const Color(0xFFFF8748),
                            title: 'Total Cases'),
                        CovidTiles(
                            number: shortenNumber(0),
                            color: const Color(0xFFFF8748),
                            title: 'Active Cases'),
                        CovidTiles(
                            number: shortenNumber(0),
                            color: const Color(0xFF36C12C),
                            title: 'Total Recovered'),
                        CovidTiles(
                            number: shortenNumber(0),
                            color: const Color(0xFFFF4848),
                            title: 'Total Death'),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.w),
                child: countryStatData.when(
                  data: (data) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'World Map',
                              style: titleStyle,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                    CupertinoPageRoute(builder: (context) {
                                  return CountryStatDetail();
                                }));
                              },
                              splashColor: Colors.blue.withOpacity(0.2),
                              child: Text(
                                'See Details',
                                style: TextStyle(
                                  fontFamily: FontStyles.poppinMedium,
                                  fontSize: 13.sp,
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SfMaps(
                          layers: [
                            MapShapeLayer(
                              // legend: const MapLegend(MapElement.shape,
                              //     overflowMode: MapLegendOverflowMode.scroll),
                              shapeTooltipBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    '${data[index].country} : ${data[index].cases} Cases',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: FontStyles.poppins,
                                        fontSize: 12.sp),
                                  ),
                                );
                              },
                              tooltipSettings:
                                  const MapTooltipSettings(color: Colors.black),
                              source: MapShapeSource.asset(
                                'assets/world-map.json',
                                dataCount: data.length,
                                shapeDataField: 'name',
                                primaryValueMapper: (int index) =>
                                    data[index].country,
                              ),

                              zoomPanBehavior: MapZoomPanBehavior(
                                  enableDoubleTapZooming: true),
                            )
                          ],
                        ),
                      ],
                    );
                  },
                  error: (err, stack) => Center(
                    child: Text(err.toString()),
                  ),
                  loading: () => const CustomCircularLoading(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
