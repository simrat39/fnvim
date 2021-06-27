import 'package:dart_nvim_api/dart_nvim_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fnvim/core/EditorState.dart';
import 'package:fnvim/core/events/EventHandler.dart';
import 'package:fnvim/providers/ThemeProvider.dart';
import 'package:fnvim/ui/utils/GridUtils.dart';

import 'package:fnvim/ui/windows/WindowsStack.dart';
import 'package:pedantic/pedantic.dart';

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
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: 'FiraCodeNerdFont',
        ),
        darkTheme: ThemeData.dark(),
        home: MyHomePage(),
        themeMode: ThemeMode.dark,
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

  Future handle(Nvim n, String s, List<dynamic> ar) async {
    for (var arg in ar) {
      unawaited(handler.handleEvent(arg));
    }
  }

  void dostuff() async {
    // Start up Neovim instance, with optional `onNotify` and `onRequest`
    // callbacks.
    // See also Nvim.child()
    nvim = await Nvim.spawn(onNotify: handle, onRequest: handle);
    var opts = UiAttachOptions()
      ..extMessages = true
      ..extMultigrid = true
      ..rgb = true;

    var s = GridUtils.get_grid_dimensions(MediaQuery.of(context).size);

    await nvim.uiAttach(s.width.toInt(), s.height.toInt(), opts.asMap());
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: node,
      autofocus: true,
      onKey: (event) {
        if (event.character != null) {
          nvim.input(event.character!);
        }
      },
      child: Consumer(
        builder: (context, watch, child) {
          watch(editorStateProvider);
          return Scaffold(
            body: WindowStack(),
          );
        },
      ),
    );
  }
}
