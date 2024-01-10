import 'package:apple_music_clone/core/app_export.dart';
import 'package:apple_music_clone/model/Genre.dart';
import 'package:apple_music_clone/model/SearchResult.dart';
import 'package:apple_music_clone/service/appleMusic/AppleMusicService.dart';
import 'package:apple_music_clone/src/Search/model/search_model.dart';

/// A controller class for the SearchPageScreen.
///
/// This class manages the state of the IntroPageOneScreen, including the
/// current introPageOneModelObj
class SearchPageController extends GetxController {
  RxInt pageIndex = 0.obs;

  final NetworkInfo networkInfo = Get.find<NetworkInfo>();
  RxBool hasConnectivity = RxBool(true);
  Rx<SearchModel> searchModelRx = Rx(SearchModel());

  @override
  void onInit() {
    super.onInit();
    searchModelRx.value.searchFocusNode.addListener(() {
      if (searchModelRx.value.searchFocusNode.hasFocus) {
        onSearching();
      } else {}
    });
  }

  void onSearching() {
    searchModelRx.update((val) {
      val!.searchStatusRx.value = SearchStatus.searching;
    });
  }

  final AppleMusicService appleMusicService = AppleMusicService();

  void searchOnSubmitted(String value) {
    if (searchModelRx.value.searchText.isEmpty) {
      cancelOnTap();
    } else {
      searchModelRx.update((val) async {
        val!.searchStatusRx.value = SearchStatus.result;
        try {
          Map<String, SearchParam<dynamic>> data =
              await appleMusicService.searchTerm(val.searchText);
          val.searchResults.value = data;
        } catch (e) {
          val.searchResults.value = {};
        }
      });
    }
  }

  void cancelOnTap() {
    searchModelRx.update((val) {
      val!.searchStatusRx.value = SearchStatus.off;
      val.searchController.text = "";
      val.searchFocusNode.unfocus();
    });
  }

  @override
  void onReady() {
    super.onReady();
    _listenNetwork();
    getGenres();
  }

  void getGenres() async {
    List<Genre> genres = await appleMusicService.getGenres(limit: 100);
    searchModelRx.update((val) {
      val!.genres.value = genres;
    });
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
