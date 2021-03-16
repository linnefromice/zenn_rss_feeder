import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:xml2json/xml2json.dart';

import '../../models/favorite_feed.dart';
import '../../models/feed.dart';
import '../../services/favorite_feed_service.dart';

class FeedPage extends StatelessWidget {
  const FeedPage({Key key, this.topicCode}) : super(key: key);
  final String topicCode;

  String _buildPath(final String topicCode) => "/topics/$topicCode/feed";

  Future<List<Feed>> _feed(final String path) async {
    final client = http.Client();
    final transformer = Xml2Json();
    return await client.get(Uri.https('zenn.dev', path)).then((response) {
      return utf8.decode(response.bodyBytes);
    }).then((bodyString) {
      transformer.parse(bodyString);
      final json = transformer.toParker()
          .replaceAll("\\.", ""); // FormatException: Unrecognized string escape -> \.
      final List<dynamic> list = jsonDecode(json)['rss']['channel']['item'];
      return list.map((json) => Feed.fromJsonOfParker(json)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _feed(_buildPath(topicCode)),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          if (snapshot.hasData) {
            return _Contents(
              topicCode: topicCode,
              feeds: snapshot.data
            );
          }
          return Center(child: CircularProgressIndicator());
        }
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_back),
        backgroundColor: Colors.grey,
        onPressed: () => Navigator.of(context).pop()
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class _Contents extends StatefulWidget {
  const _Contents({Key key, this.topicCode, this.feeds}) : super(key: key);
  final String topicCode;
  final List<Feed> feeds;

  @override
  _State createState() => _State();
}

class _State extends State<_Contents> {
  List<Feed> searchedFeeds;

  @override
  void initState() {
    super.initState();
    searchedFeeds =  widget.feeds;
  }

  void _search(final String value) async {
    final result = widget.feeds.where(
      (element) =>
        element.title.contains(value) || element.description.contains(value)
    ).toList();
    setState(() {
      searchedFeeds = result;
    });
  }

  TextField _buildSearchField() {
    return TextField(
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.search),
        contentPadding: EdgeInsets.all(20.0),
        hintText: 'Filter by title or description',
        border: OutlineInputBorder(),
      ),
      onChanged: _search
    );
  }

  Widget _buildListTile(final Feed feed) {
    return ListTile(
      title: Text(feed.title),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("${feed.pubDate} @${feed.authorName}"),
          Text("${feed.description.substring(0, 50)}...")
        ],
      ),
    );
  }

  Widget _buildCard(final Feed feed) {
    return Card(
      child: GestureDetector(
        onTap: () async {
          var url = feed.link;
          if (await canLaunch(url)) {
            await launch(url);
          } else {
            throw 'Could not launch $url';
          }
        },
        onLongPress: () async {
          final favoriteFeed = FavoriteFeed(
            genre: widget.topicCode,
            feed: feed,
            addedDate: DateTime.now().toString()
          );
          await FavoriteFeedService.insert(favoriteFeed);
          ScaffoldMessenger.of(context)
              .showSnackBar(successSnackBar(message: "Add Favorite Feed!!!"));
        },
        onDoubleTap: () => showDialog(
          context: context,
          builder: (_) {
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
                // ボタン領域
                TextButton(
                  child: Text("Move Site"),
                  onPressed: () async {
                    var url = feed.link;
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                ),
                TextButton(
                  child: Text("CLOSE"),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            );
          }
        ),
        child: _buildListTile(feed)
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 50),
        _buildSearchField(),
        Expanded(
          child: ListView.builder(
            itemCount: searchedFeeds.length,
            itemBuilder: (context, index) => _buildCard(searchedFeeds[index]),
          )
        )
      ],
    );
  }
}

SnackBar successSnackBar({final String message}) => SnackBar(
  content: Text(
    message != null ? message : "Success!!",
    textAlign: TextAlign.center,
  ),
  duration: Duration(seconds: 1),
  backgroundColor: Colors.green[200],
);
