import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:xml2json/xml2json.dart';

import '../../models/feed.dart';

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
      final String json = transformer.toParker()
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
            return _Contents(feeds: snapshot.data);
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
  const _Contents({Key key, this.feeds}) : super(key: key);
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
        child: ListTile(
          title: Text(feed.title),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(feed.authorName),
              Text(feed.pubDate),
              Text(feed.description)
            ],
          ),
        ),
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