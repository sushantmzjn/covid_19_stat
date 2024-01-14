import 'package:covid_stat/config/theme/theme_provider.dart';
import 'package:covid_stat/features/covid/presentation/screen/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  // await Hive.openBox('board');
  // debugPrint(Hive.box('board').isEmpty.toString());
  await Hive.openBox('isDarkMode');
  debugPrint(
      'DARKMODE ::: ${Hive.box('isDarkMode').get('key', defaultValue: false).toString()}');

  //lock orientation
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  //status bar
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.blue,
    // statusBarIconBrightness: Brightness.light,
  ));

  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    super.initState();
    ref.read(themeProvider.notifier).getDarkModeSetting();
  }

  @override
  Widget build(BuildContext context) {
    final themeDataProvider = ref.watch(themeProvider);

    return ScreenUtilInit(
      designSize: Size(MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height),
      builder: (context, child) {
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: themeDataProvider.themeData,

            // theme: ThemeData(

            //   scaffoldBackgroundColor: Colors.white,
            //   appBarTheme: AppBarTheme(
            //     backgroundColor: Colors.white,
            //     surfaceTintColor: Colors.black,
            //     shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.horizontal(
            //       right: Radius.circular(25.w),
            //     )),
            //   ),
            // ),
            home: HomePage()
            //  ValueListenableBuilder(
            //     valueListenable: Hive.box('board').listenable(),
            //     builder: (context, box, child) =>
            //         box.isEmpty ? const OnBoardingScreens() : const HomePage()),
            );
      },
    );
  }
}
