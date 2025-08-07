const dbName = "pharmacy.db";
const dbVersion = 3;

// Cache table constants
const cacheTableName = "Cache";
const cacheKeyColumn = "cache_key";
const cacheDataColumn = "cache_data";
const cacheTimestampColumn = "timestamp";
const cacheExpiryColumn = "expiry";

// Cache keys
const String categoriesCacheKey = "categories";
const String bestSellersCacheKey = "best_sellers";
const String seeOurProductsCacheKey = "see_our_products";
const String productsByCategoryCacheKey = "products_by_category_";
const String allProductsCacheKey = "all_products";

// Cache expiry times (in milliseconds)
const int categoriesCacheExpiry = 24 * 60 * 60 * 1000; // 24 hours
const int productsCacheExpiry = 2 * 60 * 60 * 1000; // 2 hours
const int bestSellersCacheExpiry = 4 * 60 * 60 * 1000; // 4 hours
