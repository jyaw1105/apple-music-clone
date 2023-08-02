import 'package:apple_music_clone/src/Browse/View/Browse.dart';
import 'package:apple_music_clone/src/Home/Bloc/bloc.dart';
import 'package:apple_music_clone/src/Home/Bloc/event.dart';
import 'package:apple_music_clone/src/Home/Bloc/state.dart';
import 'package:apple_music_clone/src/Home/View/ComingSoon.dart';
import 'package:apple_music_clone/src/Search/View/Search.dart';
import 'package:connectivity_bloc/connectivity_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class HomePage extends StatelessWidget {
  final HomeBloc bloc = HomeBloc();

  @override
  Widget build(BuildContext context) {
    ConnectivityBloc connectivityBloc =
        BlocProvider.of<ConnectivityBloc>(context);

    return BlocProvider<HomeBloc>(
        create: (_) => bloc..add(InitAppleMusicEvent()),
        child: BlocListener<HomeBloc, HomeState>(listener: (context, state) {
          if (state is HomeInitFailed) {
            SmartDialog.showToast(state.message);
          }
        }, child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, HomeState state) {
            return Scaffold(
                body: IndexedStack(
                  index: state.pageIndex,
                  children: connectivityBloc.state is ConnectivityFailureState
                      ? List.generate(
                          3, (index) => Center(child: Text("No Connectivity")))
                      : state is HomeInitSuccess
                          ? [
                              // ComingSoonPage(),
                              BrowsePage(),
                              ComingSoonPage(),
                              SearchPage()
                            ]
                          : state is HomeInitFailed
                              ? List.generate(3,
                                  (index) => Center(child: Text(state.message)))
                              : List.generate(
                                  3, (index) => Center(child: Text("Loading"))),
                ),
                bottomNavigationBar: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  items: const <BottomNavigationBarItem>[
                    // BottomNavigationBarItem(
                    //   icon: Icon(Icons.play_circle_fill_rounded),
                    //   label: "Listen Now",
                    // ),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.grid_view_rounded), label: "Browse"),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.my_library_music_rounded),
                        label: "Library"),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.search_rounded), label: "Search"),
                  ],
                  currentIndex: state.pageIndex,
                  onTap: (int index) {
                    bloc.add(ChangeTabEvent(page: index));
                  },
                ));
          },
        )));
  }
}
