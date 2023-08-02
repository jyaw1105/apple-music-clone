class ImageSizeUtil {
  static String parse(String url,
      {bool webp = true, double width = 960, double height = 500}) {
    if (webp) {
      return "${url.substring(0, url.indexOf("{") - 1)}/${width.round()}x${height.round()}sr.webp";
    }
    return url
        .replaceFirst('{w}', width.toStringAsFixed(0))
        .replaceFirst("{h}", height.toStringAsFixed(0));
  }
}
