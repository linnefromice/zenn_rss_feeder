import 'package:flutter/material.dart';

import '../main_app_scaffold.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MainAppScaffold(
      child: Center(
        child: Text("HomePage"),
      ),
    );
  }
}