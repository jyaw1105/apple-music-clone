import 'dart:io';

import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:apple_music_clone/data/AppleMusicToken.dart';
import 'package:apple_music_clone/src/Home/Bloc/event.dart';
import 'package:apple_music_clone/src/Home/Bloc/state.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<InitAppEvent>(_mapInitAppEventToState);
    on<InitAppleMusicEvent>(_mapInitAppleMusicEventToState);
    on<ChangeTabEvent>(_mapChangeTabEventToState);
  }

  void _mapInitAppEventToState(
      InitAppEvent event, Emitter<HomeState> emit) async {
    if (Platform.isIOS) {
      try {
        await AppTrackingTransparency.requestTrackingAuthorization();
      } catch (e) {}
    }
  }

  void _mapChangeTabEventToState(
      ChangeTabEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(pageIndex: event.page));
  }

  void _mapInitAppleMusicEventToState(
      InitAppleMusicEvent event, Emitter<HomeState> emit) async {
    try {
      emit(HomeLoadInProgress());
      await AppleMusicToken.initPlatformState();
      emit(HomeInitSuccess());
    } on PlatformException catch (e) {
      emit(HomeInitFailed(message: e.message ?? e.code));
    } catch (e) {
      emit(HomeInitFailed(message: "$e"));
    }
  }
}
