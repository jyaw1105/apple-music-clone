import 'dart:math';
import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SnappingListView extends StatefulWidget {
  final Axis scrollDirection;
  final ScrollController? controller;

  final IndexedWidgetBuilder? itemBuilder;
  final List<Widget>? children;
  final int? itemCount;

  final double itemExtent;
  final ValueChanged<int>? onItemChanged;

  final EdgeInsets padding;

  SnappingListView(
      {this.scrollDirection = Axis.horizontal,
      this.controller,
      required this.children,
      required this.itemExtent,
      this.onItemChanged,
      this.padding = const EdgeInsets.all(0.0)})
      : assert(itemExtent > 0),
        itemCount = null,
        itemBuilder = null;

  SnappingListView.builder(
      {required this.scrollDirection,
      this.controller,
      required this.itemBuilder,
      this.itemCount,
      required this.itemExtent,
      this.onItemChanged,
      this.padding = const EdgeInsets.all(0.0)})
      : assert(itemExtent > 0),
        children = null;

  @override
  createState() => _SnappingListViewState();
}

class _SnappingListViewState extends State<SnappingListView> {
  int _lastItem = 0;

  @override
  Widget build(BuildContext context) {
    final startPadding = widget.scrollDirection == Axis.horizontal
        ? widget.padding.left
        : widget.padding.top;
    final scrollPhysics = //SnapScrollPhysics.builder(() => [Snap(widget.itemExtent.toDouble(), distance: 0)]);
        SnappingListScrollPhysics(
            mainAxisStartPadding: startPadding, itemExtent: widget.itemExtent);
    final listView = widget.children != null
        ? ListView(
            scrollDirection: widget.scrollDirection,
            controller: widget.controller,
            children: widget.children!,
            itemExtent: widget.itemExtent,
            physics: scrollPhysics,
            padding: widget.padding)
        : ListView.builder(
            scrollDirection: widget.scrollDirection,
            controller: widget.controller,
            itemBuilder: widget.itemBuilder!,
            itemCount: widget.itemCount,
            itemExtent: widget.itemExtent,
            physics: scrollPhysics,
            padding: widget.padding);
    return NotificationListener<ScrollNotification>(
        child: listView,
        onNotification: (notif) {
          if (notif.depth == 0 &&
              widget.onItemChanged != null &&
              notif is ScrollUpdateNotification) {
            final currItem =
                (notif.metrics.pixels - startPadding) ~/ widget.itemExtent;
            if (currItem != _lastItem) {
              _lastItem = currItem;
              widget.onItemChanged!(currItem);
            }
          }
          return false;
        });
  }
}

class SnappingListScrollPhysics extends ScrollPhysics {
  final double mainAxisStartPadding;
  final double itemExtent;

  const SnappingListScrollPhysics(
      {ScrollPhysics? parent,
      this.mainAxisStartPadding = 0.0,
      required this.itemExtent})
      : super(parent: parent);

  @override
  SnappingListScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return SnappingListScrollPhysics(
        parent: buildParent(ancestor),
        mainAxisStartPadding: mainAxisStartPadding,
        itemExtent: itemExtent);
  }

  double _getItem(ScrollMetrics position) {
    return (position.pixels - mainAxisStartPadding) / itemExtent;
  }

  double _getPixels(ScrollMetrics position, double item) {
    return min(item * itemExtent, position.maxScrollExtent);
  }

  double _getTargetPixels(
      ScrollMetrics position, Tolerance tolerance, double velocity) {
    double item = _getItem(position);
    if (velocity < -tolerance.velocity)
      item -= 0.5;
    else if (velocity > tolerance.velocity) item += 0.5;
    return _getPixels(position, item.roundToDouble());
  }

  @override
  Simulation? createBallisticSimulation(
      ScrollMetrics position, double velocity) {
    // If we're out of range and not headed back in range, defer to the parent
    // ballistics, which should put us back in range at a page boundary.
    try {
      if ((velocity <= 0.0 && position.pixels <= position.minScrollExtent) ||
          (velocity >= 0.0 && position.pixels >= position.maxScrollExtent))
        return super.createBallisticSimulation(position, velocity)
            as Simulation;
      final Tolerance tolerance = this.tolerance;
      final double target = _getTargetPixels(position, tolerance, velocity);
      if (target != position.pixels)
        return ScrollSpringSimulation(spring, position.pixels, target, velocity,
            tolerance: tolerance);
    } catch (e) {}
    return null;
  }

  @override
  bool get allowImplicitScrolling => false;
}

abstract class Snap {
  factory Snap(
    double extent, {
    double? distance = 10,
    double? trailingDistance,
    double? leadingDistance,
  }) =>
      _SnapPoint(
        extent,
        toleranceDistance: distance,
        trailingToleranceDistance: trailingDistance,
        leadingToleranceDistance: leadingDistance,
      );

  factory Snap.avoidZone(
    double minExtent,
    double maxExtent, {
    double? delimiter,
  }) = _PreventSnapArea;

  bool shouldApplyFor(ScrollMetrics position, double proposedEnd);

  double targetPixelsFor(
    ScrollMetrics position,
    double proposedEnd,
    Tolerance tolerance,
    double velocity,
  );
}

class _SnapPoint implements Snap {
  final double extent;
  final double trailingExtent;
  final double leadingExtent;

  _SnapPoint(
    this.extent, {
    double? toleranceDistance,
    double? trailingToleranceDistance,
    double? leadingToleranceDistance,
  })  : this.leadingExtent =
            extent - (leadingToleranceDistance ?? toleranceDistance ?? 0),
        this.trailingExtent =
            extent + (trailingToleranceDistance ?? toleranceDistance ?? 0);

  bool shouldApplyFor(ScrollMetrics position, double proposedEnd) {
    return proposedEnd > leadingExtent && proposedEnd < trailingExtent;
  }

  double targetPixelsFor(
    ScrollMetrics position,
    double proposedEnd,
    Tolerance tolerance,
    double velocity,
  ) {
    return extent;
  }
}

class _PreventSnapArea implements Snap {
  final double minExtent;
  final double maxExtent;
  final double delimiter;

  _PreventSnapArea(this.minExtent, this.maxExtent, {double? delimiter})
      : assert(
            delimiter == null ||
                (delimiter >= minExtent) && (delimiter <= maxExtent),
            'The delimiter value should be between the minExtent and maxExtent'),
        this.delimiter = delimiter ?? (minExtent + (maxExtent - minExtent) / 2);

  bool shouldApplyFor(ScrollMetrics position, double proposedEnd) {
    return proposedEnd > minExtent && proposedEnd < maxExtent;
  }

  double targetPixelsFor(
    ScrollMetrics position,
    double proposedEnd,
    Tolerance tolerance,
    double velocity,
  ) {
    if (delimiter < proposedEnd) {
      return maxExtent;
    } else {
      return minExtent;
    }
  }
}

const double _kNavBarLargeTitleHeightExtension = 52.0;

mixin _SnapScrollPhysics on ScrollPhysics {
  BaseSnapScrollPhysics applyTo(ScrollPhysics? ancestor);
}

abstract class SnapScrollPhysics extends ScrollPhysics with _SnapScrollPhysics {
  factory SnapScrollPhysics({
    ScrollPhysics? parent,
    List<Snap> snaps,
  }) = RawSnapScrollPhysics;

  factory SnapScrollPhysics.builder(
    SnapBuilder builder, {
    ScrollPhysics? parent,
  }) = BuilderSnapScrollPhysics;

  static final cupertinoAppBar = SnapScrollPhysics._forCupertinoAppBar();

  factory SnapScrollPhysics._forCupertinoAppBar() =
      CupertinoAppBarSnapScrollPhysics;

  factory SnapScrollPhysics.preventStopBetween(
    double minExtent,
    double maxExtent, {
    double? delimiter,
    ScrollPhysics? parent,
  }) {
    return SnapScrollPhysics(parent: parent, snaps: [
      Snap.avoidZone(minExtent, maxExtent, delimiter: delimiter),
    ]);
  }
}

class RawSnapScrollPhysics extends BaseSnapScrollPhysics {
  RawSnapScrollPhysics({
    ScrollPhysics? parent,
    this.snaps = const [],
  }) : super(parent: parent);

  @override
  final List<Snap> snaps;

  @override
  RawSnapScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return RawSnapScrollPhysics(
      parent: buildParent(ancestor),
      snaps: snaps,
    );
  }
}

class CupertinoAppBarSnapScrollPhysics extends BaseSnapScrollPhysics {
  CupertinoAppBarSnapScrollPhysics({ScrollPhysics? parent})
      : super(parent: parent);
  @override
  final List<Snap> snaps = [
    Snap.avoidZone(0, _kNavBarLargeTitleHeightExtension)
  ];

  @override
  CupertinoAppBarSnapScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return CupertinoAppBarSnapScrollPhysics(
      parent: buildParent(ancestor),
    );
  }
}

typedef SnapBuilder = List<Snap> Function();

class BuilderSnapScrollPhysics extends BaseSnapScrollPhysics {
  BuilderSnapScrollPhysics(this.builder, {ScrollPhysics? parent})
      : super(parent: parent);

  final SnapBuilder builder;

  @override
  List<Snap> get snaps => builder();

  @override
  BuilderSnapScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return BuilderSnapScrollPhysics(
      builder,
      parent: buildParent(ancestor),
    );
  }
}

abstract class BaseSnapScrollPhysics extends ScrollPhysics
    implements SnapScrollPhysics {
  BaseSnapScrollPhysics({
    ScrollPhysics? parent,
  }) : super(parent: parent);

  List<Snap> get snaps;

  double _getTargetPixels(ScrollMetrics position, double proposedEnd,
      Tolerance tolerance, double velocity) {
    Snap? snap = getSnap(position, proposedEnd, tolerance, velocity);
    if (snap == null) return proposedEnd;

    return snap.targetPixelsFor(position, proposedEnd, tolerance, velocity);
  }

  @override
  Simulation? createBallisticSimulation(
      ScrollMetrics position, double velocity) {
    final simulation = super.createBallisticSimulation(position, velocity);
    final proposedPixels = simulation?.x(double.infinity) ?? position.pixels;

    final double target =
        _getTargetPixels(position, proposedPixels, this.tolerance, velocity);
    if ((target - proposedPixels).abs() > precisionErrorTolerance) {
      if (simulation is BouncingScrollSimulation) {
        return BouncingScrollSimulation(
          leadingExtent: math.min(target, position.pixels),
          trailingExtent: math.max(target, position.pixels),
          velocity: velocity,
          position: position.pixels,
          spring: spring,
          tolerance: tolerance,
        );
      }
      return ScrollSpringSimulation(
        spring,
        position.pixels,
        target,
        velocity,
        tolerance: tolerance,
      );
    }
    return simulation;
  }

  @override
  bool get allowImplicitScrolling => false;

  Snap? getSnap(ScrollMetrics position, double proposedEnd, Tolerance tolerance,
      double velocity) {
    for (final snap in snaps) {
      if (snap.shouldApplyFor(position, proposedEnd)) return snap;
    }
    return null;
  }
}
