import 'package:apple_music_clone/config/app_config.dart';
import 'package:apple_music_clone/core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:responsive_builder/responsive_builder.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await InitialBindingsAsync().dependencies();
  runApp(MyApp(DevAppConfig()));
}

class MyApp extends StatelessWidget {
  final AppConfig appConfig;

  MyApp(this.appConfig, {super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return GetMaterialApp(
      themeMode: ThemeMode.dark,
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black87,
      ),
      builder: FlutterSmartDialog.init(
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaler: getValueForScreenType<bool>(
                      context: context,
                      mobile: true,
                      tablet: false,
                      desktop: false)
                  ? TextScaler.noScaling
                  : TextScaler.linear(1.30),
              boldText: false,
              invertColors: false,
            ),
            child: OrientationLayoutBuilder(
              portrait: (_) => child ?? Container(),
              mode: OrientationLayoutBuilderMode.portrait,
            ),
          );
        },
      ),
      title: "Apple Music Clone",
      // theme: ThemeProvider.themeData(context),
      debugShowCheckedModeBanner: false,
      initialBinding: InitialBindings(appConfig: appConfig),
      initialRoute: AppRoutes.initialRoute,
      getPages: AppRoutes.pages,
      navigatorObservers: [FlutterSmartDialog.observer],
    );
  }
}
