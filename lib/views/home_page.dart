import 'package:flutter/material.dart';
import 'genre/genre_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => GenrePage()
            )
          ),
          child: Text("HomePage")
        ),
      ),
    );
  }
}