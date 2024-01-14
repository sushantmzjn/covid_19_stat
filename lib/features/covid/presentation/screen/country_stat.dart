import 'dart:io';

import 'package:covid_stat/config/font_styles.dart';
import 'package:covid_stat/config/theme/theme_provider.dart';
import 'package:covid_stat/config/widgets/custom_loading.dart';
import 'package:covid_stat/features/covid/data/model/country_stat.dart';
import 'package:covid_stat/features/covid/presentation/provider/covid_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_datagrid_export/export.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class CountryStatDetail extends ConsumerWidget {
  CountryStatDetail({Key? key});

  final rowHeaderStyle =
      TextStyle(fontFamily: FontStyles.poppinSemiBold, fontSize: 16.sp);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final countryStatData = ref.watch(countryStatProvider);
    final themeData = ref.watch(themeProvider);
    GlobalKey<SfDataGridState> key = GlobalKey<SfDataGridState>();

    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(CupertinoIcons.back),
                ),
                ElevatedButton(
                  child: Text(
                    'Export To Pdf',
                    style: TextStyle(
                        fontFamily: FontStyles.poppins,
                        color:
                            themeData.isDarkMode ? Colors.white : Colors.black),
                  ),
                  onPressed: () async {
                    final PdfDocument document = key.currentState!
                        .exportToPdfDocument(fitAllColumnsInOnePage: true);

                    // Get the application support directory
                    final directory = await getApplicationSupportDirectory();
                    final path = directory.path;

                    // Save the PDF document to a file
                    final File file = File('$path/covid.pdf');
                    final List<int> bytes = document.saveSync();
                    await file.writeAsBytes(bytes, flush: true);

                    // Open the saved PDF file
                    OpenFile.open('$path/covid.pdf');

                    document.dispose();
                  },
                ),
              ],
            ),
            Expanded(
              child: countryStatData.when(
                data: (data) {
                  return SfDataGrid(
                    key: key,
                    defaultColumnWidth: 100.w,
                    headerGridLinesVisibility: GridLinesVisibility.both,
                    gridLinesVisibility: GridLinesVisibility.both,
                    source: CountryStatDataSource(data),
                    columns: [
                      GridColumn(
                          columnName: 'flag',
                          label: Center(
                              child: Text('Flag',
                                  textAlign: TextAlign.center,
                                  style: rowHeaderStyle))),
                      GridColumn(
                          columnName: 'iso2',
                          label: Center(
                              child: Text('ISO2',
                                  textAlign: TextAlign.center,
                                  style: rowHeaderStyle))),
                      GridColumn(
                          columnName: 'country',
                          label: Center(
                              child: Text('Country',
                                  textAlign: TextAlign.center,
                                  style: rowHeaderStyle))),
                      GridColumn(
                          columnName: 'continent',
                          label: Center(
                              child: Text('Continent',
                                  textAlign: TextAlign.center,
                                  style: rowHeaderStyle))),
                      GridColumn(
                          columnName: 'population',
                          label: Center(
                              child: Text('Population',
                                  textAlign: TextAlign.center,
                                  style: rowHeaderStyle))),
                      GridColumn(
                          columnName: 'tests',
                          label: Center(
                              child: Text('Tests',
                                  textAlign: TextAlign.center,
                                  style: rowHeaderStyle))),
                      GridColumn(
                          columnName: 'cases',
                          label: Center(
                              child: Text('Cases',
                                  textAlign: TextAlign.center,
                                  style: rowHeaderStyle))),
                      GridColumn(
                          columnName: 'deaths',
                          label: Center(
                              child: Text('Deaths',
                                  textAlign: TextAlign.center,
                                  style: rowHeaderStyle))),
                      GridColumn(
                          columnName: 'recovered',
                          label: Center(
                              child: Text('Recovered',
                                  textAlign: TextAlign.center,
                                  style: rowHeaderStyle))),
                      GridColumn(
                          columnName: 'active',
                          label: Center(
                              child: Text('Active',
                                  textAlign: TextAlign.center,
                                  style: rowHeaderStyle))),
                      GridColumn(
                          columnName: 'critical',
                          label: Center(
                              child: Text('Critical',
                                  textAlign: TextAlign.center,
                                  style: rowHeaderStyle))),
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
    );
  }
}

class CountryStatDataSource extends DataGridSource {
  CountryStatDataSource(List<CountryStat> countryStat) {
    dataGirdRows = countryStat
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell(columnName: 'flag', value: e.countryInfo.flag),
              DataGridCell(columnName: 'iso2', value: e.countryInfo.iso2),
              DataGridCell(columnName: 'country', value: e.country),
              DataGridCell(columnName: 'continent', value: e.continent),
              DataGridCell(columnName: 'population', value: e.population),
              DataGridCell(columnName: 'tests', value: e.tests),
              DataGridCell(columnName: 'cases', value: e.cases),
              DataGridCell(columnName: 'deaths', value: e.deaths),
              DataGridCell(columnName: 'recovered', value: e.recovered),
              DataGridCell(columnName: 'active', value: e.active),
              DataGridCell(columnName: 'critical', value: e.critical),
            ]))
        .toList();
  }
  late List<DataGridRow> dataGirdRows;
  @override
  List<DataGridRow> get rows => dataGirdRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    final tableBodyStyle =
        TextStyle(fontFamily: FontStyles.poppins, fontSize: 11.sp);
    return DataGridRowAdapter(
        cells: row.getCells().map((e) {
      return e.columnName == 'flag'
          ? Center(
              child: Image.network(
                e.value.toString(),
                width: 30,
                height: 30,
              ),
            )
          : Center(
              child: Text(e.value.toString(),
                  textAlign: TextAlign.center, style: tableBodyStyle));
    }).toList());
  }
}
