import 'package:flutter/material.dart';

class Feed {
  final String title;
  final String authorName;
  final String pubDate;
  final String description;
  final String link;

  Feed({
    @required this.title,
    @required this.authorName,
    @required this.pubDate,
    @required this.description,
    @required this.link
  });

  factory Feed.fromJsonOfParker(Map<String, dynamic> json) {
    return Feed(
        title: json['title'],
        authorName: json['dc:creator'],
        pubDate: json['pubDate'],
        description: json['description'].replaceAll("\\\\n", "\n"),
        link: json['link']
    );
  }

  factory Feed.fromJsonOfGData(Map<String, dynamic> json) {
    return Feed(
        title: json['title']['__cdata'],
        authorName: json['dc\$creator']['\$t'],
        pubDate: json['pubDate']['\$t'],
        description: json['description']['__cdata'].replaceAll("\\\\n", "\n"),
        link: json['link']['\$t']
    );
  }
}
