import 'package:apple_music_clone/core/app_export.dart';
import 'package:apple_music_clone/model/Playlists.dart';
import 'package:apple_music_clone/service/appleMusic/AppleMusicService.dart';
import 'package:apple_music_clone/src/Chart/View/DescriptionModal.dart';
import 'package:apple_music_clone/src/Chart/model/chart_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class ChartPageController extends GetxController {
  late Rx<ChartModel> chartModel;
  final AppleMusicService appleMusicService = AppleMusicService();

  @override
  void onInit() {
    super.onInit();
    dynamic arguments = Get.arguments;
    chartModel = Rx(ChartModel(href: arguments?['href'] as String?));
    if ((chartModel.value.href ?? '').isNotEmpty) {
      chartModel.update((val) {
        val!.playlists.value = arguments?['playlists'] as Playlists?;
      });
      getDataByHref();
    } else {
      SmartDialog.showToast("href is empty");
      Get.back();
    }
  }

  void getDataByHref() async {
    try {
      Playlists playlists =
          await appleMusicService.getDataByHref(chartModel.value.href!);
      chartModel.update((val) {
        val!.playlists.value = playlists;
      });
    } catch (e) {
      SmartDialog.showToast(e.toString());
    }
  }

  void descOnTap() {
    Get.bottomSheet(
      DescriptionModal(playlists: chartModel.value.playlists.value!),
      ignoreSafeArea: false,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
    );
  }
}
