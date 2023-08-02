class SearchResultState {
  int currentPage;

  SearchResultState({int? currentPage}) : currentPage = currentPage ?? 0;

  SearchResultState copyWith({int? currentPage}) =>
      SearchResultState(currentPage: currentPage ?? this.currentPage);
}
