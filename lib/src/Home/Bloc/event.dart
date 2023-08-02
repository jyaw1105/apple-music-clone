abstract class HomeEvent {}

class InitAppEvent extends HomeEvent {}

class InitAppleMusicEvent extends HomeEvent {}

class ChangeTabEvent extends HomeEvent {
  final int page;
  ChangeTabEvent({required this.page});
}
