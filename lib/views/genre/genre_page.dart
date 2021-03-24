import 'package:flutter/material.dart';
import '../../core/constants.dart';
import '../../models/genre.dart';
import '../favorite_feed/favorite_feed_page.dart';
import '../feed/feed_page.dart';

final String baseUrl = "https://zenn.dev/topics/";
final String suffixForRss = "/feed";

class GenrePage extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<GenrePage> {
  List<Genre> genres = originalGenres;

  void _navigateToFeedPage({
      @required final BuildContext context,
      @required final String topicCode
    }) => Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => FeedPage(
          topicCode: topicCode,
        )
      )
    );

  TextField _buildSearchField() {
    return TextField(
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.search),
        contentPadding: EdgeInsets.all(20.0),
        hintText: 'Filter by genre name',
        border: OutlineInputBorder(),
      ),
      onChanged: (value) => setState(() {
        genres = originalGenres.where(
                (element) => element.name.contains(value)
        ).toList();
      }),
    );
  }

  GridView _buildGridView(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      scrollDirection: Axis.vertical,
      mainAxisSpacing: 4.0,
      children: List.generate(genres.length, (index) {
        return GestureDetector(
          onTap: () => _navigateToFeedPage(
            context: context,
            topicCode: genres[index].topicCode
          ),
          child: Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(genres[index].imgUrl)
                ),
                Text(genres[index].name)
              ],
            )
          ),
        );
      })
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 50),
          _buildSearchField(),
          Expanded(
            child: _buildGridView(context)
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.favorite),
          backgroundColor: Colors.pink,
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => FavoriteFeedPage()
            )
          ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
