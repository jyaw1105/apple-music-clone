import 'package:apple_music_clone/core/app_export.dart';
import 'package:flutter/material.dart';

/// A controller class for the HomePageScreen.
///
/// This class manages the state of the HomePageScreen
class HomePageController extends GetxController
    with GetSingleTickerProviderStateMixin {
  RxInt pageIndex = 0.obs;
  late AnimationController animationController;

  final NetworkInfo networkInfo = Get.find<NetworkInfo>();
  RxBool hasConnectivity = RxBool(true);
  final List<GlobalKey<State>> navigatorKeys =
      List.generate(3, (index) => GlobalKey());

  @override
  void onInit() {
    super.onInit();
    animationController = AnimationController(
        duration: Duration(milliseconds: 400),
        reverseDuration: Duration(milliseconds: 450),
        vsync: this);
  }

  @override
  void onReady() {
    super.onReady();
    _listenNetwork();
  }

  void _listenNetwork() {
    networkInfo.onConnectivityChanged.listen((event) async {
      hasConnectivity.value = await networkInfo.isConnected();
    });
  }

  void tabOnTap(int index) {
    pageIndex.value = index;
  }
}
