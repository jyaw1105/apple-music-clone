import 'package:apple_music_clone/service/appleMusic/PlayService.dart';
import 'package:apple_music_clone/src/Browse/View/Browse.dart';
import 'package:apple_music_clone/src/Home/Bloc/bloc.dart';
import 'package:apple_music_clone/src/Home/Bloc/event.dart';
import 'package:apple_music_clone/src/Home/Bloc/state.dart';
import 'package:apple_music_clone/src/Home/View/ComingSoon.dart';
import 'package:apple_music_clone/src/Play/View/Play.dart';
import 'package:apple_music_clone/src/Search/View/Search.dart';
import 'package:connectivity_bloc/connectivity_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final HomeBloc bloc = HomeBloc();

  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    Get.put(PlayController(PlayControllerModel()));
    animationController = AnimationController(
        duration: Duration(milliseconds: 400),
        reverseDuration: Duration(milliseconds: 450),
        vsync: this);
  }

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
            List<Widget> children =
                connectivityBloc.state is ConnectivityFailureState
                    ? List.generate(
                        3, (index) => Center(child: Text("No Connectivity")))
                    : [BrowsePage(), ComingSoonPage(), SearchPage()];
            return Scaffold(
                body: IndexedStack(
                  children: children
                      .map((e) =>
                          Navigator(onGenerateRoute: (RouteSettings settings) {
                            return MaterialPageRoute(
                                settings: settings,
                                builder: (BuildContext context) {
                                  return e;
                                });
                          }))
                      .toList(),
                  index: state.pageIndex,
                ),
                bottomSheet: BottomSheet(
                    animationController: animationController,
                    showDragHandle: false,
                    enableDrag: true,
                    onDragStart: (DragStartDetails _) {},
                    onDragEnd: (details, {bool isClosing = false}) {
                      if (isClosing) {
                      } else {
                        Get.bottomSheet(PlayPage(),
                            isScrollControlled: true,
                            ignoreSafeArea: false,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20))));
                      }
                    },
                    onClosing: () {},
                    builder: (_) {
                      return PlaySmall();
                    }),
                bottomNavigationBar: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CupertinoTabBar(
                        currentIndex: state.pageIndex,
                        onTap: (int index) {
                          bloc.add(ChangeTabEvent(page: index));
                        },
                        items: [
                          // BottomNavigationBarItem(
                          //   icon: Icon(Icons.play_circle_fill_rounded),
                          //   label: "Listen Now",
                          // ),
                          BottomNavigationBarItem(
                              icon: Icon(Icons.grid_view_rounded),
                              label: "Browse"),
                          BottomNavigationBarItem(
                              icon: Icon(Icons.my_library_music_rounded),
                              label: "Library"),
                          BottomNavigationBarItem(
                              icon: Icon(Icons.search_rounded),
                              label: "Search"),
                        ])
                  ],
                ));
          },
        )));
  }
}
