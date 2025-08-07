import 'dart:convert';
import 'package:sqflite/sqflite.dart';
import '../dbHelper/db_helper.dart';
import '../dbHelper/db_constants.dart';

class CacheService {
  static final CacheService _instance = CacheService._internal();
  factory CacheService() => _instance;
  CacheService._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await DbHelper().getDbInstance();
    return _database!;
  }

  /// Save data to cache with expiry
  Future<void> saveToCache(String key, dynamic data, int expiryMs) async {
    final db = await database;
    final now = DateTime.now().millisecondsSinceEpoch;
    final expiry = now + expiryMs;
    
    final jsonData = jsonEncode(data);
    
    await db.insert(
      cacheTableName,
      {
        cacheKeyColumn: key,
        cacheDataColumn: jsonData,
        cacheTimestampColumn: now,
        cacheExpiryColumn: expiry,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Get data from cache if not expired
  Future<dynamic> getFromCache(String key) async {
    final db = await database;
    final now = DateTime.now().millisecondsSinceEpoch;
    
    final result = await db.query(
      cacheTableName,
      where: '$cacheKeyColumn = ? AND $cacheExpiryColumn > ?',
      whereArgs: [key, now],
    );

    if (result.isNotEmpty) {
      final jsonData = result.first[cacheDataColumn] as String;
      return jsonDecode(jsonData);
    }
    
    return null;
  }

  /// Check if cache exists and is valid
  Future<bool> hasValidCache(String key) async {
    final data = await getFromCache(key);
    return data != null;
  }

  /// Clear expired cache entries
  Future<void> clearExpiredCache() async {
    final db = await database;
    final now = DateTime.now().millisecondsSinceEpoch;
    
    await db.delete(
      cacheTableName,
      where: '$cacheExpiryColumn <= ?',
      whereArgs: [now],
    );
  }

  /// Clear specific cache entry
  Future<void> clearCache(String key) async {
    final db = await database;
    await db.delete(
      cacheTableName,
      where: '$cacheKeyColumn = ?',
      whereArgs: [key],
    );
  }

  /// Clear all cache
  Future<void> clearAllCache() async {
    final db = await database;
    await db.delete(cacheTableName);
  }

  /// Get cache info (for debugging)
  Future<Map<String, dynamic>> getCacheInfo() async {
    final db = await database;
    final result = await db.query(cacheTableName);
    
    final now = DateTime.now().millisecondsSinceEpoch;
    final validEntries = result.where((entry) => 
      entry[cacheExpiryColumn] as int > now
    ).length;
    
    return {
      'total_entries': result.length,
      'valid_entries': validEntries,
      'expired_entries': result.length - validEntries,
    };
  }
} 