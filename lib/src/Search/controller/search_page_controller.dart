import 'package:apple_music_clone/core/app_export.dart';
import 'package:apple_music_clone/model/Genre.dart';
import 'package:apple_music_clone/model/Playlists.dart';
import 'package:apple_music_clone/model/SearchResult.dart';
import 'package:apple_music_clone/service/appleMusic/AppleMusicService.dart';
import 'package:apple_music_clone/src/Chart/chart_page_screen.dart';
import 'package:apple_music_clone/src/Home/controller/home_page_controller.dart';
import 'package:apple_music_clone/src/Search/model/search_model.dart';
import 'package:flutter/material.dart';

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
        val.searchResults.value = null;
      });
      appleMusicService
          .searchTerm(searchModelRx.value.searchText)
          .then((Map<String, SearchParam<dynamic>> data) {
        searchModelRx.update((val) {
          val!.searchResults.value = data;
        });
      }).catchError((er) {
        searchModelRx.update((val) {
          val!.searchResults.value = {};
        });
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

  void itemOnTap(dynamic data) {
    print(data);
    if (data is Playlists) {
      HomePageController homePageController = Get.find<HomePageController>();
      int index = homePageController.pageIndex.value;
      Navigator.of(
              homePageController.navigatorKeys[index].currentState!.context)
          .push(
        MaterialPageRoute(
          builder: (_) => ChartPage(
            href: data.href,
            playlists: data,
          ),
          settings: RouteSettings(
            arguments: {
              'href': data.href,
              'playlists': data,
            },
          ),
        ),
      );
    }
  }
}
