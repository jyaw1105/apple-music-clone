part of play_page;

class _Volume extends StatelessWidget {
  final void Function(double)? onChanged;
  final double value;
  _Volume({required this.onChanged, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(right: 0),
          child: Icon(
            FontAwesomeIcons.volumeLow,
            size: 18,
            color: ThemeHelper.volumeColor,
          ),
        ),
        Expanded(
          child: Container(
            height: ThemeHelper.sliderTheme.trackHeight,
            child: SliderTheme(
                child: Slider(
                  activeColor: ThemeHelper.volumeColor,
                  inactiveColor: ThemeHelper.volumeBgColor,
                  min: 0.0,
                  max: 1.0,
                  onChanged: onChanged,
                  value: value,
                ),
                data: ThemeHelper.sliderTheme),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 0),
          child: Icon(
            FontAwesomeIcons.volumeHigh,
            size: 18,
            color: ThemeHelper.volumeColor,
          ),
        ),
      ],
    );
  }
}
