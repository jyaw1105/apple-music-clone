import 'package:apple_music_clone/core/app_export.dart';
import 'package:apple_music_clone/model/Playlists.dart';
import 'package:apple_music_clone/model/SearchResult.dart';

class SearchResultController extends GetxController {
  Map<String, SearchParam<dynamic>>? data;
  SearchResultController(this.data);

  Rx<int?> currentPageRx = Rx(null);
  void tabOnTap(int index) {
    currentPageRx.value = index;
  }

  void itemOnTap(dynamic data) {
    print(data);
    if (data is Playlists) {
      Get.toNamed(AppRoutes.chartScreen,
          arguments: {'href': data.href, 'playlists': data});
    }
  }
}
