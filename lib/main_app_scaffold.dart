import 'package:flutter/material.dart';

class MainAppScaffold extends StatefulWidget {
  const MainAppScaffold({Key key, this.child}) : super(key: key);
  final Widget child;

  @override
  _State createState() => _State();
}

class _State extends State<MainAppScaffold> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RSS Feeder for zenn.dev',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: widget.child
    );
  }
}