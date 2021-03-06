import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../components/feed_detail_dialog.dart';
import '../../core/constants.dart';
import '../../models/favorite_feed.dart';
import '../../models/feed.dart';
import '../../services/favorite_feed_service.dart';

class FavoriteFeedPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: FavoriteFeedService.selectAllSortedByAddedDate(),
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
  final List<FavoriteFeed> feeds;

  @override
  _State createState() => _State();
}

class _State extends State<_Contents> {
  List<FavoriteFeed> searchedFeeds;

  @override
  void initState() {
    super.initState();
    searchedFeeds =  widget.feeds;
  }

  void _search(final String value) async {
    final result = widget.feeds.where(
      (element) => element.feed.title.contains(value)
          || element.feed.description.contains(value)
      ).toList();
    setState(() => searchedFeeds = result);
  }

  void _navigateArticle(final String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
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

  Widget _buildListTile(final FavoriteFeed favoriteFeed) {
    final displayedDescription = favoriteFeed.feed.description.length > 100
        ? "${favoriteFeed.feed.description.substring(0, 100)}..."
        : favoriteFeed.feed.description;
    final genreImageUrl = originalGenres.firstWhere(
      (element) => element.topicCode == favoriteFeed.genre
    ).imgUrl;

    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(genreImageUrl)
      ),
      title: Text(favoriteFeed.feed.title),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Row(
                children: [
                  Icon(Icons.add),
                  Icon(Icons.favorite),
                ],
              ),
              Text(favoriteFeed.addedDate),
            ],
          ),
          Divider(),
          Row(
            children: [
              Icon(Icons.account_circle),
              Text(favoriteFeed.feed.authorName),
            ],
          ),
          Divider(),
          Row(
            children: [
              Icon(Icons.update),
              Text(favoriteFeed.feed.pubDate),
            ],
          ),
          Divider(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.notes),
              Text(displayedDescription),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildAlertDialog(final BuildContext context, final Feed feed) {
    return FeedDetailDialog(
      feed: feed,
      navigate: () => _navigateArticle(feed.link),
      pop: () => Navigator.pop(context)
    );
  }

  Widget _buildCard(final FavoriteFeed favoriteFeed) {
    return Card(
      child: GestureDetector(
        onTap: () => _navigateArticle(favoriteFeed.feed.link),
        onDoubleTap: () => showDialog(
          context: context,
          builder: (_) => _buildAlertDialog(context, favoriteFeed.feed),
        ),
        child: _buildListTile(favoriteFeed)
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