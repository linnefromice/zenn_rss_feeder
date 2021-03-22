import 'package:flutter/material.dart';
import '../models/feed.dart';

class FeedDetailDialog extends StatelessWidget {
  final Feed feed;
  final Function navigate;
  final Function pop;

  FeedDetailDialog({
    Key key,
    @required this.feed,
    @required this.navigate,
    @required this.pop
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        children: [
          Text(feed.title),
          Text("${feed.pubDate} @${feed.authorName}"),
        ],
      ),
      content: SingleChildScrollView(
        child: Text(feed.description),
      ),
      actions: <Widget>[
        TextButton(
          child: Text("Move Site"),
          onPressed: navigate,
        ),
        TextButton(
          child: Text("CLOSE"),
          onPressed: pop,
        ),
      ],
    );
  }
}