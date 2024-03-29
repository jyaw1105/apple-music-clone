part of play_page;

class _SongInfo extends StatelessWidget {
  final Songs? song;
  final bool isHeader;

  _SongInfo({required this.song, required this.isHeader});

  final Duration duration = Duration(milliseconds: 200);

  @override
  Widget build(BuildContext context) {
    double safeHeight = (MediaQuery.of(context).size.height -
        MediaQuery.of(context).viewPadding.bottom);
    double size = isHeader ? 50.0 : safeHeight * 0.3;
    double? right = isHeader ? null : 0.0;
    double imageHeadGap = isHeader ? 0.0 : safeHeight * 0.02;
    double infoTopPadding = isHeader ? 5.0 : safeHeight * 0.31 + 50;
    double infoLeftPadding = isHeader ? size + 15.0 : 0.0;
    double fontSize = isHeader ? 18 : 24;
    double infoBottomPadding = isHeader ? 10 : safeHeight * 0.0;

    return Stack(
      alignment: Alignment.topLeft,
      children: [
        AnimatedPositioned(
            duration: duration,
            left: 0,
            right: right,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                AnimatedContainer(
                  duration: duration,
                  height: imageHeadGap,
                ),
                _Image(
                  size: size,
                  song: song,
                  duration: duration,
                ),
              ],
            )),
        AnimatedContainer(
            duration: duration,
            margin: EdgeInsets.only(
                top: infoTopPadding,
                left: infoLeftPadding,
                bottom: infoBottomPadding),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    song?.attributes?.name ?? "Not Playing",
                    style: TextStyle(
                        fontSize: fontSize, fontWeight: FontWeight.w600),
                    maxLines: 1,
                    overflow: TextOverflow.fade,
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    song?.attributes?.artistName ?? "",
                    style: TextStyle(
                        fontSize: fontSize,
                        fontWeight: FontWeight.w500,
                        color: ThemeHelper.color8),
                    maxLines: 1,
                    overflow: TextOverflow.fade,
                  ),
                ),
              ],
            )),
      ],
    );
  }
}
