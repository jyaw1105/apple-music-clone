import 'package:apple_music_clone/src/Search/controller/search_page_controller.dart';

import '../controller/home_page_controller.dart';
import 'package:get/get.dart';

/// A binding class for the HomePageScreen.
///
/// This class ensures that the HomePageController is created when the
/// HomePageScreen is first loaded.
class HomePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomePageController());
    Get.lazyPut(() => SearchPageController());
  }
}
