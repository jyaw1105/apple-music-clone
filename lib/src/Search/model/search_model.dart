import 'package:apple_music_clone/core/app_export.dart';
import 'package:apple_music_clone/model/Genre.dart';
import 'package:apple_music_clone/model/SearchResult.dart';
import 'package:flutter/material.dart';

/// This class defines the variables used in the [search_screen],
/// and is typically used to hold data that is passed between different parts of the application.
class SearchModel {
  final TextEditingController searchController = TextEditingController();
  final Rx<List<Genre>?> genres = Rx(null);
  final FocusNode searchFocusNode = FocusNode();
  final Rx<SearchStatus> searchStatusRx = Rx(SearchStatus.off);
  final Rx<Map<String, SearchParam<dynamic>>?> searchResults = Rx(null);
  String get searchText => searchController.text;
}

enum SearchStatus { searching, result, off }
