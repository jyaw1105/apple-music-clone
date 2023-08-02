import 'package:apple_music_clone/model/Playlists.dart';
import 'package:apple_music_clone/service/navigation/enum.dart';
import 'package:apple_music_clone/src/SearchResult/Bloc/event.dart';
import 'package:apple_music_clone/src/SearchResult/Bloc/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class SearchResultBloc extends Bloc<SearchResultEvent, SearchResultState> {
  SearchResultBloc() : super(SearchResultState()) {
    on<SearchResultOnTapEvent>(_mapSearchResultOnTapEventToState);
    on<SearchResultTabOnChangeEvent>(_mapSearchResultTabOnChangeEventToState);
  }

  void _mapSearchResultOnTapEventToState(
      SearchResultOnTapEvent event, Emitter<SearchResultState> emit) async {
    if (event.data is Playlists) {
      Get.toNamed(NavigationRoute.chart.path,
          arguments: {'href': event.data.href, 'playlists': event.data});
    }
  }

  void _mapSearchResultTabOnChangeEventToState(
      SearchResultTabOnChangeEvent event,
      Emitter<SearchResultState> emit) async {
    emit(state.copyWith(currentPage: event.page));
  }
}
