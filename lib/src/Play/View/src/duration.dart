part of play_page;

class _DurationBar extends StatelessWidget {
  final Duration? duration;
  final Duration? currentDuration;
  final void Function(double)? onChanged;

  _DurationBar(
      {required this.duration,
      required this.currentDuration,
      required this.onChanged});

  final String defaultStr = '--:--';
  final TextStyle textStyle =
      TextStyle(fontSize: 14, color: ThemeHelper.playBarBgColor);

  @override
  Widget build(BuildContext context) {
    final String currentDurationStr = currentDuration?.mmSSFormat ?? defaultStr;
    String durationStr = defaultStr;
    try {
      Duration _ =
          Duration(seconds: duration!.inSeconds - currentDuration!.inSeconds);
      durationStr = "-${_.mmSSFormat}";
      // ignore: empty_catches
    } catch (e) {}

    return Column(
      children: [
        Container(
          height: ThemeHelper.sliderTheme.trackHeight,
          child: SliderTheme(
              child: Slider(
                activeColor: ThemeHelper.playBarColor,
                inactiveColor: ThemeHelper.playBarBgColor,
                min: 0.0,
                max: (duration?.inSeconds ?? 1.0).toDouble(),
                onChanged: onChanged,
                value: (currentDuration?.inSeconds ?? 1.0).toDouble(),
              ),
              data: ThemeHelper.sliderTheme),
        ),
        SizedBox(height: 15.0),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: .0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                currentDurationStr,
                style: textStyle,
              ),
              Text(durationStr, style: textStyle),
            ],
          ),
        )
      ],
    );
  }
}
