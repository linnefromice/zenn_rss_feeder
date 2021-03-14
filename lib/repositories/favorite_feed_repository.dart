import 'package:linnefromice/models/favorite_feed.dart';

import '../core/database_helper.dart';
import '../models/feed.dart';

// ignore: avoid_classes_with_only_static_members
class FavoriteFeedRepository {
  static final _tableName = 'favorite_feed';
  static final _primaryKeyName = 'id';
  static final _orderByColumn = 'addedDate';
  static DatabaseHelper dbHelper = DatabaseHelper.instance;

  static Future<List<FavoriteFeed>> selectAll() async {
    final rows = await dbHelper.selectAllRows(_tableName);
    var dtos = <FavoriteFeed>[];
    for (var row in rows) {
      dtos.add(FavoriteFeed.fromJson(row));
    }
    return dtos;
  }

  static Future<List<FavoriteFeed>> selectAllSortedByFromDate() async {
    final rows = await dbHelper.selectAllRowsOrderBySpecified(
      _tableName,
      _orderByColumn
    );
    var dtos = <FavoriteFeed>[];
    for (var row in rows) {
      dtos.add(FavoriteFeed.fromJson(row));
    }
    return dtos;
  }


  static Future<FavoriteFeed> selectOne(final int id) async {
    final row = await dbHelper.selectOneRow(
      _primaryKeyName,
      id.toString(),
      _tableName
    );
    if (row == null) {
      return null;
    } else {
      return FavoriteFeed.fromJson(row);
    }
  }

  static Future<int> insert(final FavoriteFeed dto) async {
    return await dbHelper.insert(dto.toJson(), _tableName);
  }

  static Future<int> update(final FavoriteFeed dto) async {
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