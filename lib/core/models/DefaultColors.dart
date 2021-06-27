import 'package:equatable/equatable.dart';

class DefaultColors with EquatableMixin {
  int rgb_fg;
  int rgb_bg;
  int rgb_sp;

  DefaultColors(this.rgb_fg, this.rgb_bg, this.rgb_sp);

  @override
  List<Object?> get props => [rgb_fg, rgb_bg, rgb_sp];
}
