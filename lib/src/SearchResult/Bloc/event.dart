

abstract class SearchResultEvent {}

class SearchResultTabOnChangeEvent extends SearchResultEvent {
  final int page;
  SearchResultTabOnChangeEvent({required this.page});
}

class SearchResultOnTapEvent extends SearchResultEvent {
  dynamic data;
  SearchResultOnTapEvent({required this.data});
}
