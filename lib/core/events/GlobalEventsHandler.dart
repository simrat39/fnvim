import 'package:fnvim/core/EditorState.dart';
import 'package:fnvim/core/extensions/ForEachArgExtension.dart';
import 'package:fnvim/core/models/DefaultColors.dart';
import 'package:fnvim/core/models/Highlight.dart';

class GlobalEventsHandler {
  final EditorState state;

  GlobalEventsHandler(this.state);

  /// The first three arguments set the default foreground, background and
  /// special colors respectively. `cterm_fg` and `cterm_bg` specifies the
  /// default color codes to use in a 256-color terminal.
  ///
  /// The RGB values will always be valid colors, by default. If no
  /// colors have been set, they will default to black and white, depending
  /// on 'background'. By setting the `ext_termcolors` option, instead
  /// -1 will be used for unset colors. This is mostly useful for a TUI
  /// implementation, where using the terminal builtin ("ANSI") defaults
  /// are expected.
  ///
  /// Note: Unlike the corresponding |ui-grid-old| events, the screen is not
  /// always cleared after sending this event. The UI must repaint the
  /// screen with changed background color itself.
  void default_colors_set(List<dynamic> data) {
    data.for_each_arg((arg) {
      var cols = DefaultColors(arg[1], arg[2], arg[3]);
      state.defaultColors = cols;
    });
  }

  /// Add a highlight with `id`  to the highlight table, with the
  /// attributes specified by the `rgb_attr` and `cterm_attr` dicts, with the
  /// following (all optional) keys.
  ///
  /// `foreground`: foreground color.
  /// `background`: background color.
  /// `special`: color to use for underline and undercurl, when present.
  /// `reverse`: reverse video. Foreground and background colors are
  ///   switched.
  /// `italic`: italic text.
  /// `bold`:  bold text.
  /// `strikethrough`:  struckthrough text.
  /// `underline`: underlined text. The line has `special` color.
  /// `undercurl`: undercurled text. The curl has `special` color.
  /// `blend`: Blend level (0-100). Could be used by UIs to support
  ///   blending floating windows to the background or to
  ///   signal a transparent cursor.
  ///
  /// For absent color keys the default color should be used. Don't store
  /// the default value in the table, rather a sentinel value, so that
  /// a changed default color will take effect.
  /// All boolean keys default to false, and will only be sent when they
  /// are true.
  ///
  /// Highlights are always transmitted both for both the RGB format and as
  /// terminal 256-color codes, as the `rgb_attr` and `cterm_attr` parameters
  /// respectively. The |ui-rgb| option has no effect effect anymore.
  /// Most external UIs will only need to store and use the `rgb_attr`
  /// attributes.
  ///
  /// `id` 0 will always be used for the default highlight with colors defined
  /// by `default_colors_set` and no styles applied.
  ///
  /// Note: Nvim may reuse `id` values if its internal highlight table is full.
  /// In that case Nvim will always issue redraws of screen cells that are
  /// affected by redefined ids, so UIs do not need to keep track of this
  /// themselves.
  ///
  /// `info` is an empty array by default, and will be used by the
  /// |ui-hlstate| extension explained below.
  void hl_attr_define(List<dynamic> data) {
    data.for_each_arg((arg) {
      var id = arg[0];
      var hl = Highlight(arg[0], arg[1], arg[2], arg[3]);
      state.highlights[id] = hl;
    });
  }

  /// The bulitin highlight group `name` was set to use the attributes `hl_id`
  /// defined by a previous `hl_attr_define` call. This event is not needed
  /// to render the grids which use attribute ids directly, but is useful
  /// for an UI who want to render its own elements with consistent
  /// highlighting. For instance an UI using |ui-popupmenu| events, might
  /// use the |hl-Pmenu| family of builtin highlights.
  void hl_group_set(List<dynamic> data) {
    data.for_each_arg((arg) {
      var id = arg[1];
      var name = arg[0];
      state.highlights[id]?.addName(name);
    });
  }

  /// UI-related option changed, where `name` is one of:
  ///
  /// 'arabicshape'
  /// 'ambiwidth'
  /// 'emoji'
  /// 'guifont'
  /// 'guifontwide'
  /// 'linespace'
  /// 'mousefocus'
  /// 'pumblend'
  /// 'showtabline'
  /// 'termguicolors'
  /// "ext_*" (all |ui-ext-options|)
  ///
  /// Triggered when the UI first connects to Nvim, and whenever an option
  /// is changed by the user or a plugin.
  ///
  /// Options are not represented here if their effects are communicated in
  /// other UI events. For example, instead of forwarding the 'mouse' option
  /// value, the "mouse_on" and "mouse_off" UI events directly indicate if
  /// mouse support is active. Some options like 'ambiwidth' have already
  /// taken effect on the grid, where appropriate empty cells are added,
  /// however a UI might still use such options when rendering raw text
  /// sent from Nvim, like for |ui-cmdline|.
  void option_set(List<dynamic> data) {
    data.for_each_arg((arg) {
      state.options[arg[0]] = arg[1];
    });
  }
}
