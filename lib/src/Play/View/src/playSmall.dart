part of play_page;

class PlaySmall extends GetView<PlayController> {
  @override
  Widget build(BuildContext context) {
    return controller.obx((PlayControllerModel? model) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              _Image(size: 50, song: model?.song),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  model?.song?.attributes?.name ?? "Not Playing",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              IconButton(
                  onPressed: () {
                    controller.playOnClick();
                  },
                  icon: Icon(model!.isPlaying
                      ? FontAwesomeIcons.pause
                      : FontAwesomeIcons.play)),
              IconButton(
                  onPressed: () {
                    controller.nextSong();
                  },
                  icon: Icon(FontAwesomeIcons.forwardFast)),
            ],
          ),
        ));
  }
}
