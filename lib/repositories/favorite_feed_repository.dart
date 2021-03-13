import 'package:linnefromice/core/database_helper.dart';
import 'package:linnefromice/models/feed.dart';

class FavoriteFeedRepository {
  static final _tableName = 'favorite_feed';
  static final _primaryKeyName = 'id';
  static final _orderByColumn = 'addedDate';
  static DatabaseHelper dbHelper = DatabaseHelper.instance;

  static Future<List<Feed>> selectAll() async {
    final List<Map<String, dynamic>> rows = await dbHelper.selectAllRows(_tableName);
    List<Feed> dtos = [];
    rows.forEach((row) => dtos.add(Feed.fromJson(row)));
    return dtos;
  }

  static Future<List<Feed>> selectAllSortedByFromDate() async {
    final List<Map<String, dynamic>> rows = await dbHelper.selectAllRowsOrderBySpecified(_tableName, _orderByColumn);
    List<Feed> dtos = [];
    rows.forEach((row) => dtos.add(Feed.fromJson(row)));
    return dtos;
  }


  static Future<Feed> selectOne(final int id) async {
    final Map<String, dynamic> row = await dbHelper.selectOneRow(
      _primaryKeyName,
      id.toString(),
      _tableName
    );
    if (row == null) {
      return null;
    } else {
      return Feed.fromJson(row);
    }
  }

  static Future<int> insert(final Feed dto) async {
    return await dbHelper.insert(dto.toJson(), _tableName);
  }

  static Future<int> update(final Feed dto) async {
    return await dbHelper.update(
      dto.toJson(),
      _primaryKeyName,
      _tableName
    );
  }

  static Future<int> delete(final int id) async {
    return await dbHelper.delete(_primaryKeyName, id.toString(), _tableName);
  }
}