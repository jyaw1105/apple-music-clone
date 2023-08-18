import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeHelper {
  static Color color1 = Color(0xff59585f);
  static Color color2 = Color(0xff2f2f33);
  static Color color3 = Color(0xff757479);
  static Color color4 = Color(0xff535259);
  static Color playBarBgColor = Color(0xff7b7a7f);
  static Color playBarColor = Color(0xffb0afb4);
  static Color color6 = Color(0xff85848b);
  static Color color7 = Color(0xffb0afb4);
  static Color inactiveColor = Color(0xff4e4d52);
  static Color color8 = Color(0xffacabb0);
  static Color volumeBgColor = Color(0xff6c6b70);
  static Color volumeColor = Color(0xffb0afb4);

  static Color handlerColor = Color(0xff87868d);

  static SliderThemeData sliderTheme = SliderTheme.of(Get.context!).copyWith(
      trackHeight: 6,
      overlayShape: SliderComponentShape.noOverlay,
      thumbColor: Colors.transparent,
      trackShape: RoundedRectSliderTrackShape(),
      tickMarkShape: RoundSliderTickMarkShape(),
      rangeThumbShape: RoundRangeSliderThumbShape(),
      rangeTickMarkShape: RoundRangeSliderTickMarkShape(),
      valueIndicatorShape: SliderComponentShape.noThumb,
      rangeTrackShape: RoundedRectRangeSliderTrackShape(),
      rangeValueIndicatorShape: PaddleRangeSliderValueIndicatorShape(),
      thumbShape: RoundSliderThumbShape(
          enabledThumbRadius: 0.0, pressedElevation: 0.0));
}

extension DurationX on Duration {
  String get mmSSFormat {
    return _formatDurationInHhMmSs(this);
  }

  String _formatDurationInHhMmSs(Duration duration) {
    // final HH = (duration.inHours).toString().padLeft(2, '0');
    final mm = (duration.inMinutes % 60).toString().padLeft(2, '0');
    final ss = (duration.inSeconds % 60).toString().padLeft(2, '0');

    return '$mm:$ss';
  }
}
