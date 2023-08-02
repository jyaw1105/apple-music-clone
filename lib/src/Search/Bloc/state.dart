import 'package:apple_music_clone/model/Genre.dart';
import 'package:apple_music_clone/model/SearchResult.dart';
import 'package:flutter/material.dart';

abstract class SearchState {
  final TextEditingController searchController;
  final List<Genre>? genres;
  final FocusNode searchFocusNode;

  SearchState(
      {this.genres,
      TextEditingController? searchController,
      FocusNode? searchFocusNode})
      : searchController = searchController ?? TextEditingController(),
        searchFocusNode = searchFocusNode ?? FocusNode();

  SearchState copyWith(
      {List<Genre>? genres,
      TextEditingController? searchController,
      FocusNode? searchFocusNode});
}

class SearchErrorState extends SearchState {
  final String message;
  SearchErrorState(
      {required this.message,
      super.genres,
      super.searchController,
      super.searchFocusNode});

  @override
  SearchErrorState copyWith(
      {String? message,
      List<Genre>? genres,
      TextEditingController? searchController,
      FocusNode? searchFocusNode}) {
    return SearchErrorState(
        message: message ?? this.message,
        genres: genres ?? this.genres,
        searchController: searchController ?? this.searchController,
        searchFocusNode: searchFocusNode ?? this.searchFocusNode);
  }
}

class SearchInitialState extends SearchState {
  SearchInitialState(
      {super.genres, super.searchController, super.searchFocusNode});

  @override
  SearchInitialState copyWith(
      {List<Genre>? genres,
      TextEditingController? searchController,
      FocusNode? searchFocusNode}) {
    return SearchInitialState(
        genres: genres ?? this.genres,
        searchController: searchController ?? this.searchController,
        searchFocusNode: searchFocusNode ?? this.searchFocusNode);
  }
}

class SearchOnState extends SearchInitialState {
  SearchOnState({super.genres, super.searchController, super.searchFocusNode});

  @override
  SearchOnState copyWith(
      {List<Genre>? genres,
      TextEditingController? searchController,
      FocusNode? searchFocusNode}) {
    return SearchOnState(
        genres: genres ?? this.genres,
        searchController: searchController ?? this.searchController,
        searchFocusNode: searchFocusNode ?? this.searchFocusNode);
  }
}

class SearchCategoryState extends SearchState {
  SearchCategoryState(
      {super.genres, super.searchController, super.searchFocusNode});

  @override
  SearchCategoryState copyWith(
      {List<Genre>? genres,
      TextEditingController? searchController,
      FocusNode? searchFocusNode}) {
    return SearchCategoryState(
        genres: genres ?? this.genres,
        searchController: searchController ?? this.searchController,
        searchFocusNode: searchFocusNode ?? this.searchFocusNode);
  }
}

class SearchResultsState extends SearchState {
  final Map<String, SearchParam>? searchResults;
  SearchResultsState(
      {this.searchResults,
      super.genres,
      super.searchController,
      super.searchFocusNode});

  @override
  SearchResultsState copyWith(
      {Map<String, SearchParam>? searchResults,
      List<Genre>? genres,
      TextEditingController? searchController,
      FocusNode? searchFocusNode}) {
    return SearchResultsState(
        searchResults: searchResults ?? this.searchResults,
        genres: genres ?? this.genres,
        searchController: searchController ?? this.searchController,
        searchFocusNode: searchFocusNode ?? this.searchFocusNode);
  }
}
