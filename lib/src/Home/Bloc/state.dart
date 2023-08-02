abstract class HomeState {
  int pageIndex = 0;

  HomeState({this.pageIndex = 0});

  HomeState copyWith({int? pageIndex});
}

class HomeInitial extends HomeState {
  HomeInitial({super.pageIndex});

  @override
  HomeInitial copyWith({int? pageIndex}) {
    return HomeInitial(pageIndex: pageIndex ?? this.pageIndex);
  }
}

class HomeLoadInProgress extends HomeState {
  HomeLoadInProgress({super.pageIndex});

  @override
  HomeLoadInProgress copyWith({int? pageIndex}) {
    return HomeLoadInProgress(pageIndex: pageIndex ?? this.pageIndex);
  }
}

class HomeInitSuccess extends HomeState {
  HomeInitSuccess({super.pageIndex});

  @override
  HomeInitSuccess copyWith({int? pageIndex}) {
    return HomeInitSuccess(pageIndex: pageIndex ?? this.pageIndex);
  }
}

class HomeInitFailed extends HomeState {
  final String message;
  HomeInitFailed({required this.message, super.pageIndex});

  @override
  HomeInitFailed copyWith({int? pageIndex}) {
    return HomeInitFailed(
        message: message, pageIndex: pageIndex ?? this.pageIndex);
  }
}
