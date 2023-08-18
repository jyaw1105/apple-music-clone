part of play_page;

class _DisplayOptionButton extends _OptionButton {
  final DisplayOption value;
  final DisplayOption current;
  final void Function(DisplayOption) onTap;
  _DisplayOptionButton(
      {required this.value,
      required this.current,
      required super.icon,
      super.enabled,
      required this.onTap})
      : super(selected: value == current, onTapFunc: () => onTap(value));
}

class _PlayOptionButton extends _OptionButton {
  final PlayOption value;
  final List<PlayOption> current;
  final void Function(PlayOption) onTap;
  _PlayOptionButton(
      {required this.value,
      required this.current,
      required super.icon,
      super.enabled,
      super.size,
      super.padding,
      required this.onTap})
      : super(selected: current.contains(value), onTapFunc: () => onTap(value));
}

class _OptionButton<T> extends StatelessWidget {
  final bool selected;
  final IconData icon;
  final bool enabled;
  final void Function()? onTapFunc;
  final double? size;
  final EdgeInsets? padding;
  _OptionButton(
      {required this.selected,
      required this.icon,
      this.enabled = true,
      required this.onTapFunc,
      this.size,
      this.padding});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 100),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: selected ? ThemeHelper.volumeColor : Colors.transparent),
      padding: padding ?? EdgeInsets.all(3.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        child: Center(
          child: Icon(
            icon,
            size: size ?? 26,
            color: enabled
                ? (selected ? ThemeHelper.color2 : ThemeHelper.volumeColor)
                : ThemeHelper.inactiveColor,
          ),
        ),
        onTap: enabled ? onTapFunc : null,
      ),
    );
  }
}
