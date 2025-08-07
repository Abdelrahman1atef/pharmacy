import 'dart:convert';
import 'package:sqflite/sqflite.dart';
import '../dbHelper/db_constants.dart';
import '../dbHelper/db_helper.dart';
import '../../models/product/product_response.dart';
import '../../models/category/category_response.dart';

class CacheService {
  static final CacheService _instance = CacheService._internal();
  factory CacheService() => _instance;
  CacheService._internal();

  // Cache products
  Future<void> cacheProducts(
    ProductResponse products,
    int page, {
    int? categoryId,
    String? fetchType,
  }) async {
    final db = await DbHelper.database;
    final now = DateTime.now().millisecondsSinceEpoch;
    final expiresAt = now + productCacheTTL;

    for (final product in products.results) {
      await db.insert(
        cacheProductsTable,
        {
          'product_id': product.id,
          'data': jsonEncode(product.toJson()),
          'page': page,
          'category_id': categoryId,
          'fetch_type': fetchType,
          'created_at': now,
          'expires_at': expiresAt,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  // Get cached products
  Future<ProductResponse?> getCachedProducts(
    int page, {
    int? categoryId,
    String? fetchType,
  }) async {
    final db = await DbHelper.database;
    final now = DateTime.now().millisecondsSinceEpoch;

    // Clean expired cache first
    await db.delete(
      cacheProductsTable,
      where: 'expires_at < ?',
      whereArgs: [now],
    );

    // Get cached products
    final List<Map<String, dynamic>> results = await db.query(
      cacheProductsTable,
      where: 'page = ? AND category_id = ? AND fetch_type = ? AND expires_at > ?',
      whereArgs: [page, categoryId ?? 0, fetchType ?? 'all', now],
    );

    if (results.isEmpty) return null;

    final products = results
        .map((row) => Product.fromJson(jsonDecode(row['data'])))
        .toList();

    return ProductResponse(
      count: products.length,
      next: null, // We'll handle pagination separately
      previous: null,
      results: products,
    );
  }

  // Cache categories
  Future<void> cacheCategories(CategoryResponse categories) async {
    final db = await DbHelper.database;
    final now = DateTime.now().millisecondsSinceEpoch;
    final expiresAt = now + categoryCacheTTL;

    for (final category in categories.results) {
      await db.insert(
        cacheCategoriesTable,
        {
          'category_id': category.id,
          'data': jsonEncode(category.toJson()),
          'created_at': now,
          'expires_at': expiresAt,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  // Get cached categories
  Future<CategoryResponse?> getCachedCategories() async {
    final db = await DbHelper.database;
    final now = DateTime.now().millisecondsSinceEpoch;

    // Clean expired cache first
    await db.delete(
      cacheCategoriesTable,
      where: 'expires_at < ?',
      whereArgs: [now],
    );

    // Get cached categories
    final List<Map<String, dynamic>> results = await db.query(
      cacheCategoriesTable,
      where: 'expires_at > ?',
      whereArgs: [now],
    );

    if (results.isEmpty) return null;

    final categories = results
        .map((row) => Category.fromJson(jsonDecode(row['data'])))
        .toList();

    return CategoryResponse(
      count: categories.length,
      next: null,
      previous: null,
      results: categories,
    );
  }

  // Clear all cache
  Future<void> clearAllCache() async {
    final db = await DbHelper.database;
    await db.delete(cacheProductsTable);
    await db.delete(cacheCategoriesTable);
    await db.delete(cacheMetadataTable);
  }

  // Clear expired cache
  Future<void> clearExpiredCache() async {
    final db = await DbHelper.database;
    final now = DateTime.now().millisecondsSinceEpoch;

    await db.delete(
      cacheProductsTable,
      where: 'expires_at < ?',
      whereArgs: [now],
    );

    await db.delete(
      cacheCategoriesTable,
      where: 'expires_at < ?',
      whereArgs: [now],
    );

    await db.delete(
      cacheMetadataTable,
      where: 'expires_at < ?',
      whereArgs: [now],
    );
  }

  // Get cache statistics
  Future<Map<String, int>> getCacheStats() async {
    final db = await DbHelper.database;
    final now = DateTime.now().millisecondsSinceEpoch;

    final productCount = Sqflite.firstIntValue(
      await db.rawQuery(
        'SELECT COUNT(*) FROM $cacheProductsTable WHERE expires_at > ?',
        [now],
      ),
    ) ?? 0;

    final categoryCount = Sqflite.firstIntValue(
      await db.rawQuery(
        'SELECT COUNT(*) FROM $cacheCategoriesTable WHERE expires_at > ?',
        [now],
      ),
    ) ?? 0;

    return {
      'products': productCount,
      'categories': categoryCount,
    };
  }
} 