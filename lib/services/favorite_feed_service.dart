import '../models/favorite_feed.dart';
import '../repositories/favorite_feed_repository.dart';

class FavoriteFeedService {
  static Future<List<FavoriteFeed>> selectAllSortedByAddedDate() async {
    return FavoriteFeedRepository.selectAllSortedByAddedDate();
  }

  static Future<int> insert(final FavoriteFeed model) async {
    final recentId = (await FavoriteFeedRepository.selectAll()).length;
    model.id = recentId + 1;
    model.version = 0;
    return FavoriteFeedRepository.insert(model);
  }
}
