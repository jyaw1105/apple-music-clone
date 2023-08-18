part of play_page;

class _ControlButton extends StatelessWidget {
  final void Function()? backOnPressed, playOnPressed, nextOnPressed;
  final bool isPlaying;
  _ControlButton(
      {required this.backOnPressed,
      required this.playOnPressed,
      required this.nextOnPressed,
      required this.isPlaying});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
            iconSize: 70,
            onPressed: backOnPressed,
            icon: Icon(
              FontAwesomeIcons.backwardFast,
              size: 35,
            )),
        SizedBox(width: 15.0),
        IconButton(
            iconSize: 70,
            onPressed: playOnPressed,
            icon: Icon(
                isPlaying ? FontAwesomeIcons.pause : FontAwesomeIcons.play,
                size: 45)),
        SizedBox(width: 15.0),
        IconButton(
            iconSize: 70,
            onPressed: nextOnPressed,
            icon: Icon(FontAwesomeIcons.forwardFast, size: 35)),
      ],
    );
  }
}
