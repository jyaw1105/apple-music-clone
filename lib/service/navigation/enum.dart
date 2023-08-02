import 'dart:typed_data';

import 'package:apple_music_clone/src/Chart/View/Chart.dart';
import 'package:flutter/material.dart';
// import 'package:apple_music_clone/src/Detail/View/DetailView.dart';
import 'package:apple_music_clone/src/Home/View/Home.dart';
import 'package:get/get.dart';
// import 'package:apple_music_clone/src/Login/View/Login.dart';
// import 'package:apple_music_clone/src/Pdf/PdfView.dart';

enum NavigationRoute { 
// login, loginWeb, 
none, home, chart
// detail, detail2, pdf 
}

extension NavigationRouteFactory on NavigationRoute {
  String get path {
    switch (this) {
      // case NavigationRoute.login:
      //   return '/login';
      // case NavigationRoute.loginWeb:
      //   return '/callback';
      case NavigationRoute.none:
        return '/';
      case NavigationRoute.home:
        return '/home';
      case NavigationRoute.chart:
        return '/chart';
      // case NavigationRoute.detail:
      //   return '/detail';
      // case NavigationRoute.detail2:
      //   return '/detail2';
      // case NavigationRoute.pdf:
      //   return '/pdf';
    }
  }

  Widget widget({dynamic data}) {
    switch (this) {
      // case NavigationRoute.splash:
      //   return const SplashScreen();
      // case NavigationRoute.login:
      //   return LoginPage();
      // case NavigationRoute.loginWeb:
      //   return const LoginWebPage();
      case NavigationRoute.none:
        return HomePage();
      // return const OnBoardingScreen();
      case NavigationRoute.home:
        return HomePage();
      case NavigationRoute.chart:
        // final String? type = data['type'] as String?;
        // if (type == null) {
        //   throw Exception('Route $path requires a type');
        // }
        return ChartPage();
      // case NavigationRoute.detail:
      //   final String? code = data['code'] as String?;
      //   if (code == null) {
      //     throw Exception('Route $path requires a code');
      //   }
      //   return DetailView(code: code);
      // case NavigationRoute.detail2:
      //   final String? code = data['code'] as String?;
      //   if (code == null) {
      //     throw Exception('Route $path requires a code');
      //   }
      //   return DetailView2(
      //     code: code,
      //   );
      // case NavigationRoute.pdf:
      //   final Uint8List? bytes = data['bytes'] as Uint8List?;
      //   if (bytes == null) {
      //     throw Exception('Route $path requires a bytes');
      //   }
      //   return PdfView(title: "title", filename: "filename", bytes: bytes);
    }
  }
}
