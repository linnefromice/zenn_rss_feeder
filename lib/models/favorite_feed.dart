import 'package:flutter/material.dart';

import 'feed.dart';

class FavoriteFeed {
  int id;
  final String genre;
  final Feed feed;
  final String addedDate;
  int version;

  FavoriteFeed({
    this.id,
    @required this.genre,
    @required this.feed,
    @required this.addedDate,
    this.version,
  });

  factory FavoriteFeed.fromJson(Map<String, dynamic> json) {
    return FavoriteFeed(
      id: json['id'],
      genre: json['genre'],
      addedDate: json['addedDate'],
      feed: Feed.fromJson(json),
      version: json['version']
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "genre": genre,
    "addedDate": addedDate,
    "version": version,
    ...feed.toJson()
  };
}