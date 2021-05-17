import 'package:dart_nvim_api/dart_nvim_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fnvim/core/EditorState.dart';
import 'package:fnvim/core/events/EventHandler.dart';
import 'package:fnvim/core/utils/ColorUtils.dart';
import 'package:fnvim/providers/ThemeProvider.dart';
import 'core/extensions/HighlightsExtension.dart';

import 'package:fnvim/ui/windows/WindowsStack.dart';

void main() {
  runApp(MyApp());
}

final themeProvider = ChangeNotifierProvider<ThemeProvider>((ref) {
  return ThemeProvider();
});

final editorStateProvider = ChangeNotifierProvider<EditorState>((ref) {
  return EditorState();
});

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: Consumer(
        builder: (context, watch, child) {
          var e = watch(editorStateProvider);
          var a =
              e.highlights.from_name('IncSearch')?.rgb_attr?['foreground'] ??
                  255;
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              fontFamily: 'FiraCodeNerdFont',
              scaffoldBackgroundColor: ColorUtils.from_24_bit_int(a),
            ),
            home: MyHomePage(),
          );
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late FocusNode node;
  late Nvim nvim;
  late List<Widget> text;
  late EventHandler handler;

  @override
  void initState() {
    super.initState();
    node = FocusNode();
    text = [];
    handler = EventHandler(context.read(editorStateProvider));
    dostuff();
  }

  void handle(Nvim n, String s, List<dynamic> ar) {
    for (var arg in ar) {
      handler.handleEvent(arg);
    }
  }

  void dostuff() async {
    // Start up Neovim instance, with optional `onNotify` and `onRequest`
    // callbacks.
    // See also Nvim.child()
    nvim = await Nvim.spawn(onNotify: handle, onRequest: handle);
    var opts = UiAttachOptions()
      ..extMessages = true
      ..extTabline = true
      ..extMultigrid = true
      ..rgb = true;

    await nvim.uiAttach(80, 80, opts.asMap());
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: node,
      autofocus: true,
      onKey: (event) {
        if (event.character != null) {
          print(event.character);
          nvim.input(event.character!);
        }
      },
      child: Scaffold(
        body: WindowStack(),
      ),
    );
  }
}
