import 'package:connectivity_bloc/connectivity_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'service/navigation/enum.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiBlocProvider(
        providers: [
          BlocProvider<ConnectivityBloc>(
            create: (context) => ConnectivityBloc(),
          ),
        ],
        child: GetMaterialApp(
          themeMode: ThemeMode.dark,
          darkTheme: ThemeData(
              brightness: Brightness.dark,
              scaffoldBackgroundColor: Colors.black87),
          builder: FlutterSmartDialog.init(builder: (context, child) {
            return MediaQuery(
                data: MediaQuery.of(context).copyWith(
                    textScaleFactor: getValueForScreenType<bool>(
                            context: context,
                            mobile: true,
                            tablet: false,
                            desktop: false)
                        ? 1.0
                        : 1.30,
                    boldText: false,
                    invertColors: false),
                child: OrientationLayoutBuilder(
                  portrait: (_) => child ?? Container(),
                  mode: OrientationLayoutBuilderMode.portrait,
                ));
          }),
          title: "Apple Music Clone",
          // theme: ThemeProvider.themeData(context),
          debugShowCheckedModeBanner: false,
          navigatorObservers: [FlutterSmartDialog.observer],
          initialRoute: NavigationRoute.none.path,
          getPages: NavigationRoute.values
              .map((e) => GetPage(
                  name: e.path, page: () => e.widget(), binding: e.bindings))
              .toList(),
        ));
    // );
  }
}
