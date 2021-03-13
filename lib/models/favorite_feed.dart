import 'package:flutter/cupertino.dart';

import 'feed.dart';

class FavoriteFeed {
  final int id;
  final String genre;
  final Feed feed;
  final String addedDate;

  FavoriteFeed({
    this.id,
    @required this.genre,
    @required this.feed,
    @required this.addedDate
  });

  factory FavoriteFeed.fromJson(Map<String, dynamic> json) {
    return FavoriteFeed(
      id: json['id'],
      genre: json['genre'],
      addedDate: json['addedDate'],
      feed: Feed.fromJson(json)
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "genre": genre,
    "addedDate": addedDate,
    ...feed.toJson()
  };
}