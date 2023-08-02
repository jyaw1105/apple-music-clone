import 'package:apple_music_clone/model/Genre.dart';
import 'package:apple_music_clone/model/SearchResult.dart';
import 'package:apple_music_clone/service/appleMusic/AppleMusicService.dart';
import 'package:apple_music_clone/src/Search/Bloc/event.dart';
import 'package:apple_music_clone/src/Search/Bloc/state.dart';
import 'package:apple_music_clone/src/SearchResult/Bloc/bloc.dart';
import 'package:apple_music_clone/src/SearchResult/Bloc/event.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitialState()) {
    on<SearchInitEvent>(_mapSearchInitEventToState);
    on<OnSearchEvent>(_mapOnSearchEventToState);
    on<OffSearchEvent>(_mapOffSearchEventToState);
    on<OnSearchDoneEvent>(_mapOnSearchDoneEventToState);
    on<SearchingResultEvent>(_mapSearchingResultEventToState);
  }

  final AppleMusicService appleMusicService = AppleMusicService();

  void _mapSearchInitEventToState(
      SearchInitEvent event, Emitter<SearchState> emit) async {
    state.searchFocusNode.addListener(() {
      if (state.searchFocusNode.hasFocus) {
        add(OnSearchEvent());
      } else {}
    });
    List<Genre> genres = await appleMusicService.getGenres(limit: 100);
    emit(state.copyWith(
      genres: genres,
    ));
  }

  void _mapOnSearchEventToState(
      OnSearchEvent event, Emitter<SearchState> emit) async {
    emit(SearchOnState(
        genres: state.genres,
        searchController: state.searchController,
        searchFocusNode: state.searchFocusNode));
  }

  void _mapOffSearchEventToState(
      OffSearchEvent event, Emitter<SearchState> emit) async {
    FocusScope.of(Get.context!).requestFocus(FocusNode());
    emit(SearchInitialState(
        genres: state.genres,
        searchController: state.searchController..text = "",
        searchFocusNode: state.searchFocusNode));
  }

  void _mapOnSearchDoneEventToState(
      OnSearchDoneEvent event, Emitter<SearchState> emit) async {
    if (state.searchController.text.isEmpty) {
      add(OffSearchEvent());
    } else {
      emit(SearchResultsState(
          genres: state.genres,
          searchController: state.searchController,
          searchFocusNode: state.searchFocusNode));
      add(SearchingResultEvent());
    }
  }

  void _mapSearchingResultEventToState(
      SearchingResultEvent event, Emitter<SearchState> emit) async {
    try {
      Map<String, SearchParam<dynamic>> data =
          await appleMusicService.searchTerm(state.searchController.text);
      emit(SearchResultsState(
          searchResults: data,
          genres: state.genres,
          searchController: state.searchController,
          searchFocusNode: state.searchFocusNode));
    } catch (e) {
      emit(SearchResultsState(
          searchResults: {},
          genres: state.genres,
          searchController: state.searchController,
          searchFocusNode: state.searchFocusNode));
    }
  }
}
