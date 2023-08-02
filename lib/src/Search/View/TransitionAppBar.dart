import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TransitionAppBar extends StatefulWidget {
  final void Function(String)? searchOnSubmitted;
  final TextEditingController searchController;
  final FocusNode searchFocusNode;
  final void Function() cancelOnTap;

  TransitionAppBar(
      {required this.searchOnSubmitted,
      required this.searchController,
      required this.searchFocusNode,
      required this.cancelOnTap,
      Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => TransitionAppBarState();
}

class TransitionAppBarState extends State<TransitionAppBar>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    Widget child = SliverPersistentHeader(
      pinned: true,
      delegate: _TransitionAppBarDelegate(context,
          searchOnSubmitted: widget.searchOnSubmitted,
          searchController: widget.searchController,
          searchFocusNode: widget.searchFocusNode,
          cancelOnTap: widget.cancelOnTap),
    );
    return child;
  }
}

class _TransitionAppBarDelegate extends SliverPersistentHeaderDelegate {
  final BuildContext context;
  final void Function(String)? searchOnSubmitted;
  final TextEditingController searchController;
  final FocusNode searchFocusNode;
  final void Function() cancelOnTap;

  _TransitionAppBarDelegate(this.context,
      {required this.searchOnSubmitted,
      required this.searchController,
      required this.searchFocusNode,
      required this.cancelOnTap});

  @override
  double get maxExtent =>
      90 + MediaQuery.of(context).viewPadding.top + kToolbarHeight;

  @override
  double get minExtent =>
      60 + MediaQuery.of(context).viewPadding.top + kToolbarHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    double tempVal = 70 * maxExtent / 100;
    final progress = (shrinkOffset > tempVal ? 1.0 : shrinkOffset / tempVal);

    return Stack(
      children: [
        AppBar(
          title: Opacity(opacity: progress, child: Text("Search")),
          elevation: 0.0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        AnimatedPositioned(
            duration: Duration(milliseconds: 300),
            bottom: 65,
            left: 10,
            right: 10,
            curve: Curves.easeIn,
            child: Opacity(
                opacity: 1 - progress,
                child: Text(
                  "Search",
                  style: TextStyle(
                      fontSize: 32,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ))),
        AnimatedPositioned(
            duration: Duration(milliseconds: 300),
            bottom: 0,
            left: 10,
            right: 10,
            curve: Curves.easeIn,
            child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                margin: EdgeInsets.only(bottom: 15),
                child: Row(
                  children: [
                    Expanded(
                      child: CupertinoTextField(
                        focusNode: searchFocusNode,
                        controller: searchController,
                        keyboardType: TextInputType.text,
                        placeholder: 'Artists, Songs, Lyrics and More',
                        placeholderStyle:
                            TextStyle(fontSize: 14.0, color: Color(0xffbfbfbf)),
                        prefix: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(5.0, 5.0, 0.0, 5.0),
                          child: Icon(
                            Icons.search,
                            size: 18,
                            color: Color(0xffbfbfbf),
                          ),
                        ),
                        style: TextStyle(fontSize: 14.0, color: Colors.white),
                        textInputAction: TextInputAction.search,
                        onSubmitted: searchOnSubmitted,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: Color(0xff2c2c2c),
                        ),
                      ),
                    ),
                    if (searchFocusNode.hasFocus ||
                        searchController.text.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: GestureDetector(
                          child: Text("Cancel"),
                          onTap: cancelOnTap,
                        ),
                      )
                  ],
                ))),
      ],
    );
  }

  @override
  bool shouldRebuild(_TransitionAppBarDelegate oldDelegate) {
    return true;
  }
}
