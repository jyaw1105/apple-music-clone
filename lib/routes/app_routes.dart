import 'package:apple_music_clone/core/app_export.dart';
import 'package:apple_music_clone/src/Chart/chart_page_screen.dart';
import 'package:apple_music_clone/src/Chart/binding/chart_binding.dart';
import 'package:apple_music_clone/src/Home/binding/home_page_binding.dart';
import 'package:apple_music_clone/src/Home/home_page_screen.dart';

class AppRoutes {
  static const String initialRoute = '/';

  static const String homeScreen = '/home';

  static const String chartScreen = '/chart';

  static List<GetPage> pages = [
    GetPage(
      name: initialRoute,
      page: () => HomePage(),
      bindings: [
        HomePageBinding(),
      ],
    ),
    GetPage(
      name: chartScreen,
      page: () => ChartPage(),
      bindings: [
        ChartPageBinding(),
      ],
    ),
  ];
}
