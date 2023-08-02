abstract class SearchEvent {}

class SearchInitEvent extends SearchEvent {}

class OnSearchEvent extends SearchEvent {}

class OffSearchEvent extends SearchEvent {}

class OnSearchDoneEvent extends SearchEvent {}

class SearchingResultEvent extends SearchEvent {}
