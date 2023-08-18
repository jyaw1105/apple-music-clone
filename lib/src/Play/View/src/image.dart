part of play_page;

class _Image extends StatelessWidget {
  final double size;
  final Songs? song;
  final Duration? duration;

  _Image({required this.size, required this.song, this.duration});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: duration ?? Duration(milliseconds: 200),
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Color(0xff535257).withOpacity(1.0),
            Color(0xff535259).withOpacity(1.0),
          ]),
          image: song?.attributes?.artwork.url != null
              ? DecorationImage(
                  image: CachedNetworkImageProvider(ImageSizeUtil.parse(
                      song!.attributes!.artwork.url,
                      width: size,
                      height: size)))
              : null,
          borderRadius: BorderRadius.circular(size / pi / 4)),
      height: size,
      width: size,
      child: song?.attributes?.artwork.url != null
          ? Container()
          : Center(
              child: Icon(FontAwesomeIcons.music,
                  color: ThemeHelper.color3, size: size * 0.3),
            ),
    );
    return Container(
      width: 50,
      height: 50,
      padding: EdgeInsets.all(3),
      decoration: BoxDecoration(
          color: Theme.of(context).hintColor,
          borderRadius: BorderRadius.circular(4.0),
          image: song?.attributes?.artwork.url != null
              ? DecorationImage(
                  image: CachedNetworkImageProvider(ImageSizeUtil.parse(
                      song!.attributes!.artwork.url,
                      width: 50,
                      height: 50)))
              : null),
      child: song?.attributes?.artwork.url != null
          ? Container()
          : Icon(FontAwesomeIcons.music),
    );
  }
}
