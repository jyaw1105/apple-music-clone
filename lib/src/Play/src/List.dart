part of play_page;

class _List extends GetView<PlayController> {
  final List<PlayOption> currentOption;
  _List({required this.currentOption});

  @override
  Widget build(BuildContext context) {
    return controller.obx((PlayControllerModel? model) => Scrollbar(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                        child: AnimatedContainer(
                      duration: Duration(milliseconds: 400),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Playing Next",
                            style: TextStyle(fontSize: 18),
                          ),
                          if (model?.playlists != null)
                            Padding(
                              padding: EdgeInsets.only(top: 5),
                              child: Text(
                                "From ${model!.playlists!.attributes.name}",
                                style: TextStyle(
                                    fontSize: 15, color: ThemeHelper.color7),
                              ),
                            ),
                        ],
                      ),
                    )),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: _PlayOptionButton(
                          value: PlayOption.shuffle,
                          current: currentOption,
                          icon: FontAwesomeIcons.shuffle,
                          size: 20,
                          padding: EdgeInsets.all(6.0),
                          onTap: controller.playOptionOnSelected,
                        )),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: _PlayOptionButton(
                          value: currentOption.contains(PlayOption.loopSingle)
                              ? PlayOption.loopSingle
                              : PlayOption.loop,
                          current: currentOption,
                          icon: currentOption.contains(PlayOption.loopSingle)
                              ? FontAwesomeIcons.one
                              : FontAwesomeIcons.repeat,
                          size: 20,
                          padding: EdgeInsets.all(6.0),
                          onTap: controller.playOptionOnSelected,
                        )),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: _PlayOptionButton(
                        value: PlayOption.auto,
                        current: currentOption,
                        size: 18,
                        padding: EdgeInsets.fromLTRB(5.0, 7.0, 9.0, 7.0),
                        icon: FontAwesomeIcons.infinity,
                        onTap: controller.playOptionOnSelected,
                      ),
                    )
                  ],
                ),
                SizedBox(height: 15),
                ...(model?.playlists?.relationships?.tracks.data ?? [])
                    .map((e) {
                  return SongTile(
                    song: e,
                    onTap: () {
                      controller.changeSong(e);
                    },
                  );
                }).toList()
              ],
            ),
          ),
        ));
  }
}
